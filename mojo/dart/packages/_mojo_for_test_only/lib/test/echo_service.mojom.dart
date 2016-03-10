// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library echo_service_mojom;
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _EchoServiceEchoStringParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String value = null;

  _EchoServiceEchoStringParams() : super(kVersions.last.size);

  static _EchoServiceEchoStringParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _EchoServiceEchoStringParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _EchoServiceEchoStringParams result = new _EchoServiceEchoStringParams();

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
      
      result.value = decoder0.decodeString(8, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(value, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "value of struct _EchoServiceEchoStringParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_EchoServiceEchoStringParams("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}


class EchoServiceEchoStringResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String value = null;

  EchoServiceEchoStringResponseParams() : super(kVersions.last.size);

  static EchoServiceEchoStringResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static EchoServiceEchoStringResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    EchoServiceEchoStringResponseParams result = new EchoServiceEchoStringResponseParams();

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
      
      result.value = decoder0.decodeString(8, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(value, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "value of struct EchoServiceEchoStringResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "EchoServiceEchoStringResponseParams("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}


class _EchoServiceDelayedEchoStringParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String value = null;
  int millis = 0;

  _EchoServiceDelayedEchoStringParams() : super(kVersions.last.size);

  static _EchoServiceDelayedEchoStringParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _EchoServiceDelayedEchoStringParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _EchoServiceDelayedEchoStringParams result = new _EchoServiceDelayedEchoStringParams();

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
      
      result.value = decoder0.decodeString(8, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.millis = decoder0.decodeInt32(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(value, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "value of struct _EchoServiceDelayedEchoStringParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(millis, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "millis of struct _EchoServiceDelayedEchoStringParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_EchoServiceDelayedEchoStringParams("
           "value: $value" ", "
           "millis: $millis" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    map["millis"] = millis;
    return map;
  }
}


class EchoServiceDelayedEchoStringResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String value = null;

  EchoServiceDelayedEchoStringResponseParams() : super(kVersions.last.size);

  static EchoServiceDelayedEchoStringResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static EchoServiceDelayedEchoStringResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    EchoServiceDelayedEchoStringResponseParams result = new EchoServiceDelayedEchoStringResponseParams();

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
      
      result.value = decoder0.decodeString(8, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(value, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "value of struct EchoServiceDelayedEchoStringResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "EchoServiceDelayedEchoStringResponseParams("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}


class _EchoServiceQuitParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _EchoServiceQuitParams() : super(kVersions.last.size);

  static _EchoServiceQuitParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _EchoServiceQuitParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _EchoServiceQuitParams result = new _EchoServiceQuitParams();

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
    return "_EchoServiceQuitParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _EchoService_echoStringName = 0;
const int _EchoService_delayedEchoStringName = 1;
const int _EchoService_quitName = 2;

class _EchoServiceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]){
    var interfaceTypeKey = getRuntimeTypeInfo().servicesByName["test::EchoService"].topLevelInterface;
    var userDefinedType = getAllMojomTypeDefinitions()[interfaceTypeKey];
    return responseFactory(userDefinedType.interfaceType);
  }

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
    responseFactory(getAllMojomTypeDefinitions()[typeKey]);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
    responseFactory(getAllMojomTypeDefinitions());
}

abstract class EchoService {
  static const String serviceName = "test::EchoService";
  dynamic echoString(String value,[Function responseFactory = null]);
  dynamic delayedEchoString(String value,int millis,[Function responseFactory = null]);
  void quit();
}


class _EchoServiceProxyImpl extends bindings.Proxy {
  _EchoServiceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _EchoServiceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _EchoServiceProxyImpl.unbound() : super.unbound();

  static _EchoServiceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _EchoServiceProxyImpl"));
    return new _EchoServiceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _EchoServiceServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _EchoService_echoStringName:
        var r = EchoServiceEchoStringResponseParams.deserialize(
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
      case _EchoService_delayedEchoStringName:
        var r = EchoServiceDelayedEchoStringResponseParams.deserialize(
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
    return "_EchoServiceProxyImpl($superString)";
  }
}


class _EchoServiceProxyCalls implements EchoService {
  _EchoServiceProxyImpl _proxyImpl;

  _EchoServiceProxyCalls(this._proxyImpl);
    dynamic echoString(String value,[Function responseFactory = null]) {
      var params = new _EchoServiceEchoStringParams();
      params.value = value;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _EchoService_echoStringName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic delayedEchoString(String value,int millis,[Function responseFactory = null]) {
      var params = new _EchoServiceDelayedEchoStringParams();
      params.value = value;
      params.millis = millis;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _EchoService_delayedEchoStringName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void quit() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _EchoServiceQuitParams();
      _proxyImpl.sendMessage(params, _EchoService_quitName);
    }
}


class EchoServiceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  EchoService ptr;

  EchoServiceProxy(_EchoServiceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _EchoServiceProxyCalls(proxyImpl);

  EchoServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _EchoServiceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _EchoServiceProxyCalls(impl);
  }

  EchoServiceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _EchoServiceProxyImpl.fromHandle(handle) {
    ptr = new _EchoServiceProxyCalls(impl);
  }

  EchoServiceProxy.unbound() :
      impl = new _EchoServiceProxyImpl.unbound() {
    ptr = new _EchoServiceProxyCalls(impl);
  }

  factory EchoServiceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    EchoServiceProxy p = new EchoServiceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static EchoServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For EchoServiceProxy"));
    return new EchoServiceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => EchoService.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "EchoServiceProxy($impl)";
  }
}


class EchoServiceStub extends bindings.Stub {
  EchoService _impl = null;

  EchoServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  EchoServiceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  EchoServiceStub.unbound() : super.unbound();

  static EchoServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For EchoServiceStub"));
    return new EchoServiceStub.fromEndpoint(endpoint);
  }


  EchoServiceEchoStringResponseParams _EchoServiceEchoStringResponseParamsFactory(String value) {
    var mojo_factory_result = new EchoServiceEchoStringResponseParams();
    mojo_factory_result.value = value;
    return mojo_factory_result;
  }
  EchoServiceDelayedEchoStringResponseParams _EchoServiceDelayedEchoStringResponseParamsFactory(String value) {
    var mojo_factory_result = new EchoServiceDelayedEchoStringResponseParams();
    mojo_factory_result.value = value;
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
      case _EchoService_echoStringName:
        var params = _EchoServiceEchoStringParams.deserialize(
            message.payload);
        var response = _impl.echoString(params.value,_EchoServiceEchoStringResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _EchoService_echoStringName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _EchoService_echoStringName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _EchoService_delayedEchoStringName:
        var params = _EchoServiceDelayedEchoStringParams.deserialize(
            message.payload);
        var response = _impl.delayedEchoString(params.value,params.millis,_EchoServiceDelayedEchoStringResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _EchoService_delayedEchoStringName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _EchoService_delayedEchoStringName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _EchoService_quitName:
        _impl.quit();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  EchoService get impl => _impl;
  set impl(EchoService d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "EchoServiceStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _EchoServiceServiceDescription();
    }
    return _cachedServiceDescription;
  }
}


mojom_types.RuntimeTypeInfo getRuntimeTypeInfo() => _runtimeTypeInfo ??
    _initRuntimeTypeInfo();

Map<String, mojom_types.UserDefinedType> getAllMojomTypeDefinitions() {
  return getRuntimeTypeInfo().typeMap;
}

var _runtimeTypeInfo;
mojom_types.RuntimeTypeInfo  _initRuntimeTypeInfo() {
  // serializedRuntimeTypeInfo contains the bytes of the Mojo serialization of
  // a mojom_types.RuntimeTypeInfo struct describing the Mojom types in this
  // file. The string contains the base64 encoding of the gzip-compressed bytes.
  var serializedRuntimeTypeInfo = "H4sIAAAJbogC/5JggAABKH0DSqOLWyDxGYGYA8qXBGJBIC5JLS6xsnJNzsgPTi0qy0xOxaEe3VwDKK0INSskMsA13ts10gpkoB5h84jVh26vAxXMY4TqZ0bSr4BmXwYjhG6A0h5o9oPAfyCYAWWvQBID0RsYsAN0dytg8Sc7krgwEHMDMdQXfom5qUTFH0wfuowE1A704EEPZ5D7uIA4GmQ3EOtn5Oem6heVpuTnZualFunn5mfl6xcXJUMYKYlFJfqJBQUgU4v1QWQ8kFesn5lXklqUlpicWqyfCrQrvhhimR5IUy5R/kB3FyxcRKDxxwANTyYkeWYkfQmsEPoCN4TWQDPnA8x8ZtR48sASd6C4NcAihpwf0IEQNBzBPispysxLx+4vTqgfaB3e6OntAwNl/rbA4W8pqN8R/tYtSi0sBboUu/9hgNb+R89/FmjlGUz+AwN+QGw4wYAGDnFeIAYl0bLEnNJUHOlClE7hAstL9Ewn0tCyCiWdFBfk5xWnjqYTEtOJxgCkE/Ty9AcsnFhQ1VErvcDqC5fUnMTK1BT0YhUjXLgGqFz9QWF+ccDhf1g7B8P/qMXrgOUbCWh4w+trxqGRf0DpRGYA8g+2cGGAupUa4cJIIFz4gJgNiHMzc3Iyi7GHi+Ywyj9K0LYJtvyDVO2M1jsk5BvbQVDvvEBzNxOZ6QZXOPAAMahKCyzNLMGWPrgHqJ55wUCbfosI1M8g/yJXLQOVL2D5ARAAAP//0AoFQPgQAAA=";

  // Deserialize RuntimeTypeInfo
  var bytes = BASE64.decode(serializedRuntimeTypeInfo);
  var unzippedBytes = new ZLibDecoder().convert(bytes);
  var bdata = new ByteData.view(unzippedBytes.buffer);
  var message = new bindings.Message(bdata, null, unzippedBytes.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  return _runtimeTypeInfo;
}
