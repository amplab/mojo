// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:mojo/application.dart';
import 'package:mojo/bindings.dart';
import 'package:mojo/core.dart';
import 'package:_mojo_for_test_only/test/echo_service.mojom.dart';

class EchoServiceImpl implements EchoService {
  EchoServiceStub _stub;
  Application _application;

  EchoServiceImpl(this._application, MojoMessagePipeEndpoint endpoint) {
    _stub = new EchoServiceStub.fromEndpoint(endpoint, this);
  }

  dynamic echoString(String value, [Function responseFactory]) {
    if (value == "quit") {
      _stub.close();
    }
    return responseFactory(value);
  }

  dynamic delayedEchoString(String value, int millis,
      [Function responseFactory]) {
    if (value == "quit") {
      _stub.close();
    }
    return new Future.delayed(
        new Duration(milliseconds: millis), () => responseFactory(value));
  }

  void swap() {
    _swapImpls(this);
  }

  void quit() {}

  static void _swapImpls(EchoServiceImpl impl) {
    final stub = impl._stub;
    final app = impl._application;
    // It is not allowed to do an unbind in the midst of handling an event, so
    // it is delayed until popping back out to the event loop.
    Timer.run(() {
      final endpoint = stub.unbind();
      new EchoServiceImpl(app, endpoint);
    });
  }
}

class EchoApplication extends Application {
  EchoApplication.fromHandle(MojoHandle handle) : super.fromHandle(handle);

  @override
  void acceptConnection(String requestorUrl, String resolvedUrl,
      ApplicationConnection connection) {
    // No services are required from the remote end.
    connection.remoteServiceProvider.close();
    connection.provideService(EchoService.serviceName,
        (endpoint) => new EchoServiceImpl(this, endpoint));
  }
}

main(List args, Object handleToken) {
  MojoHandle appHandle = new MojoHandle(handleToken);
  new EchoApplication.fromHandle(appHandle)
    ..onError = ((_) {
      MojoHandle.reportLeakedHandles();
    });
}
