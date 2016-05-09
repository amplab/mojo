// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library camera_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class Photo extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String uniqueId = null;
  core.MojoDataPipeConsumer content = null;

  Photo() : super(kVersions.last.size);

  static Photo deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Photo decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Photo result = new Photo();

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
      
      result.uniqueId = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.content = decoder0.decodeConsumerHandle(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(uniqueId, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "uniqueId of struct Photo: $e";
      rethrow;
    }
    try {
      encoder0.encodeConsumerHandle(content, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "content of struct Photo: $e";
      rethrow;
    }
  }

  String toString() {
    return "Photo("
           "uniqueId: $uniqueId" ", "
           "content: $content" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _CameraRollServiceUpdateParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _CameraRollServiceUpdateParams() : super(kVersions.last.size);

  static _CameraRollServiceUpdateParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CameraRollServiceUpdateParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CameraRollServiceUpdateParams result = new _CameraRollServiceUpdateParams();

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
    return "_CameraRollServiceUpdateParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _CameraRollServiceGetCountParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _CameraRollServiceGetCountParams() : super(kVersions.last.size);

  static _CameraRollServiceGetCountParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CameraRollServiceGetCountParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CameraRollServiceGetCountParams result = new _CameraRollServiceGetCountParams();

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
    return "_CameraRollServiceGetCountParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class CameraRollServiceGetCountResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int numPhotos = 0;

  CameraRollServiceGetCountResponseParams() : super(kVersions.last.size);

  static CameraRollServiceGetCountResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CameraRollServiceGetCountResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CameraRollServiceGetCountResponseParams result = new CameraRollServiceGetCountResponseParams();

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
      
      result.numPhotos = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(numPhotos, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "numPhotos of struct CameraRollServiceGetCountResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "CameraRollServiceGetCountResponseParams("
           "numPhotos: $numPhotos" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["numPhotos"] = numPhotos;
    return map;
  }
}


class _CameraRollServiceGetPhotoParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int index = 0;

  _CameraRollServiceGetPhotoParams() : super(kVersions.last.size);

  static _CameraRollServiceGetPhotoParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CameraRollServiceGetPhotoParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CameraRollServiceGetPhotoParams result = new _CameraRollServiceGetPhotoParams();

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
      
      result.index = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(index, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "index of struct _CameraRollServiceGetPhotoParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_CameraRollServiceGetPhotoParams("
           "index: $index" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["index"] = index;
    return map;
  }
}


class CameraRollServiceGetPhotoResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Photo photo = null;

  CameraRollServiceGetPhotoResponseParams() : super(kVersions.last.size);

  static CameraRollServiceGetPhotoResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CameraRollServiceGetPhotoResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CameraRollServiceGetPhotoResponseParams result = new CameraRollServiceGetPhotoResponseParams();

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
      
      var decoder1 = decoder0.decodePointer(8, true);
      result.photo = Photo.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(photo, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "photo of struct CameraRollServiceGetPhotoResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "CameraRollServiceGetPhotoResponseParams("
           "photo: $photo" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _CameraServiceGetLatestFrameParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _CameraServiceGetLatestFrameParams() : super(kVersions.last.size);

  static _CameraServiceGetLatestFrameParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CameraServiceGetLatestFrameParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CameraServiceGetLatestFrameParams result = new _CameraServiceGetLatestFrameParams();

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
    return "_CameraServiceGetLatestFrameParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class CameraServiceGetLatestFrameResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  core.MojoDataPipeConsumer content = null;

  CameraServiceGetLatestFrameResponseParams() : super(kVersions.last.size);

  static CameraServiceGetLatestFrameResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CameraServiceGetLatestFrameResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CameraServiceGetLatestFrameResponseParams result = new CameraServiceGetLatestFrameResponseParams();

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
      
      result.content = decoder0.decodeConsumerHandle(8, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeConsumerHandle(content, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "content of struct CameraServiceGetLatestFrameResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "CameraServiceGetLatestFrameResponseParams("
           "content: $content" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _cameraRollServiceMethodUpdateName = 0;
const int _cameraRollServiceMethodGetCountName = 1;
const int _cameraRollServiceMethodGetPhotoName = 2;

class _CameraRollServiceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class CameraRollService {
  static const String serviceName = "mojo::CameraRollService";
  void update();
  dynamic getCount([Function responseFactory = null]);
  dynamic getPhoto(int index,[Function responseFactory = null]);
}


class _CameraRollServiceProxyImpl extends bindings.Proxy {
  _CameraRollServiceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _CameraRollServiceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _CameraRollServiceProxyImpl.unbound() : super.unbound();

  static _CameraRollServiceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _CameraRollServiceProxyImpl"));
    return new _CameraRollServiceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _CameraRollServiceServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _cameraRollServiceMethodGetCountName:
        var r = CameraRollServiceGetCountResponseParams.deserialize(
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
      case _cameraRollServiceMethodGetPhotoName:
        var r = CameraRollServiceGetPhotoResponseParams.deserialize(
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
    return "_CameraRollServiceProxyImpl($superString)";
  }
}


class _CameraRollServiceProxyCalls implements CameraRollService {
  _CameraRollServiceProxyImpl _proxyImpl;

  _CameraRollServiceProxyCalls(this._proxyImpl);
    void update() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _CameraRollServiceUpdateParams();
      _proxyImpl.sendMessage(params, _cameraRollServiceMethodUpdateName);
    }
    dynamic getCount([Function responseFactory = null]) {
      var params = new _CameraRollServiceGetCountParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _cameraRollServiceMethodGetCountName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic getPhoto(int index,[Function responseFactory = null]) {
      var params = new _CameraRollServiceGetPhotoParams();
      params.index = index;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _cameraRollServiceMethodGetPhotoName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class CameraRollServiceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  CameraRollService ptr;

  CameraRollServiceProxy(_CameraRollServiceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _CameraRollServiceProxyCalls(proxyImpl);

  CameraRollServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _CameraRollServiceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _CameraRollServiceProxyCalls(impl);
  }

  CameraRollServiceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _CameraRollServiceProxyImpl.fromHandle(handle) {
    ptr = new _CameraRollServiceProxyCalls(impl);
  }

  CameraRollServiceProxy.unbound() :
      impl = new _CameraRollServiceProxyImpl.unbound() {
    ptr = new _CameraRollServiceProxyCalls(impl);
  }

  factory CameraRollServiceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    CameraRollServiceProxy p = new CameraRollServiceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static CameraRollServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CameraRollServiceProxy"));
    return new CameraRollServiceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => CameraRollService.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "CameraRollServiceProxy($impl)";
  }
}


class CameraRollServiceStub extends bindings.Stub {
  CameraRollService _impl;

  CameraRollServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [CameraRollService impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  CameraRollServiceStub.fromHandle(
      core.MojoHandle handle, [CameraRollService impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  CameraRollServiceStub.unbound([this._impl]) : super.unbound();

  static CameraRollServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CameraRollServiceStub"));
    return new CameraRollServiceStub.fromEndpoint(endpoint);
  }


  CameraRollServiceGetCountResponseParams _cameraRollServiceGetCountResponseParamsFactory(int numPhotos) {
    var result = new CameraRollServiceGetCountResponseParams();
    result.numPhotos = numPhotos;
    return result;
  }
  CameraRollServiceGetPhotoResponseParams _cameraRollServiceGetPhotoResponseParamsFactory(Photo photo) {
    var result = new CameraRollServiceGetPhotoResponseParams();
    result.photo = photo;
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
      case _cameraRollServiceMethodUpdateName:
        _impl.update();
        break;
      case _cameraRollServiceMethodGetCountName:
        var response = _impl.getCount(_cameraRollServiceGetCountResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _cameraRollServiceMethodGetCountName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _cameraRollServiceMethodGetCountName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _cameraRollServiceMethodGetPhotoName:
        var params = _CameraRollServiceGetPhotoParams.deserialize(
            message.payload);
        var response = _impl.getPhoto(params.index,_cameraRollServiceGetPhotoResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _cameraRollServiceMethodGetPhotoName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _cameraRollServiceMethodGetPhotoName,
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

  CameraRollService get impl => _impl;
  set impl(CameraRollService d) {
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
    return "CameraRollServiceStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _CameraRollServiceServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _cameraServiceMethodGetLatestFrameName = 0;

class _CameraServiceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class CameraService {
  static const String serviceName = "mojo::CameraService";
  dynamic getLatestFrame([Function responseFactory = null]);
}


class _CameraServiceProxyImpl extends bindings.Proxy {
  _CameraServiceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _CameraServiceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _CameraServiceProxyImpl.unbound() : super.unbound();

  static _CameraServiceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _CameraServiceProxyImpl"));
    return new _CameraServiceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _CameraServiceServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _cameraServiceMethodGetLatestFrameName:
        var r = CameraServiceGetLatestFrameResponseParams.deserialize(
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
    return "_CameraServiceProxyImpl($superString)";
  }
}


class _CameraServiceProxyCalls implements CameraService {
  _CameraServiceProxyImpl _proxyImpl;

  _CameraServiceProxyCalls(this._proxyImpl);
    dynamic getLatestFrame([Function responseFactory = null]) {
      var params = new _CameraServiceGetLatestFrameParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _cameraServiceMethodGetLatestFrameName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class CameraServiceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  CameraService ptr;

  CameraServiceProxy(_CameraServiceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _CameraServiceProxyCalls(proxyImpl);

  CameraServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _CameraServiceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _CameraServiceProxyCalls(impl);
  }

  CameraServiceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _CameraServiceProxyImpl.fromHandle(handle) {
    ptr = new _CameraServiceProxyCalls(impl);
  }

  CameraServiceProxy.unbound() :
      impl = new _CameraServiceProxyImpl.unbound() {
    ptr = new _CameraServiceProxyCalls(impl);
  }

  factory CameraServiceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    CameraServiceProxy p = new CameraServiceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static CameraServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CameraServiceProxy"));
    return new CameraServiceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => CameraService.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "CameraServiceProxy($impl)";
  }
}


class CameraServiceStub extends bindings.Stub {
  CameraService _impl;

  CameraServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [CameraService impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  CameraServiceStub.fromHandle(
      core.MojoHandle handle, [CameraService impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  CameraServiceStub.unbound([this._impl]) : super.unbound();

  static CameraServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CameraServiceStub"));
    return new CameraServiceStub.fromEndpoint(endpoint);
  }


  CameraServiceGetLatestFrameResponseParams _cameraServiceGetLatestFrameResponseParamsFactory(core.MojoDataPipeConsumer content) {
    var result = new CameraServiceGetLatestFrameResponseParams();
    result.content = content;
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
      case _cameraServiceMethodGetLatestFrameName:
        var response = _impl.getLatestFrame(_cameraServiceGetLatestFrameResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _cameraServiceMethodGetLatestFrameName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _cameraServiceMethodGetLatestFrameName,
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

  CameraService get impl => _impl;
  set impl(CameraService d) {
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
    return "CameraServiceStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _CameraServiceServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



