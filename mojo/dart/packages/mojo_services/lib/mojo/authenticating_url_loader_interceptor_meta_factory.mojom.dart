// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library authenticating_url_loader_interceptor_meta_factory_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/authentication/authentication.mojom.dart' as authentication_mojom;
import 'package:mojo_services/mojo/url_loader_interceptor.mojom.dart' as url_loader_interceptor_mojom;



class _AuthenticatingUrlLoaderInterceptorMetaFactoryCreateUrlLoaderInterceptorFactoryParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  Object factoryRequest = null;
  Object authenticationService = null;

  _AuthenticatingUrlLoaderInterceptorMetaFactoryCreateUrlLoaderInterceptorFactoryParams() : super(kVersions.last.size);

  static _AuthenticatingUrlLoaderInterceptorMetaFactoryCreateUrlLoaderInterceptorFactoryParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _AuthenticatingUrlLoaderInterceptorMetaFactoryCreateUrlLoaderInterceptorFactoryParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _AuthenticatingUrlLoaderInterceptorMetaFactoryCreateUrlLoaderInterceptorFactoryParams result = new _AuthenticatingUrlLoaderInterceptorMetaFactoryCreateUrlLoaderInterceptorFactoryParams();

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
      
      result.factoryRequest = decoder0.decodeInterfaceRequest(8, false, url_loader_interceptor_mojom.UrlLoaderInterceptorFactoryStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.authenticationService = decoder0.decodeServiceInterface(12, false, authentication_mojom.AuthenticationServiceProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(factoryRequest, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "factoryRequest of struct _AuthenticatingUrlLoaderInterceptorMetaFactoryCreateUrlLoaderInterceptorFactoryParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(authenticationService, 12, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "authenticationService of struct _AuthenticatingUrlLoaderInterceptorMetaFactoryCreateUrlLoaderInterceptorFactoryParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_AuthenticatingUrlLoaderInterceptorMetaFactoryCreateUrlLoaderInterceptorFactoryParams("
           "factoryRequest: $factoryRequest" ", "
           "authenticationService: $authenticationService" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




const int _AuthenticatingUrlLoaderInterceptorMetaFactory_createUrlLoaderInterceptorFactoryName = 0;



class _AuthenticatingUrlLoaderInterceptorMetaFactoryServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class AuthenticatingUrlLoaderInterceptorMetaFactory {
  static const String serviceName = "mojo::AuthenticatingURLLoaderInterceptorMetaFactory";
  void createUrlLoaderInterceptorFactory(Object factoryRequest, Object authenticationService);
}


class _AuthenticatingUrlLoaderInterceptorMetaFactoryProxyImpl extends bindings.Proxy {
  _AuthenticatingUrlLoaderInterceptorMetaFactoryProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _AuthenticatingUrlLoaderInterceptorMetaFactoryProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _AuthenticatingUrlLoaderInterceptorMetaFactoryProxyImpl.unbound() : super.unbound();

  static _AuthenticatingUrlLoaderInterceptorMetaFactoryProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _AuthenticatingUrlLoaderInterceptorMetaFactoryProxyImpl"));
    return new _AuthenticatingUrlLoaderInterceptorMetaFactoryProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _AuthenticatingUrlLoaderInterceptorMetaFactoryServiceDescription();

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
    return "_AuthenticatingUrlLoaderInterceptorMetaFactoryProxyImpl($superString)";
  }
}


class _AuthenticatingUrlLoaderInterceptorMetaFactoryProxyCalls implements AuthenticatingUrlLoaderInterceptorMetaFactory {
  _AuthenticatingUrlLoaderInterceptorMetaFactoryProxyImpl _proxyImpl;

  _AuthenticatingUrlLoaderInterceptorMetaFactoryProxyCalls(this._proxyImpl);
    void createUrlLoaderInterceptorFactory(Object factoryRequest, Object authenticationService) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _AuthenticatingUrlLoaderInterceptorMetaFactoryCreateUrlLoaderInterceptorFactoryParams();
      params.factoryRequest = factoryRequest;
      params.authenticationService = authenticationService;
      _proxyImpl.sendMessage(params, _AuthenticatingUrlLoaderInterceptorMetaFactory_createUrlLoaderInterceptorFactoryName);
    }
}


class AuthenticatingUrlLoaderInterceptorMetaFactoryProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  AuthenticatingUrlLoaderInterceptorMetaFactory ptr;

  AuthenticatingUrlLoaderInterceptorMetaFactoryProxy(_AuthenticatingUrlLoaderInterceptorMetaFactoryProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _AuthenticatingUrlLoaderInterceptorMetaFactoryProxyCalls(proxyImpl);

  AuthenticatingUrlLoaderInterceptorMetaFactoryProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _AuthenticatingUrlLoaderInterceptorMetaFactoryProxyImpl.fromEndpoint(endpoint) {
    ptr = new _AuthenticatingUrlLoaderInterceptorMetaFactoryProxyCalls(impl);
  }

  AuthenticatingUrlLoaderInterceptorMetaFactoryProxy.fromHandle(core.MojoHandle handle) :
      impl = new _AuthenticatingUrlLoaderInterceptorMetaFactoryProxyImpl.fromHandle(handle) {
    ptr = new _AuthenticatingUrlLoaderInterceptorMetaFactoryProxyCalls(impl);
  }

  AuthenticatingUrlLoaderInterceptorMetaFactoryProxy.unbound() :
      impl = new _AuthenticatingUrlLoaderInterceptorMetaFactoryProxyImpl.unbound() {
    ptr = new _AuthenticatingUrlLoaderInterceptorMetaFactoryProxyCalls(impl);
  }

  factory AuthenticatingUrlLoaderInterceptorMetaFactoryProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    AuthenticatingUrlLoaderInterceptorMetaFactoryProxy p = new AuthenticatingUrlLoaderInterceptorMetaFactoryProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static AuthenticatingUrlLoaderInterceptorMetaFactoryProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For AuthenticatingUrlLoaderInterceptorMetaFactoryProxy"));
    return new AuthenticatingUrlLoaderInterceptorMetaFactoryProxy.fromEndpoint(endpoint);
  }

  String get serviceName => AuthenticatingUrlLoaderInterceptorMetaFactory.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "AuthenticatingUrlLoaderInterceptorMetaFactoryProxy($impl)";
  }
}


class AuthenticatingUrlLoaderInterceptorMetaFactoryStub extends bindings.Stub {
  AuthenticatingUrlLoaderInterceptorMetaFactory _impl = null;

  AuthenticatingUrlLoaderInterceptorMetaFactoryStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  AuthenticatingUrlLoaderInterceptorMetaFactoryStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  AuthenticatingUrlLoaderInterceptorMetaFactoryStub.unbound() : super.unbound();

  static AuthenticatingUrlLoaderInterceptorMetaFactoryStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For AuthenticatingUrlLoaderInterceptorMetaFactoryStub"));
    return new AuthenticatingUrlLoaderInterceptorMetaFactoryStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _AuthenticatingUrlLoaderInterceptorMetaFactory_createUrlLoaderInterceptorFactoryName:
        var params = _AuthenticatingUrlLoaderInterceptorMetaFactoryCreateUrlLoaderInterceptorFactoryParams.deserialize(
            message.payload);
        _impl.createUrlLoaderInterceptorFactory(params.factoryRequest, params.authenticationService);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  AuthenticatingUrlLoaderInterceptorMetaFactory get impl => _impl;
  set impl(AuthenticatingUrlLoaderInterceptorMetaFactory d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "AuthenticatingUrlLoaderInterceptorMetaFactoryStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _AuthenticatingUrlLoaderInterceptorMetaFactoryServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



