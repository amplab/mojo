// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library native_viewport_event_dispatcher_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/input_events.mojom.dart' as input_events_mojom;



class _NativeViewportEventDispatcherOnEventParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  input_events_mojom.Event event = null;

  _NativeViewportEventDispatcherOnEventParams() : super(kVersions.last.size);

  static _NativeViewportEventDispatcherOnEventParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NativeViewportEventDispatcherOnEventParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NativeViewportEventDispatcherOnEventParams result = new _NativeViewportEventDispatcherOnEventParams();

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
      
      var decoder1 = decoder0.decodePointer(8, false);
      result.event = input_events_mojom.Event.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(event, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "event of struct _NativeViewportEventDispatcherOnEventParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_NativeViewportEventDispatcherOnEventParams("
           "event: $event" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["event"] = event;
    return map;
  }
}


class NativeViewportEventDispatcherOnEventResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  NativeViewportEventDispatcherOnEventResponseParams() : super(kVersions.last.size);

  static NativeViewportEventDispatcherOnEventResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NativeViewportEventDispatcherOnEventResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NativeViewportEventDispatcherOnEventResponseParams result = new NativeViewportEventDispatcherOnEventResponseParams();

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
    return result;
  }

  void encode(bindings.Encoder encoder) {
    encoder.getStructEncoderAtOffset(kVersions.last);
  }

  String toString() {
    return "NativeViewportEventDispatcherOnEventResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _nativeViewportEventDispatcherMethodOnEventName = 0;

class _NativeViewportEventDispatcherServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class NativeViewportEventDispatcher {
  static const String serviceName = "mojo::NativeViewportEventDispatcher";
  dynamic onEvent(input_events_mojom.Event event,[Function responseFactory = null]);
}


class _NativeViewportEventDispatcherProxyControl extends bindings.ProxyMessageHandler
                                      implements bindings.ProxyControl {
  _NativeViewportEventDispatcherProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _NativeViewportEventDispatcherProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _NativeViewportEventDispatcherProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _NativeViewportEventDispatcherServiceDescription();

  String get serviceName => NativeViewportEventDispatcher.serviceName;

  @override
  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _nativeViewportEventDispatcherMethodOnEventName:
        var r = NativeViewportEventDispatcherOnEventResponseParams.deserialize(
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

  @override
  String toString() {
    var superString = super.toString();
    return "_NativeViewportEventDispatcherProxyControl($superString)";
  }
}


class NativeViewportEventDispatcherProxy extends bindings.Proxy
                              implements NativeViewportEventDispatcher {
  NativeViewportEventDispatcherProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _NativeViewportEventDispatcherProxyControl.fromEndpoint(endpoint));

  NativeViewportEventDispatcherProxy.fromHandle(core.MojoHandle handle)
      : super(new _NativeViewportEventDispatcherProxyControl.fromHandle(handle));

  NativeViewportEventDispatcherProxy.unbound()
      : super(new _NativeViewportEventDispatcherProxyControl.unbound());

  static NativeViewportEventDispatcherProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NativeViewportEventDispatcherProxy"));
    return new NativeViewportEventDispatcherProxy.fromEndpoint(endpoint);
  }

  factory NativeViewportEventDispatcherProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    NativeViewportEventDispatcherProxy p = new NativeViewportEventDispatcherProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  dynamic onEvent(input_events_mojom.Event event,[Function responseFactory = null]) {
    var params = new _NativeViewportEventDispatcherOnEventParams();
    params.event = event;
    return ctrl.sendMessageWithRequestId(
        params,
        _nativeViewportEventDispatcherMethodOnEventName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}


class NativeViewportEventDispatcherStub extends bindings.Stub {
  NativeViewportEventDispatcher _impl;

  NativeViewportEventDispatcherStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [NativeViewportEventDispatcher impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  NativeViewportEventDispatcherStub.fromHandle(
      core.MojoHandle handle, [NativeViewportEventDispatcher impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  NativeViewportEventDispatcherStub.unbound([this._impl]) : super.unbound();

  static NativeViewportEventDispatcherStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NativeViewportEventDispatcherStub"));
    return new NativeViewportEventDispatcherStub.fromEndpoint(endpoint);
  }


  NativeViewportEventDispatcherOnEventResponseParams _nativeViewportEventDispatcherOnEventResponseParamsFactory() {
    var result = new NativeViewportEventDispatcherOnEventResponseParams();
    return result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    if (_impl == null) {
      throw new core.MojoApiError("$this has no implementation set");
    }
    switch (message.header.type) {
      case _nativeViewportEventDispatcherMethodOnEventName:
        var params = _NativeViewportEventDispatcherOnEventParams.deserialize(
            message.payload);
        var response = _impl.onEvent(params.event,_nativeViewportEventDispatcherOnEventResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _nativeViewportEventDispatcherMethodOnEventName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _nativeViewportEventDispatcherMethodOnEventName,
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

  NativeViewportEventDispatcher get impl => _impl;
  set impl(NativeViewportEventDispatcher d) {
    if (d == null) {
      throw new core.MojoApiError("$this: Cannot set a null implementation");
    }
    if (isBound && (_impl == null)) {
      beginHandlingEvents();
    }
    _impl = d;
  }

  @override
  void bind(core.MojoMessagePipeEndpoint endpoint) {
    super.bind(endpoint);
    if (!isOpen && (_impl != null)) {
      beginHandlingEvents();
    }
  }

  String toString() {
    var superString = super.toString();
    return "NativeViewportEventDispatcherStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _NativeViewportEventDispatcherServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



