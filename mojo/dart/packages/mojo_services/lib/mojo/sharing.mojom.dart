// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library sharing_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _SharingServiceShareTextParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String text = null;

  _SharingServiceShareTextParams() : super(kVersions.last.size);

  static _SharingServiceShareTextParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SharingServiceShareTextParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SharingServiceShareTextParams result = new _SharingServiceShareTextParams();

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
      
      result.text = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(text, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "text of struct _SharingServiceShareTextParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_SharingServiceShareTextParams("
           "text: $text" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["text"] = text;
    return map;
  }
}




const int _SharingService_shareTextName = 0;



class _SharingServiceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class SharingService {
  static const String serviceName = "mojo::SharingService";
  void shareText(String text);
}


class _SharingServiceProxyImpl extends bindings.Proxy {
  _SharingServiceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _SharingServiceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _SharingServiceProxyImpl.unbound() : super.unbound();

  static _SharingServiceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _SharingServiceProxyImpl"));
    return new _SharingServiceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _SharingServiceServiceDescription();

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
    return "_SharingServiceProxyImpl($superString)";
  }
}


class _SharingServiceProxyCalls implements SharingService {
  _SharingServiceProxyImpl _proxyImpl;

  _SharingServiceProxyCalls(this._proxyImpl);
    void shareText(String text) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _SharingServiceShareTextParams();
      params.text = text;
      _proxyImpl.sendMessage(params, _SharingService_shareTextName);
    }
}


class SharingServiceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  SharingService ptr;

  SharingServiceProxy(_SharingServiceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _SharingServiceProxyCalls(proxyImpl);

  SharingServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _SharingServiceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _SharingServiceProxyCalls(impl);
  }

  SharingServiceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _SharingServiceProxyImpl.fromHandle(handle) {
    ptr = new _SharingServiceProxyCalls(impl);
  }

  SharingServiceProxy.unbound() :
      impl = new _SharingServiceProxyImpl.unbound() {
    ptr = new _SharingServiceProxyCalls(impl);
  }

  factory SharingServiceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    SharingServiceProxy p = new SharingServiceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static SharingServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SharingServiceProxy"));
    return new SharingServiceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => SharingService.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "SharingServiceProxy($impl)";
  }
}


class SharingServiceStub extends bindings.Stub {
  SharingService _impl = null;

  SharingServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  SharingServiceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  SharingServiceStub.unbound() : super.unbound();

  static SharingServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SharingServiceStub"));
    return new SharingServiceStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _SharingService_shareTextName:
        var params = _SharingServiceShareTextParams.deserialize(
            message.payload);
        _impl.shareText(params.text);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  SharingService get impl => _impl;
  set impl(SharingService d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "SharingServiceStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _SharingServiceServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



