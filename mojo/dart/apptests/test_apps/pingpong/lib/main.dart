// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:mojo/application.dart';
import 'package:mojo/bindings.dart';
import 'package:mojo/core.dart';

import 'package:_mojo_for_test_only/test/pingpong_service.mojom.dart';

class PingPongClientImpl implements PingPongClient {
  final PingPongClientStub stub;
  Completer _completer;
  int _count;

  PingPongClientImpl.unbound(this._count, this._completer)
      : stub = new PingPongClientStub.unbound() {
    stub.impl = this;
  }

  void pong(int pongValue) {
    if (pongValue == _count) {
      _completer.complete(null);
      stub.close();
    }
  }
}

class PingPongServiceImpl implements PingPongService {
  PingPongServiceStub _stub;
  Application _application;
  PingPongClientProxy _pingPongClient;

  PingPongServiceImpl(this._application, MojoMessagePipeEndpoint endpoint) {
    _stub = new PingPongServiceStub.fromEndpoint(endpoint, this);
  }

  PingPongServiceImpl.fromStub(this._stub) {
    _stub.impl = this;
  }

  void setClient(ProxyBase proxyBase) {
    assert(_pingPongClient == null);
    _pingPongClient = proxyBase;
  }

  void ping(int pingValue) {
    if (_pingPongClient != null) {
      _pingPongClient.ptr.pong(pingValue + 1);
    }
  }

  Future pingTargetUrl(String url, int count,
      [Function responseFactory]) async {
    if (_application == null) {
      return responseFactory(false);
    }
    var completer = new Completer();
    var pingPongService = new PingPongServiceProxy.unbound();
    _application.connectToService(url, pingPongService);

    var pingPongClient = new PingPongClientImpl.unbound(count, completer);
    pingPongService.ptr.setClient(pingPongClient.stub);

    for (var i = 0; i < count; i++) {
      pingPongService.ptr.ping(i);
    }
    await completer.future;
    await pingPongService.close();

    return responseFactory(true);
  }

  Future pingTargetService(ProxyBase proxyBase, int count,
      [Function responseFactory]) async {
    var pingPongService = proxyBase;
    var completer = new Completer();
    var client = new PingPongClientImpl.unbound(count, completer);
    pingPongService.ptr.setClient(client.stub);

    for (var i = 0; i < count; i++) {
      pingPongService.ptr.ping(i);
    }
    await completer.future;
    await pingPongService.close();

    return responseFactory(true);
  }

  getPingPongService(PingPongServiceStub serviceStub) {
    var targetServiceProxy = new PingPongServiceProxy.unbound();
    _application.connectToService(
        "mojo:dart_pingpong_target", targetServiceProxy);

    // Pass along the interface request to another implementation of the
    // service.
    targetServiceProxy.ptr.getPingPongService(serviceStub);
    targetServiceProxy.close();
  }

  void quit() {}
}

class PingPongApplication extends Application {
  PingPongApplication.fromHandle(MojoHandle handle) : super.fromHandle(handle);

  @override
  void acceptConnection(String requestorUrl, String resolvedUrl,
      ApplicationConnection connection) {
    // No services are required from the remote end.
    connection.remoteServiceProvider.close();

    connection.provideService(PingPongService.serviceName,
        (endpoint) => new PingPongServiceImpl(this, endpoint),
        description: PingPongServiceStub.serviceDescription);
  }
}

main(List args, Object handleToken) {
  MojoHandle appHandle = new MojoHandle(handleToken);
  new PingPongApplication.fromHandle(appHandle)
    ..onError = ((_) {
      MojoHandle.reportLeakedHandles();
    });
}
