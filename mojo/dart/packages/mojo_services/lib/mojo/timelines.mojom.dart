// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library timelines_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class TimelineTransform extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  int referenceTime = 0;
  int subjectTime = 0;
  int referenceDelta = 1;
  int subjectDelta = 0;

  TimelineTransform() : super(kVersions.last.size);

  static TimelineTransform deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TimelineTransform decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TimelineTransform result = new TimelineTransform();

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
      
      result.referenceTime = decoder0.decodeInt64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.subjectTime = decoder0.decodeInt64(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.referenceDelta = decoder0.decodeUint32(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.subjectDelta = decoder0.decodeUint32(28);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(referenceTime, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "referenceTime of struct TimelineTransform: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(subjectTime, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "subjectTime of struct TimelineTransform: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(referenceDelta, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "referenceDelta of struct TimelineTransform: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(subjectDelta, 28);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "subjectDelta of struct TimelineTransform: $e";
      rethrow;
    }
  }

  String toString() {
    return "TimelineTransform("
           "referenceTime: $referenceTime" ", "
           "subjectTime: $subjectTime" ", "
           "referenceDelta: $referenceDelta" ", "
           "subjectDelta: $subjectDelta" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["referenceTime"] = referenceTime;
    map["subjectTime"] = subjectTime;
    map["referenceDelta"] = referenceDelta;
    map["subjectDelta"] = subjectDelta;
    return map;
  }
}


class _TimelineConsumerSetTimelineTransformParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(40, 0)
  ];
  int subjectTime = 0;
  int referenceDelta = 0;
  int subjectDelta = 0;
  int effectiveReferenceTime = 0;
  int effectiveSubjectTime = 0;

  _TimelineConsumerSetTimelineTransformParams() : super(kVersions.last.size);

  static _TimelineConsumerSetTimelineTransformParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TimelineConsumerSetTimelineTransformParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TimelineConsumerSetTimelineTransformParams result = new _TimelineConsumerSetTimelineTransformParams();

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
      
      result.subjectTime = decoder0.decodeInt64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.referenceDelta = decoder0.decodeUint32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.subjectDelta = decoder0.decodeUint32(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.effectiveReferenceTime = decoder0.decodeInt64(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.effectiveSubjectTime = decoder0.decodeInt64(32);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(subjectTime, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "subjectTime of struct _TimelineConsumerSetTimelineTransformParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(referenceDelta, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "referenceDelta of struct _TimelineConsumerSetTimelineTransformParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(subjectDelta, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "subjectDelta of struct _TimelineConsumerSetTimelineTransformParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(effectiveReferenceTime, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "effectiveReferenceTime of struct _TimelineConsumerSetTimelineTransformParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(effectiveSubjectTime, 32);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "effectiveSubjectTime of struct _TimelineConsumerSetTimelineTransformParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_TimelineConsumerSetTimelineTransformParams("
           "subjectTime: $subjectTime" ", "
           "referenceDelta: $referenceDelta" ", "
           "subjectDelta: $subjectDelta" ", "
           "effectiveReferenceTime: $effectiveReferenceTime" ", "
           "effectiveSubjectTime: $effectiveSubjectTime" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["subjectTime"] = subjectTime;
    map["referenceDelta"] = referenceDelta;
    map["subjectDelta"] = subjectDelta;
    map["effectiveReferenceTime"] = effectiveReferenceTime;
    map["effectiveSubjectTime"] = effectiveSubjectTime;
    return map;
  }
}


class TimelineConsumerSetTimelineTransformResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool completed = false;

  TimelineConsumerSetTimelineTransformResponseParams() : super(kVersions.last.size);

  static TimelineConsumerSetTimelineTransformResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TimelineConsumerSetTimelineTransformResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TimelineConsumerSetTimelineTransformResponseParams result = new TimelineConsumerSetTimelineTransformResponseParams();

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
      
      result.completed = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(completed, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "completed of struct TimelineConsumerSetTimelineTransformResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "TimelineConsumerSetTimelineTransformResponseParams("
           "completed: $completed" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["completed"] = completed;
    return map;
  }
}

const int _timelineConsumerMethodSetTimelineTransformName = 0;

class _TimelineConsumerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class TimelineConsumer {
  static const String serviceName = null;
  dynamic setTimelineTransform(int subjectTime,int referenceDelta,int subjectDelta,int effectiveReferenceTime,int effectiveSubjectTime,[Function responseFactory = null]);
  static const int kUnspecifiedTime = 9223372036854775807;
}


class _TimelineConsumerProxyImpl extends bindings.Proxy {
  _TimelineConsumerProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _TimelineConsumerProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _TimelineConsumerProxyImpl.unbound() : super.unbound();

  static _TimelineConsumerProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _TimelineConsumerProxyImpl"));
    return new _TimelineConsumerProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _TimelineConsumerServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _timelineConsumerMethodSetTimelineTransformName:
        var r = TimelineConsumerSetTimelineTransformResponseParams.deserialize(
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
    return "_TimelineConsumerProxyImpl($superString)";
  }
}


class _TimelineConsumerProxyCalls implements TimelineConsumer {
  _TimelineConsumerProxyImpl _proxyImpl;

  _TimelineConsumerProxyCalls(this._proxyImpl);
    dynamic setTimelineTransform(int subjectTime,int referenceDelta,int subjectDelta,int effectiveReferenceTime,int effectiveSubjectTime,[Function responseFactory = null]) {
      var params = new _TimelineConsumerSetTimelineTransformParams();
      params.subjectTime = subjectTime;
      params.referenceDelta = referenceDelta;
      params.subjectDelta = subjectDelta;
      params.effectiveReferenceTime = effectiveReferenceTime;
      params.effectiveSubjectTime = effectiveSubjectTime;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _timelineConsumerMethodSetTimelineTransformName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class TimelineConsumerProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  TimelineConsumer ptr;

  TimelineConsumerProxy(_TimelineConsumerProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _TimelineConsumerProxyCalls(proxyImpl);

  TimelineConsumerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _TimelineConsumerProxyImpl.fromEndpoint(endpoint) {
    ptr = new _TimelineConsumerProxyCalls(impl);
  }

  TimelineConsumerProxy.fromHandle(core.MojoHandle handle) :
      impl = new _TimelineConsumerProxyImpl.fromHandle(handle) {
    ptr = new _TimelineConsumerProxyCalls(impl);
  }

  TimelineConsumerProxy.unbound() :
      impl = new _TimelineConsumerProxyImpl.unbound() {
    ptr = new _TimelineConsumerProxyCalls(impl);
  }

  factory TimelineConsumerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    TimelineConsumerProxy p = new TimelineConsumerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static TimelineConsumerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TimelineConsumerProxy"));
    return new TimelineConsumerProxy.fromEndpoint(endpoint);
  }

  String get serviceName => TimelineConsumer.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "TimelineConsumerProxy($impl)";
  }
}


class TimelineConsumerStub extends bindings.Stub {
  TimelineConsumer _impl;

  TimelineConsumerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [TimelineConsumer impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  TimelineConsumerStub.fromHandle(
      core.MojoHandle handle, [TimelineConsumer impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  TimelineConsumerStub.unbound([this._impl]) : super.unbound();

  static TimelineConsumerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TimelineConsumerStub"));
    return new TimelineConsumerStub.fromEndpoint(endpoint);
  }


  TimelineConsumerSetTimelineTransformResponseParams _timelineConsumerSetTimelineTransformResponseParamsFactory(bool completed) {
    var result = new TimelineConsumerSetTimelineTransformResponseParams();
    result.completed = completed;
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
      case _timelineConsumerMethodSetTimelineTransformName:
        var params = _TimelineConsumerSetTimelineTransformParams.deserialize(
            message.payload);
        var response = _impl.setTimelineTransform(params.subjectTime,params.referenceDelta,params.subjectDelta,params.effectiveReferenceTime,params.effectiveSubjectTime,_timelineConsumerSetTimelineTransformResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _timelineConsumerMethodSetTimelineTransformName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _timelineConsumerMethodSetTimelineTransformName,
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

  TimelineConsumer get impl => _impl;
  set impl(TimelineConsumer d) {
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
    return "TimelineConsumerStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _TimelineConsumerServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



