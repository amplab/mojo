// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library notifications_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class NotificationData extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  String title = null;
  String text = null;
  bool playSound = false;
  bool vibrate = false;
  bool setLights = false;

  NotificationData() : super(kVersions.last.size);

  static NotificationData deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NotificationData decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NotificationData result = new NotificationData();

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
      
      result.title = decoder0.decodeString(8, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.text = decoder0.decodeString(16, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.playSound = decoder0.decodeBool(24, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.vibrate = decoder0.decodeBool(24, 1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.setLights = decoder0.decodeBool(24, 2);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(title, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "title of struct NotificationData: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(text, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "text of struct NotificationData: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(playSound, 24, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "playSound of struct NotificationData: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(vibrate, 24, 1);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "vibrate of struct NotificationData: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(setLights, 24, 2);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "setLights of struct NotificationData: $e";
      rethrow;
    }
  }

  String toString() {
    return "NotificationData("
           "title: $title" ", "
           "text: $text" ", "
           "playSound: $playSound" ", "
           "vibrate: $vibrate" ", "
           "setLights: $setLights" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["title"] = title;
    map["text"] = text;
    map["playSound"] = playSound;
    map["vibrate"] = vibrate;
    map["setLights"] = setLights;
    return map;
  }
}


class _NotificationClientOnSelectedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _NotificationClientOnSelectedParams() : super(kVersions.last.size);

  static _NotificationClientOnSelectedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NotificationClientOnSelectedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NotificationClientOnSelectedParams result = new _NotificationClientOnSelectedParams();

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
    return "_NotificationClientOnSelectedParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _NotificationClientOnDismissedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _NotificationClientOnDismissedParams() : super(kVersions.last.size);

  static _NotificationClientOnDismissedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NotificationClientOnDismissedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NotificationClientOnDismissedParams result = new _NotificationClientOnDismissedParams();

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
    return "_NotificationClientOnDismissedParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _NotificationUpdateParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  NotificationData notificationData = null;

  _NotificationUpdateParams() : super(kVersions.last.size);

  static _NotificationUpdateParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NotificationUpdateParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NotificationUpdateParams result = new _NotificationUpdateParams();

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
      result.notificationData = NotificationData.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(notificationData, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "notificationData of struct _NotificationUpdateParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_NotificationUpdateParams("
           "notificationData: $notificationData" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["notificationData"] = notificationData;
    return map;
  }
}


class _NotificationCancelParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _NotificationCancelParams() : super(kVersions.last.size);

  static _NotificationCancelParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NotificationCancelParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NotificationCancelParams result = new _NotificationCancelParams();

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
    return "_NotificationCancelParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _NotificationServicePostParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  NotificationData notificationData = null;
  Object client = null;
  Object notification = null;

  _NotificationServicePostParams() : super(kVersions.last.size);

  static _NotificationServicePostParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NotificationServicePostParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NotificationServicePostParams result = new _NotificationServicePostParams();

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
      result.notificationData = NotificationData.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.client = decoder0.decodeServiceInterface(16, true, NotificationClientProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.notification = decoder0.decodeInterfaceRequest(24, true, NotificationStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(notificationData, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "notificationData of struct _NotificationServicePostParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(client, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "client of struct _NotificationServicePostParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(notification, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "notification of struct _NotificationServicePostParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_NotificationServicePostParams("
           "notificationData: $notificationData" ", "
           "client: $client" ", "
           "notification: $notification" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _notificationClientMethodOnSelectedName = 0;
const int _notificationClientMethodOnDismissedName = 1;

class _NotificationClientServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class NotificationClient {
  static const String serviceName = null;
  void onSelected();
  void onDismissed();
}


class _NotificationClientProxyImpl extends bindings.Proxy {
  _NotificationClientProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _NotificationClientProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _NotificationClientProxyImpl.unbound() : super.unbound();

  static _NotificationClientProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _NotificationClientProxyImpl"));
    return new _NotificationClientProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _NotificationClientServiceDescription();

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
    return "_NotificationClientProxyImpl($superString)";
  }
}


class _NotificationClientProxyCalls implements NotificationClient {
  _NotificationClientProxyImpl _proxyImpl;

  _NotificationClientProxyCalls(this._proxyImpl);
    void onSelected() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _NotificationClientOnSelectedParams();
      _proxyImpl.sendMessage(params, _notificationClientMethodOnSelectedName);
    }
    void onDismissed() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _NotificationClientOnDismissedParams();
      _proxyImpl.sendMessage(params, _notificationClientMethodOnDismissedName);
    }
}


class NotificationClientProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  NotificationClient ptr;

  NotificationClientProxy(_NotificationClientProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _NotificationClientProxyCalls(proxyImpl);

  NotificationClientProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _NotificationClientProxyImpl.fromEndpoint(endpoint) {
    ptr = new _NotificationClientProxyCalls(impl);
  }

  NotificationClientProxy.fromHandle(core.MojoHandle handle) :
      impl = new _NotificationClientProxyImpl.fromHandle(handle) {
    ptr = new _NotificationClientProxyCalls(impl);
  }

  NotificationClientProxy.unbound() :
      impl = new _NotificationClientProxyImpl.unbound() {
    ptr = new _NotificationClientProxyCalls(impl);
  }

  factory NotificationClientProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    NotificationClientProxy p = new NotificationClientProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static NotificationClientProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NotificationClientProxy"));
    return new NotificationClientProxy.fromEndpoint(endpoint);
  }

  String get serviceName => NotificationClient.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "NotificationClientProxy($impl)";
  }
}


class NotificationClientStub extends bindings.Stub {
  NotificationClient _impl;

  NotificationClientStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [NotificationClient impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  NotificationClientStub.fromHandle(
      core.MojoHandle handle, [NotificationClient impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  NotificationClientStub.unbound([this._impl]) : super.unbound();

  static NotificationClientStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NotificationClientStub"));
    return new NotificationClientStub.fromEndpoint(endpoint);
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
      case _notificationClientMethodOnSelectedName:
        _impl.onSelected();
        break;
      case _notificationClientMethodOnDismissedName:
        _impl.onDismissed();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  NotificationClient get impl => _impl;
  set impl(NotificationClient d) {
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
    return "NotificationClientStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _NotificationClientServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _notificationMethodUpdateName = 0;
const int _notificationMethodCancelName = 1;

class _NotificationServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class Notification {
  static const String serviceName = null;
  void update(NotificationData notificationData);
  void cancel();
}


class _NotificationProxyImpl extends bindings.Proxy {
  _NotificationProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _NotificationProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _NotificationProxyImpl.unbound() : super.unbound();

  static _NotificationProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _NotificationProxyImpl"));
    return new _NotificationProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _NotificationServiceDescription();

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
    return "_NotificationProxyImpl($superString)";
  }
}


class _NotificationProxyCalls implements Notification {
  _NotificationProxyImpl _proxyImpl;

  _NotificationProxyCalls(this._proxyImpl);
    void update(NotificationData notificationData) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _NotificationUpdateParams();
      params.notificationData = notificationData;
      _proxyImpl.sendMessage(params, _notificationMethodUpdateName);
    }
    void cancel() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _NotificationCancelParams();
      _proxyImpl.sendMessage(params, _notificationMethodCancelName);
    }
}


class NotificationProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  Notification ptr;

  NotificationProxy(_NotificationProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _NotificationProxyCalls(proxyImpl);

  NotificationProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _NotificationProxyImpl.fromEndpoint(endpoint) {
    ptr = new _NotificationProxyCalls(impl);
  }

  NotificationProxy.fromHandle(core.MojoHandle handle) :
      impl = new _NotificationProxyImpl.fromHandle(handle) {
    ptr = new _NotificationProxyCalls(impl);
  }

  NotificationProxy.unbound() :
      impl = new _NotificationProxyImpl.unbound() {
    ptr = new _NotificationProxyCalls(impl);
  }

  factory NotificationProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    NotificationProxy p = new NotificationProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static NotificationProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NotificationProxy"));
    return new NotificationProxy.fromEndpoint(endpoint);
  }

  String get serviceName => Notification.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "NotificationProxy($impl)";
  }
}


class NotificationStub extends bindings.Stub {
  Notification _impl;

  NotificationStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [Notification impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  NotificationStub.fromHandle(
      core.MojoHandle handle, [Notification impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  NotificationStub.unbound([this._impl]) : super.unbound();

  static NotificationStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NotificationStub"));
    return new NotificationStub.fromEndpoint(endpoint);
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
      case _notificationMethodUpdateName:
        var params = _NotificationUpdateParams.deserialize(
            message.payload);
        _impl.update(params.notificationData);
        break;
      case _notificationMethodCancelName:
        _impl.cancel();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  Notification get impl => _impl;
  set impl(Notification d) {
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
    return "NotificationStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _NotificationServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _notificationServiceMethodPostName = 0;

class _NotificationServiceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class NotificationService {
  static const String serviceName = "notifications::NotificationService";
  void post(NotificationData notificationData, Object client, Object notification);
}


class _NotificationServiceProxyImpl extends bindings.Proxy {
  _NotificationServiceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _NotificationServiceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _NotificationServiceProxyImpl.unbound() : super.unbound();

  static _NotificationServiceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _NotificationServiceProxyImpl"));
    return new _NotificationServiceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _NotificationServiceServiceDescription();

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
    return "_NotificationServiceProxyImpl($superString)";
  }
}


class _NotificationServiceProxyCalls implements NotificationService {
  _NotificationServiceProxyImpl _proxyImpl;

  _NotificationServiceProxyCalls(this._proxyImpl);
    void post(NotificationData notificationData, Object client, Object notification) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _NotificationServicePostParams();
      params.notificationData = notificationData;
      params.client = client;
      params.notification = notification;
      _proxyImpl.sendMessage(params, _notificationServiceMethodPostName);
    }
}


class NotificationServiceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  NotificationService ptr;

  NotificationServiceProxy(_NotificationServiceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _NotificationServiceProxyCalls(proxyImpl);

  NotificationServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _NotificationServiceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _NotificationServiceProxyCalls(impl);
  }

  NotificationServiceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _NotificationServiceProxyImpl.fromHandle(handle) {
    ptr = new _NotificationServiceProxyCalls(impl);
  }

  NotificationServiceProxy.unbound() :
      impl = new _NotificationServiceProxyImpl.unbound() {
    ptr = new _NotificationServiceProxyCalls(impl);
  }

  factory NotificationServiceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    NotificationServiceProxy p = new NotificationServiceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static NotificationServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NotificationServiceProxy"));
    return new NotificationServiceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => NotificationService.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "NotificationServiceProxy($impl)";
  }
}


class NotificationServiceStub extends bindings.Stub {
  NotificationService _impl;

  NotificationServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [NotificationService impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  NotificationServiceStub.fromHandle(
      core.MojoHandle handle, [NotificationService impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  NotificationServiceStub.unbound([this._impl]) : super.unbound();

  static NotificationServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NotificationServiceStub"));
    return new NotificationServiceStub.fromEndpoint(endpoint);
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
      case _notificationServiceMethodPostName:
        var params = _NotificationServicePostParams.deserialize(
            message.payload);
        _impl.post(params.notificationData, params.client, params.notification);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  NotificationService get impl => _impl;
  set impl(NotificationService d) {
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
    return "NotificationServiceStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _NotificationServiceServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



