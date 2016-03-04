// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library sensors_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;

class SensorType extends bindings.MojoEnum {
  static const SensorType accelerometer = const SensorType._(0);
  static const SensorType ambientTemperature = const SensorType._(1);
  static const SensorType gameRotationVector = const SensorType._(2);
  static const SensorType geomagneticRotationVector = const SensorType._(3);
  static const SensorType gravity = const SensorType._(4);
  static const SensorType gyroscope = const SensorType._(5);
  static const SensorType gyroscopeUncalibrated = const SensorType._(6);
  static const SensorType heartRate = const SensorType._(7);
  static const SensorType light = const SensorType._(8);
  static const SensorType linearAcceleration = const SensorType._(9);
  static const SensorType magneticField = const SensorType._(10);
  static const SensorType magneticFieldUncalibrated = const SensorType._(11);
  static const SensorType pressure = const SensorType._(12);
  static const SensorType proximity = const SensorType._(13);
  static const SensorType relativeHumidity = const SensorType._(14);
  static const SensorType rotationVector = const SensorType._(15);
  static const SensorType significantMotion = const SensorType._(16);
  static const SensorType stepCounter = const SensorType._(17);
  static const SensorType stepDetector = const SensorType._(18);

  const SensorType._(int v) : super(v);

  static const Map<String, SensorType> valuesMap = const {
    "accelerometer": accelerometer,
    "ambientTemperature": ambientTemperature,
    "gameRotationVector": gameRotationVector,
    "geomagneticRotationVector": geomagneticRotationVector,
    "gravity": gravity,
    "gyroscope": gyroscope,
    "gyroscopeUncalibrated": gyroscopeUncalibrated,
    "heartRate": heartRate,
    "light": light,
    "linearAcceleration": linearAcceleration,
    "magneticField": magneticField,
    "magneticFieldUncalibrated": magneticFieldUncalibrated,
    "pressure": pressure,
    "proximity": proximity,
    "relativeHumidity": relativeHumidity,
    "rotationVector": rotationVector,
    "significantMotion": significantMotion,
    "stepCounter": stepCounter,
    "stepDetector": stepDetector,
  };
  static const List<SensorType> values = const [
    accelerometer,
    ambientTemperature,
    gameRotationVector,
    geomagneticRotationVector,
    gravity,
    gyroscope,
    gyroscopeUncalibrated,
    heartRate,
    light,
    linearAcceleration,
    magneticField,
    magneticFieldUncalibrated,
    pressure,
    proximity,
    relativeHumidity,
    rotationVector,
    significantMotion,
    stepCounter,
    stepDetector,
  ];

  static SensorType valueOf(String name) => valuesMap[name];

  factory SensorType(int v) {
    switch (v) {
      case 0:
        return SensorType.accelerometer;
      case 1:
        return SensorType.ambientTemperature;
      case 2:
        return SensorType.gameRotationVector;
      case 3:
        return SensorType.geomagneticRotationVector;
      case 4:
        return SensorType.gravity;
      case 5:
        return SensorType.gyroscope;
      case 6:
        return SensorType.gyroscopeUncalibrated;
      case 7:
        return SensorType.heartRate;
      case 8:
        return SensorType.light;
      case 9:
        return SensorType.linearAcceleration;
      case 10:
        return SensorType.magneticField;
      case 11:
        return SensorType.magneticFieldUncalibrated;
      case 12:
        return SensorType.pressure;
      case 13:
        return SensorType.proximity;
      case 14:
        return SensorType.relativeHumidity;
      case 15:
        return SensorType.rotationVector;
      case 16:
        return SensorType.significantMotion;
      case 17:
        return SensorType.stepCounter;
      case 18:
        return SensorType.stepDetector;
      default:
        return null;
    }
  }

  static SensorType decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    SensorType result = new SensorType(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum SensorType.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case accelerometer:
        return 'SensorType.accelerometer';
      case ambientTemperature:
        return 'SensorType.ambientTemperature';
      case gameRotationVector:
        return 'SensorType.gameRotationVector';
      case geomagneticRotationVector:
        return 'SensorType.geomagneticRotationVector';
      case gravity:
        return 'SensorType.gravity';
      case gyroscope:
        return 'SensorType.gyroscope';
      case gyroscopeUncalibrated:
        return 'SensorType.gyroscopeUncalibrated';
      case heartRate:
        return 'SensorType.heartRate';
      case light:
        return 'SensorType.light';
      case linearAcceleration:
        return 'SensorType.linearAcceleration';
      case magneticField:
        return 'SensorType.magneticField';
      case magneticFieldUncalibrated:
        return 'SensorType.magneticFieldUncalibrated';
      case pressure:
        return 'SensorType.pressure';
      case proximity:
        return 'SensorType.proximity';
      case relativeHumidity:
        return 'SensorType.relativeHumidity';
      case rotationVector:
        return 'SensorType.rotationVector';
      case significantMotion:
        return 'SensorType.significantMotion';
      case stepCounter:
        return 'SensorType.stepCounter';
      case stepDetector:
        return 'SensorType.stepDetector';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}



class SensorData extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  int accuracy = 0;
  int timeStamp = 0;
  List<double> values = null;

  SensorData() : super(kVersions.last.size);

  static SensorData deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SensorData decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SensorData result = new SensorData();

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
      
      result.accuracy = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.timeStamp = decoder0.decodeInt64(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.values = decoder0.decodeFloatArray(24, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(accuracy, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "accuracy of struct SensorData: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(timeStamp, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "timeStamp of struct SensorData: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloatArray(values, 24, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "values of struct SensorData: $e";
      rethrow;
    }
  }

  String toString() {
    return "SensorData("
           "accuracy: $accuracy" ", "
           "timeStamp: $timeStamp" ", "
           "values: $values" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["accuracy"] = accuracy;
    map["timeStamp"] = timeStamp;
    map["values"] = values;
    return map;
  }
}


class _SensorListenerOnAccuracyChangedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int accuracy = 0;

  _SensorListenerOnAccuracyChangedParams() : super(kVersions.last.size);

  static _SensorListenerOnAccuracyChangedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SensorListenerOnAccuracyChangedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SensorListenerOnAccuracyChangedParams result = new _SensorListenerOnAccuracyChangedParams();

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
      
      result.accuracy = decoder0.decodeInt32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(accuracy, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "accuracy of struct _SensorListenerOnAccuracyChangedParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_SensorListenerOnAccuracyChangedParams("
           "accuracy: $accuracy" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["accuracy"] = accuracy;
    return map;
  }
}


class _SensorListenerOnSensorChangedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  SensorData data = null;

  _SensorListenerOnSensorChangedParams() : super(kVersions.last.size);

  static _SensorListenerOnSensorChangedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SensorListenerOnSensorChangedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SensorListenerOnSensorChangedParams result = new _SensorListenerOnSensorChangedParams();

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
      result.data = SensorData.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(data, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "data of struct _SensorListenerOnSensorChangedParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_SensorListenerOnSensorChangedParams("
           "data: $data" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["data"] = data;
    return map;
  }
}


class _SensorServiceAddListenerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  SensorType type = null;
  Object listener = null;

  _SensorServiceAddListenerParams() : super(kVersions.last.size);

  static _SensorServiceAddListenerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SensorServiceAddListenerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SensorServiceAddListenerParams result = new _SensorServiceAddListenerParams();

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
      
        result.type = SensorType.decode(decoder0, 8);
        if (result.type == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable SensorType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.listener = decoder0.decodeServiceInterface(12, false, SensorListenerProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(type, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "type of struct _SensorServiceAddListenerParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(listener, 12, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "listener of struct _SensorServiceAddListenerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_SensorServiceAddListenerParams("
           "type: $type" ", "
           "listener: $listener" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _SensorListener_onAccuracyChangedName = 0;
const int _SensorListener_onSensorChangedName = 1;

class _SensorListenerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class SensorListener {
  static const String serviceName = null;
  void onAccuracyChanged(int accuracy);
  void onSensorChanged(SensorData data);
}


class _SensorListenerProxyImpl extends bindings.Proxy {
  _SensorListenerProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _SensorListenerProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _SensorListenerProxyImpl.unbound() : super.unbound();

  static _SensorListenerProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _SensorListenerProxyImpl"));
    return new _SensorListenerProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _SensorListenerServiceDescription();

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
    return "_SensorListenerProxyImpl($superString)";
  }
}


class _SensorListenerProxyCalls implements SensorListener {
  _SensorListenerProxyImpl _proxyImpl;

  _SensorListenerProxyCalls(this._proxyImpl);
    void onAccuracyChanged(int accuracy) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _SensorListenerOnAccuracyChangedParams();
      params.accuracy = accuracy;
      _proxyImpl.sendMessage(params, _SensorListener_onAccuracyChangedName);
    }
    void onSensorChanged(SensorData data) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _SensorListenerOnSensorChangedParams();
      params.data = data;
      _proxyImpl.sendMessage(params, _SensorListener_onSensorChangedName);
    }
}


class SensorListenerProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  SensorListener ptr;

  SensorListenerProxy(_SensorListenerProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _SensorListenerProxyCalls(proxyImpl);

  SensorListenerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _SensorListenerProxyImpl.fromEndpoint(endpoint) {
    ptr = new _SensorListenerProxyCalls(impl);
  }

  SensorListenerProxy.fromHandle(core.MojoHandle handle) :
      impl = new _SensorListenerProxyImpl.fromHandle(handle) {
    ptr = new _SensorListenerProxyCalls(impl);
  }

  SensorListenerProxy.unbound() :
      impl = new _SensorListenerProxyImpl.unbound() {
    ptr = new _SensorListenerProxyCalls(impl);
  }

  factory SensorListenerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    SensorListenerProxy p = new SensorListenerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static SensorListenerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SensorListenerProxy"));
    return new SensorListenerProxy.fromEndpoint(endpoint);
  }

  String get serviceName => SensorListener.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "SensorListenerProxy($impl)";
  }
}


class SensorListenerStub extends bindings.Stub {
  SensorListener _impl = null;

  SensorListenerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  SensorListenerStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  SensorListenerStub.unbound() : super.unbound();

  static SensorListenerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SensorListenerStub"));
    return new SensorListenerStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _SensorListener_onAccuracyChangedName:
        var params = _SensorListenerOnAccuracyChangedParams.deserialize(
            message.payload);
        _impl.onAccuracyChanged(params.accuracy);
        break;
      case _SensorListener_onSensorChangedName:
        var params = _SensorListenerOnSensorChangedParams.deserialize(
            message.payload);
        _impl.onSensorChanged(params.data);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  SensorListener get impl => _impl;
  set impl(SensorListener d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "SensorListenerStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _SensorListenerServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _SensorService_addListenerName = 0;

class _SensorServiceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class SensorService {
  static const String serviceName = "sensors::SensorService";
  void addListener(SensorType type, Object listener);
}


class _SensorServiceProxyImpl extends bindings.Proxy {
  _SensorServiceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _SensorServiceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _SensorServiceProxyImpl.unbound() : super.unbound();

  static _SensorServiceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _SensorServiceProxyImpl"));
    return new _SensorServiceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _SensorServiceServiceDescription();

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
    return "_SensorServiceProxyImpl($superString)";
  }
}


class _SensorServiceProxyCalls implements SensorService {
  _SensorServiceProxyImpl _proxyImpl;

  _SensorServiceProxyCalls(this._proxyImpl);
    void addListener(SensorType type, Object listener) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _SensorServiceAddListenerParams();
      params.type = type;
      params.listener = listener;
      _proxyImpl.sendMessage(params, _SensorService_addListenerName);
    }
}


class SensorServiceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  SensorService ptr;

  SensorServiceProxy(_SensorServiceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _SensorServiceProxyCalls(proxyImpl);

  SensorServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _SensorServiceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _SensorServiceProxyCalls(impl);
  }

  SensorServiceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _SensorServiceProxyImpl.fromHandle(handle) {
    ptr = new _SensorServiceProxyCalls(impl);
  }

  SensorServiceProxy.unbound() :
      impl = new _SensorServiceProxyImpl.unbound() {
    ptr = new _SensorServiceProxyCalls(impl);
  }

  factory SensorServiceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    SensorServiceProxy p = new SensorServiceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static SensorServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SensorServiceProxy"));
    return new SensorServiceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => SensorService.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "SensorServiceProxy($impl)";
  }
}


class SensorServiceStub extends bindings.Stub {
  SensorService _impl = null;

  SensorServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  SensorServiceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  SensorServiceStub.unbound() : super.unbound();

  static SensorServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SensorServiceStub"));
    return new SensorServiceStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _SensorService_addListenerName:
        var params = _SensorServiceAddListenerParams.deserialize(
            message.payload);
        _impl.addListener(params.type, params.listener);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  SensorService get impl => _impl;
  set impl(SensorService d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "SensorServiceStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _SensorServiceServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



