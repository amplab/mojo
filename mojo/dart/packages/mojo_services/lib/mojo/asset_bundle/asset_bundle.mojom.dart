// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library asset_bundle_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _AssetBundleGetAsStreamParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String assetName = null;

  _AssetBundleGetAsStreamParams() : super(kVersions.last.size);

  static _AssetBundleGetAsStreamParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _AssetBundleGetAsStreamParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _AssetBundleGetAsStreamParams result = new _AssetBundleGetAsStreamParams();

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
      
      result.assetName = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(assetName, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "assetName of struct _AssetBundleGetAsStreamParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_AssetBundleGetAsStreamParams("
           "assetName: $assetName" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["assetName"] = assetName;
    return map;
  }
}


class AssetBundleGetAsStreamResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  core.MojoDataPipeConsumer assetData = null;

  AssetBundleGetAsStreamResponseParams() : super(kVersions.last.size);

  static AssetBundleGetAsStreamResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static AssetBundleGetAsStreamResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    AssetBundleGetAsStreamResponseParams result = new AssetBundleGetAsStreamResponseParams();

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
      
      result.assetData = decoder0.decodeConsumerHandle(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeConsumerHandle(assetData, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "assetData of struct AssetBundleGetAsStreamResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "AssetBundleGetAsStreamResponseParams("
           "assetData: $assetData" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _AssetUnpackerUnpackZipStreamParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  core.MojoDataPipeConsumer zippedAssets = null;
  Object assetBundle = null;

  _AssetUnpackerUnpackZipStreamParams() : super(kVersions.last.size);

  static _AssetUnpackerUnpackZipStreamParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _AssetUnpackerUnpackZipStreamParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _AssetUnpackerUnpackZipStreamParams result = new _AssetUnpackerUnpackZipStreamParams();

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
      
      result.zippedAssets = decoder0.decodeConsumerHandle(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.assetBundle = decoder0.decodeInterfaceRequest(12, false, AssetBundleStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeConsumerHandle(zippedAssets, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "zippedAssets of struct _AssetUnpackerUnpackZipStreamParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(assetBundle, 12, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "assetBundle of struct _AssetUnpackerUnpackZipStreamParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_AssetUnpackerUnpackZipStreamParams("
           "zippedAssets: $zippedAssets" ", "
           "assetBundle: $assetBundle" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _assetBundleMethodGetAsStreamName = 0;

class _AssetBundleServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class AssetBundle {
  static const String serviceName = "mojo::asset_bundle::AssetBundle";
  dynamic getAsStream(String assetName,[Function responseFactory = null]);
}


class _AssetBundleProxyControl extends bindings.ProxyMessageHandler
                                      implements bindings.ProxyControl {
  _AssetBundleProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _AssetBundleProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _AssetBundleProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _AssetBundleServiceDescription();

  String get serviceName => AssetBundle.serviceName;

  @override
  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _assetBundleMethodGetAsStreamName:
        var r = AssetBundleGetAsStreamResponseParams.deserialize(
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
    return "_AssetBundleProxyControl($superString)";
  }
}


class AssetBundleProxy extends bindings.Proxy
                              implements AssetBundle {
  AssetBundleProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _AssetBundleProxyControl.fromEndpoint(endpoint));

  AssetBundleProxy.fromHandle(core.MojoHandle handle)
      : super(new _AssetBundleProxyControl.fromHandle(handle));

  AssetBundleProxy.unbound()
      : super(new _AssetBundleProxyControl.unbound());

  static AssetBundleProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For AssetBundleProxy"));
    return new AssetBundleProxy.fromEndpoint(endpoint);
  }

  factory AssetBundleProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    AssetBundleProxy p = new AssetBundleProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  dynamic getAsStream(String assetName,[Function responseFactory = null]) {
    var params = new _AssetBundleGetAsStreamParams();
    params.assetName = assetName;
    return ctrl.sendMessageWithRequestId(
        params,
        _assetBundleMethodGetAsStreamName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}


class AssetBundleStub extends bindings.Stub {
  AssetBundle _impl;

  AssetBundleStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [AssetBundle impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  AssetBundleStub.fromHandle(
      core.MojoHandle handle, [AssetBundle impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  AssetBundleStub.unbound([this._impl]) : super.unbound();

  static AssetBundleStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For AssetBundleStub"));
    return new AssetBundleStub.fromEndpoint(endpoint);
  }


  AssetBundleGetAsStreamResponseParams _assetBundleGetAsStreamResponseParamsFactory(core.MojoDataPipeConsumer assetData) {
    var result = new AssetBundleGetAsStreamResponseParams();
    result.assetData = assetData;
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
      case _assetBundleMethodGetAsStreamName:
        var params = _AssetBundleGetAsStreamParams.deserialize(
            message.payload);
        var response = _impl.getAsStream(params.assetName,_assetBundleGetAsStreamResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _assetBundleMethodGetAsStreamName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _assetBundleMethodGetAsStreamName,
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

  AssetBundle get impl => _impl;
  set impl(AssetBundle d) {
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
    return "AssetBundleStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _AssetBundleServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _assetUnpackerMethodUnpackZipStreamName = 0;

class _AssetUnpackerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class AssetUnpacker {
  static const String serviceName = "mojo::asset_bundle::AssetUnpacker";
  void unpackZipStream(core.MojoDataPipeConsumer zippedAssets, Object assetBundle);
}


class _AssetUnpackerProxyControl extends bindings.ProxyMessageHandler
                                      implements bindings.ProxyControl {
  _AssetUnpackerProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _AssetUnpackerProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _AssetUnpackerProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _AssetUnpackerServiceDescription();

  String get serviceName => AssetUnpacker.serviceName;

  @override
  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_AssetUnpackerProxyControl($superString)";
  }
}


class AssetUnpackerProxy extends bindings.Proxy
                              implements AssetUnpacker {
  AssetUnpackerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _AssetUnpackerProxyControl.fromEndpoint(endpoint));

  AssetUnpackerProxy.fromHandle(core.MojoHandle handle)
      : super(new _AssetUnpackerProxyControl.fromHandle(handle));

  AssetUnpackerProxy.unbound()
      : super(new _AssetUnpackerProxyControl.unbound());

  static AssetUnpackerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For AssetUnpackerProxy"));
    return new AssetUnpackerProxy.fromEndpoint(endpoint);
  }

  factory AssetUnpackerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    AssetUnpackerProxy p = new AssetUnpackerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  void unpackZipStream(core.MojoDataPipeConsumer zippedAssets, Object assetBundle) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _AssetUnpackerUnpackZipStreamParams();
    params.zippedAssets = zippedAssets;
    params.assetBundle = assetBundle;
    ctrl.sendMessage(params,
        _assetUnpackerMethodUnpackZipStreamName);
  }
}


class AssetUnpackerStub extends bindings.Stub {
  AssetUnpacker _impl;

  AssetUnpackerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [AssetUnpacker impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  AssetUnpackerStub.fromHandle(
      core.MojoHandle handle, [AssetUnpacker impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  AssetUnpackerStub.unbound([this._impl]) : super.unbound();

  static AssetUnpackerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For AssetUnpackerStub"));
    return new AssetUnpackerStub.fromEndpoint(endpoint);
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
      case _assetUnpackerMethodUnpackZipStreamName:
        var params = _AssetUnpackerUnpackZipStreamParams.deserialize(
            message.payload);
        _impl.unpackZipStream(params.zippedAssets, params.assetBundle);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  AssetUnpacker get impl => _impl;
  set impl(AssetUnpacker d) {
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
    return "AssetUnpackerStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _AssetUnpackerServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



