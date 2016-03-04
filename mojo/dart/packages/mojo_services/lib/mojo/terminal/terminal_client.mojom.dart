// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library terminal_client_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/files/file.mojom.dart' as file_mojom;



class _TerminalClientConnectToTerminalParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object terminal = null;

  _TerminalClientConnectToTerminalParams() : super(kVersions.last.size);

  static _TerminalClientConnectToTerminalParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TerminalClientConnectToTerminalParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TerminalClientConnectToTerminalParams result = new _TerminalClientConnectToTerminalParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.terminal = decoder0.decodeServiceInterface(8, false, file_mojom.FileProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(terminal, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "terminal of struct _TerminalClientConnectToTerminalParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_TerminalClientConnectToTerminalParams("
           "terminal: $terminal" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _TerminalClient_connectToTerminalName = 0;

class _TerminalClientServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class TerminalClient {
  static const String serviceName = "mojo::terminal::TerminalClient";
  void connectToTerminal(Object terminal);
}


class _TerminalClientProxyImpl extends bindings.Proxy {
  _TerminalClientProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _TerminalClientProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _TerminalClientProxyImpl.unbound() : super.unbound();

  static _TerminalClientProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _TerminalClientProxyImpl"));
    return new _TerminalClientProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _TerminalClientServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  String toString() {
    var superString = super.toString();
    return "_TerminalClientProxyImpl($superString)";
  }
}


class _TerminalClientProxyCalls implements TerminalClient {
  _TerminalClientProxyImpl _proxyImpl;

  _TerminalClientProxyCalls(this._proxyImpl);
    void connectToTerminal(Object terminal) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _TerminalClientConnectToTerminalParams();
      params.terminal = terminal;
      _proxyImpl.sendMessage(params, _TerminalClient_connectToTerminalName);
    }
}


class TerminalClientProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  TerminalClient ptr;

  TerminalClientProxy(_TerminalClientProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _TerminalClientProxyCalls(proxyImpl);

  TerminalClientProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _TerminalClientProxyImpl.fromEndpoint(endpoint) {
    ptr = new _TerminalClientProxyCalls(impl);
  }

  TerminalClientProxy.fromHandle(core.MojoHandle handle) :
      impl = new _TerminalClientProxyImpl.fromHandle(handle) {
    ptr = new _TerminalClientProxyCalls(impl);
  }

  TerminalClientProxy.unbound() :
      impl = new _TerminalClientProxyImpl.unbound() {
    ptr = new _TerminalClientProxyCalls(impl);
  }

  factory TerminalClientProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    TerminalClientProxy p = new TerminalClientProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static TerminalClientProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TerminalClientProxy"));
    return new TerminalClientProxy.fromEndpoint(endpoint);
  }

  String get serviceName => TerminalClient.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "TerminalClientProxy($impl)";
  }
}


class TerminalClientStub extends bindings.Stub {
  TerminalClient _impl = null;

  TerminalClientStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  TerminalClientStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  TerminalClientStub.unbound() : super.unbound();

  static TerminalClientStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TerminalClientStub"));
    return new TerminalClientStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _TerminalClient_connectToTerminalName:
        var params = _TerminalClientConnectToTerminalParams.deserialize(
            message.payload);
        _impl.connectToTerminal(params.terminal);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  TerminalClient get impl => _impl;
  set impl(TerminalClient d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "TerminalClientStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _TerminalClientServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



