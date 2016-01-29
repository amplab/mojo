// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library context_provider_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/command_buffer.mojom.dart' as command_buffer_mojom;
import 'package:mojo_services/mojo/viewport_parameter_listener.mojom.dart' as viewport_parameter_listener_mojom;



class _ContextProviderCreateParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object viewportParameterListener = null;

  _ContextProviderCreateParams() : super(kVersions.last.size);

  static _ContextProviderCreateParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ContextProviderCreateParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ContextProviderCreateParams result = new _ContextProviderCreateParams();

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
      
      result.viewportParameterListener = decoder0.decodeServiceInterface(8, true, viewport_parameter_listener_mojom.ViewportParameterListenerProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterface(viewportParameterListener, 8, true);
  }

  String toString() {
    return "_ContextProviderCreateParams("
           "viewportParameterListener: $viewportParameterListener" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




class ContextProviderCreateResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object gles2Client = null;

  ContextProviderCreateResponseParams() : super(kVersions.last.size);

  static ContextProviderCreateResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ContextProviderCreateResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ContextProviderCreateResponseParams result = new ContextProviderCreateResponseParams();

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
      
      result.gles2Client = decoder0.decodeServiceInterface(8, true, command_buffer_mojom.CommandBufferProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterface(gles2Client, 8, true);
  }

  String toString() {
    return "ContextProviderCreateResponseParams("
           "gles2Client: $gles2Client" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




const int _ContextProvider_createName = 0;



class _ContextProviderServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class ContextProvider {
  static const String serviceName = null;
  dynamic create(Object viewportParameterListener,[Function responseFactory = null]);
}


class _ContextProviderProxyImpl extends bindings.Proxy {
  _ContextProviderProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ContextProviderProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ContextProviderProxyImpl.unbound() : super.unbound();

  static _ContextProviderProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ContextProviderProxyImpl"));
    return new _ContextProviderProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ContextProviderServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _ContextProvider_createName:
        var r = ContextProviderCreateResponseParams.deserialize(
            message.payload);
        if (!message.header.hasRequestId) {
          proxyError("Expected a message with a valid request Id.");
          return;
        }
        Completer c = completerMap[message.header.requestId];
        if (c == null) {
          proxyError(
              "Message had unknown request Id: ${message.header.requestId}");
          return;
        }
        completerMap.remove(message.header.requestId);
        if (c.isCompleted) {
          proxyError("Response completer already completed");
          return;
        }
        c.complete(r);
        break;
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  String toString() {
    var superString = super.toString();
    return "_ContextProviderProxyImpl($superString)";
  }
}


class _ContextProviderProxyCalls implements ContextProvider {
  _ContextProviderProxyImpl _proxyImpl;

  _ContextProviderProxyCalls(this._proxyImpl);
    dynamic create(Object viewportParameterListener,[Function responseFactory = null]) {
      var params = new _ContextProviderCreateParams();
      params.viewportParameterListener = viewportParameterListener;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _ContextProvider_createName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class ContextProviderProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ContextProvider ptr;

  ContextProviderProxy(_ContextProviderProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ContextProviderProxyCalls(proxyImpl);

  ContextProviderProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ContextProviderProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ContextProviderProxyCalls(impl);
  }

  ContextProviderProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ContextProviderProxyImpl.fromHandle(handle) {
    ptr = new _ContextProviderProxyCalls(impl);
  }

  ContextProviderProxy.unbound() :
      impl = new _ContextProviderProxyImpl.unbound() {
    ptr = new _ContextProviderProxyCalls(impl);
  }

  factory ContextProviderProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ContextProviderProxy p = new ContextProviderProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ContextProviderProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ContextProviderProxy"));
    return new ContextProviderProxy.fromEndpoint(endpoint);
  }

  String get serviceName => ContextProvider.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ContextProviderProxy($impl)";
  }
}


class ContextProviderStub extends bindings.Stub {
  ContextProvider _impl = null;

  ContextProviderStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ContextProviderStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ContextProviderStub.unbound() : super.unbound();

  static ContextProviderStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ContextProviderStub"));
    return new ContextProviderStub.fromEndpoint(endpoint);
  }


  ContextProviderCreateResponseParams _ContextProviderCreateResponseParamsFactory(Object gles2Client) {
    var mojo_factory_result = new ContextProviderCreateResponseParams();
    mojo_factory_result.gles2Client = gles2Client;
    return mojo_factory_result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _ContextProvider_createName:
        var params = _ContextProviderCreateParams.deserialize(
            message.payload);
        var response = _impl.create(params.viewportParameterListener,_ContextProviderCreateResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _ContextProvider_createName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _ContextProvider_createName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  ContextProvider get impl => _impl;
  set impl(ContextProvider d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ContextProviderStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _ContextProviderServiceDescription();
}



