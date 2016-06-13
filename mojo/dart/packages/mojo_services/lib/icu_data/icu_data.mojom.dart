// WARNING: DO NOT EDIT. This file was generated by a program.
// See $MOJO_SDK/tools/bindings/mojom_bindings_generator.py.

library icu_data_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _IcuDataMapParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String sha1hash = null;

  _IcuDataMapParams() : super(kVersions.last.size);

  _IcuDataMapParams.init(
    String this.sha1hash
  ) : super(kVersions.last.size);

  static _IcuDataMapParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _IcuDataMapParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _IcuDataMapParams result = new _IcuDataMapParams();

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
      
      result.sha1hash = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(sha1hash, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "sha1hash of struct _IcuDataMapParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_IcuDataMapParams("
           "sha1hash: $sha1hash" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["sha1hash"] = sha1hash;
    return map;
  }
}


class IcuDataMapResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  core.MojoSharedBuffer icuData = null;

  IcuDataMapResponseParams() : super(kVersions.last.size);

  IcuDataMapResponseParams.init(
    core.MojoSharedBuffer this.icuData
  ) : super(kVersions.last.size);

  static IcuDataMapResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static IcuDataMapResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    IcuDataMapResponseParams result = new IcuDataMapResponseParams();

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
      
      result.icuData = decoder0.decodeSharedBufferHandle(8, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeSharedBufferHandle(icuData, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "icuData of struct IcuDataMapResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "IcuDataMapResponseParams("
           "icuData: $icuData" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _icuDataMethodMapName = 0;

class _IcuDataServiceDescription implements service_describer.ServiceDescription {
  void getTopLevelInterface(Function responder) {
    responder(null);
  }

  void getTypeDefinition(String typeKey, Function responder) {
    responder(null);
  }

  void getAllTypeDefinitions(Function responder) {
    responder(null);
  }
}

abstract class IcuData {
  static const String serviceName = "icu_data::ICUData";

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _IcuDataServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static IcuDataProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    IcuDataProxy p = new IcuDataProxy.unbound();
    String name = serviceName ?? IcuData.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  void map(String sha1hash,void callback(core.MojoSharedBuffer icuData));
}

abstract class IcuDataInterface
    implements bindings.MojoInterface<IcuData>,
               IcuData {
  factory IcuDataInterface([IcuData impl]) =>
      new IcuDataStub.unbound(impl);

  factory IcuDataInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [IcuData impl]) =>
      new IcuDataStub.fromEndpoint(endpoint, impl);

  factory IcuDataInterface.fromMock(
      IcuData mock) =>
      new IcuDataProxy.fromMock(mock);
}

abstract class IcuDataInterfaceRequest
    implements bindings.MojoInterface<IcuData>,
               IcuData {
  factory IcuDataInterfaceRequest() =>
      new IcuDataProxy.unbound();
}

class _IcuDataProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<IcuData> {
  IcuData impl;

  _IcuDataProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _IcuDataProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _IcuDataProxyControl.unbound() : super.unbound();

  String get serviceName => IcuData.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _icuDataMethodMapName:
        var r = IcuDataMapResponseParams.deserialize(
            message.payload);
        if (!message.header.hasRequestId) {
          proxyError("Expected a message with a valid request Id.");
          return;
        }
        Function callback = callbackMap[message.header.requestId];
        if (callback == null) {
          proxyError(
              "Message had unknown request Id: ${message.header.requestId}");
          return;
        }
        callbackMap.remove(message.header.requestId);
        callback(r.icuData );
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
    return "_IcuDataProxyControl($superString)";
  }
}

class IcuDataProxy
    extends bindings.Proxy<IcuData>
    implements IcuData,
               IcuDataInterface,
               IcuDataInterfaceRequest {
  IcuDataProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _IcuDataProxyControl.fromEndpoint(endpoint));

  IcuDataProxy.fromHandle(core.MojoHandle handle)
      : super(new _IcuDataProxyControl.fromHandle(handle));

  IcuDataProxy.unbound()
      : super(new _IcuDataProxyControl.unbound());

  factory IcuDataProxy.fromMock(IcuData mock) {
    IcuDataProxy newMockedProxy =
        new IcuDataProxy.unbound();
    newMockedProxy.impl = mock;
    return newMockedProxy;
  }

  static IcuDataProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For IcuDataProxy"));
    return new IcuDataProxy.fromEndpoint(endpoint);
  }


  void map(String sha1hash,void callback(core.MojoSharedBuffer icuData)) {
    if (impl != null) {
      impl.map(sha1hash,callback);
      return;
    }
    var params = new _IcuDataMapParams();
    params.sha1hash = sha1hash;
    Function zonedCallback;
    if (identical(Zone.current, Zone.ROOT)) {
      zonedCallback = callback;
    } else {
      Zone z = Zone.current;
      zonedCallback = ((core.MojoSharedBuffer icuData) {
        z.bindCallback(() {
          callback(icuData);
        })();
      });
    }
    ctrl.sendMessageWithRequestId(
        params,
        _icuDataMethodMapName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse,
        zonedCallback);
  }
}

class _IcuDataStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<IcuData> {
  IcuData _impl;

  _IcuDataStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [IcuData impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _IcuDataStubControl.fromHandle(
      core.MojoHandle handle, [IcuData impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _IcuDataStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => IcuData.serviceName;


  Function _icuDataMapResponseParamsResponder(
      int requestId) {
  return (core.MojoSharedBuffer icuData) {
      var result = new IcuDataMapResponseParams();
      result.icuData = icuData;
      sendResponse(buildResponseWithId(
          result,
          _icuDataMethodMapName,
          requestId,
          bindings.MessageHeader.kMessageIsResponse));
    };
  }

  void handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      bindings.ControlMessageHandler.handleMessage(
          this, 0, message);
      return;
    }
    if (_impl == null) {
      throw new core.MojoApiError("$this has no implementation set");
    }
    switch (message.header.type) {
      case _icuDataMethodMapName:
        var params = _IcuDataMapParams.deserialize(
            message.payload);
        _impl.map(params.sha1hash, _icuDataMapResponseParamsResponder(message.header.requestId));
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
  }

  IcuData get impl => _impl;
  set impl(IcuData d) {
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

  @override
  String toString() {
    var superString = super.toString();
    return "_IcuDataStubControl($superString)";
  }

  int get version => 0;
}

class IcuDataStub
    extends bindings.Stub<IcuData>
    implements IcuData,
               IcuDataInterface,
               IcuDataInterfaceRequest {
  IcuDataStub.unbound([IcuData impl])
      : super(new _IcuDataStubControl.unbound(impl));

  IcuDataStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [IcuData impl])
      : super(new _IcuDataStubControl.fromEndpoint(endpoint, impl));

  IcuDataStub.fromHandle(
      core.MojoHandle handle, [IcuData impl])
      : super(new _IcuDataStubControl.fromHandle(handle, impl));

  static IcuDataStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For IcuDataStub"));
    return new IcuDataStub.fromEndpoint(endpoint);
  }


  void map(String sha1hash,void callback(core.MojoSharedBuffer icuData)) {
    return impl.map(sha1hash,callback);
  }
}



