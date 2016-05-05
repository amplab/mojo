// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library network_service_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo/mojo/network_error.mojom.dart' as network_error_mojom;
import 'package:mojo_services/mojo/cookie_store.mojom.dart' as cookie_store_mojom;
import 'package:mojo_services/mojo/host_resolver.mojom.dart' as host_resolver_mojom;
import 'package:mojo_services/mojo/http_server.mojom.dart' as http_server_mojom;
import 'package:mojo_services/mojo/net_address.mojom.dart' as net_address_mojom;
import 'package:mojo_services/mojo/tcp_bound_socket.mojom.dart' as tcp_bound_socket_mojom;
import 'package:mojo_services/mojo/tcp_connected_socket.mojom.dart' as tcp_connected_socket_mojom;
import 'package:mojo_services/mojo/udp_socket.mojom.dart' as udp_socket_mojom;
import 'package:mojo_services/mojo/url_loader.mojom.dart' as url_loader_mojom;
import 'package:mojo_services/mojo/url_loader_interceptor.mojom.dart' as url_loader_interceptor_mojom;
import 'package:mojo_services/mojo/web_socket.mojom.dart' as web_socket_mojom;



class _NetworkServiceCreateUrlLoaderParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object loader = null;

  _NetworkServiceCreateUrlLoaderParams() : super(kVersions.last.size);

  static _NetworkServiceCreateUrlLoaderParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NetworkServiceCreateUrlLoaderParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NetworkServiceCreateUrlLoaderParams result = new _NetworkServiceCreateUrlLoaderParams();

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
      
      result.loader = decoder0.decodeInterfaceRequest(8, false, url_loader_mojom.UrlLoaderStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(loader, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "loader of struct _NetworkServiceCreateUrlLoaderParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_NetworkServiceCreateUrlLoaderParams("
           "loader: $loader" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _NetworkServiceGetCookieStoreParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object cookieStore = null;

  _NetworkServiceGetCookieStoreParams() : super(kVersions.last.size);

  static _NetworkServiceGetCookieStoreParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NetworkServiceGetCookieStoreParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NetworkServiceGetCookieStoreParams result = new _NetworkServiceGetCookieStoreParams();

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
      
      result.cookieStore = decoder0.decodeInterfaceRequest(8, false, cookie_store_mojom.CookieStoreStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(cookieStore, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "cookieStore of struct _NetworkServiceGetCookieStoreParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_NetworkServiceGetCookieStoreParams("
           "cookieStore: $cookieStore" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _NetworkServiceCreateWebSocketParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object socket = null;

  _NetworkServiceCreateWebSocketParams() : super(kVersions.last.size);

  static _NetworkServiceCreateWebSocketParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NetworkServiceCreateWebSocketParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NetworkServiceCreateWebSocketParams result = new _NetworkServiceCreateWebSocketParams();

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
      
      result.socket = decoder0.decodeInterfaceRequest(8, false, web_socket_mojom.WebSocketStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(socket, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "socket of struct _NetworkServiceCreateWebSocketParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_NetworkServiceCreateWebSocketParams("
           "socket: $socket" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _NetworkServiceCreateTcpBoundSocketParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  net_address_mojom.NetAddress localAddress = null;
  Object boundSocket = null;

  _NetworkServiceCreateTcpBoundSocketParams() : super(kVersions.last.size);

  static _NetworkServiceCreateTcpBoundSocketParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NetworkServiceCreateTcpBoundSocketParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NetworkServiceCreateTcpBoundSocketParams result = new _NetworkServiceCreateTcpBoundSocketParams();

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
      result.localAddress = net_address_mojom.NetAddress.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.boundSocket = decoder0.decodeInterfaceRequest(16, false, tcp_bound_socket_mojom.TcpBoundSocketStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(localAddress, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "localAddress of struct _NetworkServiceCreateTcpBoundSocketParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(boundSocket, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "boundSocket of struct _NetworkServiceCreateTcpBoundSocketParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_NetworkServiceCreateTcpBoundSocketParams("
           "localAddress: $localAddress" ", "
           "boundSocket: $boundSocket" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class NetworkServiceCreateTcpBoundSocketResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  network_error_mojom.NetworkError result = null;
  net_address_mojom.NetAddress boundTo = null;

  NetworkServiceCreateTcpBoundSocketResponseParams() : super(kVersions.last.size);

  static NetworkServiceCreateTcpBoundSocketResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NetworkServiceCreateTcpBoundSocketResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NetworkServiceCreateTcpBoundSocketResponseParams result = new NetworkServiceCreateTcpBoundSocketResponseParams();

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
      result.result = network_error_mojom.NetworkError.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.boundTo = net_address_mojom.NetAddress.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(result, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "result of struct NetworkServiceCreateTcpBoundSocketResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(boundTo, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "boundTo of struct NetworkServiceCreateTcpBoundSocketResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "NetworkServiceCreateTcpBoundSocketResponseParams("
           "result: $result" ", "
           "boundTo: $boundTo" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    map["boundTo"] = boundTo;
    return map;
  }
}


class _NetworkServiceCreateTcpConnectedSocketParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  net_address_mojom.NetAddress remoteAddress = null;
  core.MojoDataPipeConsumer sendStream = null;
  core.MojoDataPipeProducer receiveStream = null;
  Object clientSocket = null;

  _NetworkServiceCreateTcpConnectedSocketParams() : super(kVersions.last.size);

  static _NetworkServiceCreateTcpConnectedSocketParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NetworkServiceCreateTcpConnectedSocketParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NetworkServiceCreateTcpConnectedSocketParams result = new _NetworkServiceCreateTcpConnectedSocketParams();

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
      result.remoteAddress = net_address_mojom.NetAddress.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.sendStream = decoder0.decodeConsumerHandle(16, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.receiveStream = decoder0.decodeProducerHandle(20, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.clientSocket = decoder0.decodeInterfaceRequest(24, false, tcp_connected_socket_mojom.TcpConnectedSocketStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(remoteAddress, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "remoteAddress of struct _NetworkServiceCreateTcpConnectedSocketParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeConsumerHandle(sendStream, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "sendStream of struct _NetworkServiceCreateTcpConnectedSocketParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeProducerHandle(receiveStream, 20, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "receiveStream of struct _NetworkServiceCreateTcpConnectedSocketParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(clientSocket, 24, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "clientSocket of struct _NetworkServiceCreateTcpConnectedSocketParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_NetworkServiceCreateTcpConnectedSocketParams("
           "remoteAddress: $remoteAddress" ", "
           "sendStream: $sendStream" ", "
           "receiveStream: $receiveStream" ", "
           "clientSocket: $clientSocket" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class NetworkServiceCreateTcpConnectedSocketResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  network_error_mojom.NetworkError result = null;
  net_address_mojom.NetAddress localAddress = null;

  NetworkServiceCreateTcpConnectedSocketResponseParams() : super(kVersions.last.size);

  static NetworkServiceCreateTcpConnectedSocketResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NetworkServiceCreateTcpConnectedSocketResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NetworkServiceCreateTcpConnectedSocketResponseParams result = new NetworkServiceCreateTcpConnectedSocketResponseParams();

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
      result.result = network_error_mojom.NetworkError.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.localAddress = net_address_mojom.NetAddress.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(result, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "result of struct NetworkServiceCreateTcpConnectedSocketResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(localAddress, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "localAddress of struct NetworkServiceCreateTcpConnectedSocketResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "NetworkServiceCreateTcpConnectedSocketResponseParams("
           "result: $result" ", "
           "localAddress: $localAddress" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    map["localAddress"] = localAddress;
    return map;
  }
}


class _NetworkServiceCreateUdpSocketParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object socket = null;

  _NetworkServiceCreateUdpSocketParams() : super(kVersions.last.size);

  static _NetworkServiceCreateUdpSocketParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NetworkServiceCreateUdpSocketParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NetworkServiceCreateUdpSocketParams result = new _NetworkServiceCreateUdpSocketParams();

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
      
      result.socket = decoder0.decodeInterfaceRequest(8, false, udp_socket_mojom.UdpSocketStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(socket, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "socket of struct _NetworkServiceCreateUdpSocketParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_NetworkServiceCreateUdpSocketParams("
           "socket: $socket" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _NetworkServiceCreateHttpServerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  net_address_mojom.NetAddress localAddress = null;
  Object delegate = null;

  _NetworkServiceCreateHttpServerParams() : super(kVersions.last.size);

  static _NetworkServiceCreateHttpServerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NetworkServiceCreateHttpServerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NetworkServiceCreateHttpServerParams result = new _NetworkServiceCreateHttpServerParams();

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
      result.localAddress = net_address_mojom.NetAddress.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.delegate = decoder0.decodeServiceInterface(16, false, http_server_mojom.HttpServerDelegateProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(localAddress, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "localAddress of struct _NetworkServiceCreateHttpServerParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(delegate, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "delegate of struct _NetworkServiceCreateHttpServerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_NetworkServiceCreateHttpServerParams("
           "localAddress: $localAddress" ", "
           "delegate: $delegate" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class NetworkServiceCreateHttpServerResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  network_error_mojom.NetworkError result = null;
  net_address_mojom.NetAddress boundTo = null;

  NetworkServiceCreateHttpServerResponseParams() : super(kVersions.last.size);

  static NetworkServiceCreateHttpServerResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NetworkServiceCreateHttpServerResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NetworkServiceCreateHttpServerResponseParams result = new NetworkServiceCreateHttpServerResponseParams();

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
      result.result = network_error_mojom.NetworkError.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.boundTo = net_address_mojom.NetAddress.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(result, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "result of struct NetworkServiceCreateHttpServerResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(boundTo, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "boundTo of struct NetworkServiceCreateHttpServerResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "NetworkServiceCreateHttpServerResponseParams("
           "result: $result" ", "
           "boundTo: $boundTo" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    map["boundTo"] = boundTo;
    return map;
  }
}


class _NetworkServiceRegisterUrlLoaderInterceptorParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object factory = null;

  _NetworkServiceRegisterUrlLoaderInterceptorParams() : super(kVersions.last.size);

  static _NetworkServiceRegisterUrlLoaderInterceptorParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NetworkServiceRegisterUrlLoaderInterceptorParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NetworkServiceRegisterUrlLoaderInterceptorParams result = new _NetworkServiceRegisterUrlLoaderInterceptorParams();

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
      
      result.factory = decoder0.decodeServiceInterface(8, false, url_loader_interceptor_mojom.UrlLoaderInterceptorFactoryProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(factory, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "factory of struct _NetworkServiceRegisterUrlLoaderInterceptorParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_NetworkServiceRegisterUrlLoaderInterceptorParams("
           "factory: $factory" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _NetworkServiceCreateHostResolverParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object hostResolver = null;

  _NetworkServiceCreateHostResolverParams() : super(kVersions.last.size);

  static _NetworkServiceCreateHostResolverParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NetworkServiceCreateHostResolverParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NetworkServiceCreateHostResolverParams result = new _NetworkServiceCreateHostResolverParams();

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
      
      result.hostResolver = decoder0.decodeInterfaceRequest(8, false, host_resolver_mojom.HostResolverStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(hostResolver, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "hostResolver of struct _NetworkServiceCreateHostResolverParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_NetworkServiceCreateHostResolverParams("
           "hostResolver: $hostResolver" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _networkServiceMethodCreateUrlLoaderName = 0;
const int _networkServiceMethodGetCookieStoreName = 1;
const int _networkServiceMethodCreateWebSocketName = 2;
const int _networkServiceMethodCreateTcpBoundSocketName = 3;
const int _networkServiceMethodCreateTcpConnectedSocketName = 4;
const int _networkServiceMethodCreateUdpSocketName = 5;
const int _networkServiceMethodCreateHttpServerName = 6;
const int _networkServiceMethodRegisterUrlLoaderInterceptorName = 7;
const int _networkServiceMethodCreateHostResolverName = 8;

class _NetworkServiceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class NetworkService {
  static const String serviceName = "mojo::NetworkService";
  void createUrlLoader(Object loader);
  void getCookieStore(Object cookieStore);
  void createWebSocket(Object socket);
  dynamic createTcpBoundSocket(net_address_mojom.NetAddress localAddress,Object boundSocket,[Function responseFactory = null]);
  dynamic createTcpConnectedSocket(net_address_mojom.NetAddress remoteAddress,core.MojoDataPipeConsumer sendStream,core.MojoDataPipeProducer receiveStream,Object clientSocket,[Function responseFactory = null]);
  void createUdpSocket(Object socket);
  dynamic createHttpServer(net_address_mojom.NetAddress localAddress,Object delegate,[Function responseFactory = null]);
  void registerUrlLoaderInterceptor(Object factory);
  void createHostResolver(Object hostResolver);
}


class _NetworkServiceProxyImpl extends bindings.Proxy {
  _NetworkServiceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _NetworkServiceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _NetworkServiceProxyImpl.unbound() : super.unbound();

  static _NetworkServiceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _NetworkServiceProxyImpl"));
    return new _NetworkServiceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _NetworkServiceServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _networkServiceMethodCreateTcpBoundSocketName:
        var r = NetworkServiceCreateTcpBoundSocketResponseParams.deserialize(
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
      case _networkServiceMethodCreateTcpConnectedSocketName:
        var r = NetworkServiceCreateTcpConnectedSocketResponseParams.deserialize(
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
      case _networkServiceMethodCreateHttpServerName:
        var r = NetworkServiceCreateHttpServerResponseParams.deserialize(
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
    return "_NetworkServiceProxyImpl($superString)";
  }
}


class _NetworkServiceProxyCalls implements NetworkService {
  _NetworkServiceProxyImpl _proxyImpl;

  _NetworkServiceProxyCalls(this._proxyImpl);
    void createUrlLoader(Object loader) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _NetworkServiceCreateUrlLoaderParams();
      params.loader = loader;
      _proxyImpl.sendMessage(params, _networkServiceMethodCreateUrlLoaderName);
    }
    void getCookieStore(Object cookieStore) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _NetworkServiceGetCookieStoreParams();
      params.cookieStore = cookieStore;
      _proxyImpl.sendMessage(params, _networkServiceMethodGetCookieStoreName);
    }
    void createWebSocket(Object socket) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _NetworkServiceCreateWebSocketParams();
      params.socket = socket;
      _proxyImpl.sendMessage(params, _networkServiceMethodCreateWebSocketName);
    }
    dynamic createTcpBoundSocket(net_address_mojom.NetAddress localAddress,Object boundSocket,[Function responseFactory = null]) {
      var params = new _NetworkServiceCreateTcpBoundSocketParams();
      params.localAddress = localAddress;
      params.boundSocket = boundSocket;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _networkServiceMethodCreateTcpBoundSocketName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic createTcpConnectedSocket(net_address_mojom.NetAddress remoteAddress,core.MojoDataPipeConsumer sendStream,core.MojoDataPipeProducer receiveStream,Object clientSocket,[Function responseFactory = null]) {
      var params = new _NetworkServiceCreateTcpConnectedSocketParams();
      params.remoteAddress = remoteAddress;
      params.sendStream = sendStream;
      params.receiveStream = receiveStream;
      params.clientSocket = clientSocket;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _networkServiceMethodCreateTcpConnectedSocketName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void createUdpSocket(Object socket) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _NetworkServiceCreateUdpSocketParams();
      params.socket = socket;
      _proxyImpl.sendMessage(params, _networkServiceMethodCreateUdpSocketName);
    }
    dynamic createHttpServer(net_address_mojom.NetAddress localAddress,Object delegate,[Function responseFactory = null]) {
      var params = new _NetworkServiceCreateHttpServerParams();
      params.localAddress = localAddress;
      params.delegate = delegate;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _networkServiceMethodCreateHttpServerName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void registerUrlLoaderInterceptor(Object factory) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _NetworkServiceRegisterUrlLoaderInterceptorParams();
      params.factory = factory;
      _proxyImpl.sendMessage(params, _networkServiceMethodRegisterUrlLoaderInterceptorName);
    }
    void createHostResolver(Object hostResolver) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _NetworkServiceCreateHostResolverParams();
      params.hostResolver = hostResolver;
      _proxyImpl.sendMessage(params, _networkServiceMethodCreateHostResolverName);
    }
}


class NetworkServiceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  NetworkService ptr;

  NetworkServiceProxy(_NetworkServiceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _NetworkServiceProxyCalls(proxyImpl);

  NetworkServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _NetworkServiceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _NetworkServiceProxyCalls(impl);
  }

  NetworkServiceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _NetworkServiceProxyImpl.fromHandle(handle) {
    ptr = new _NetworkServiceProxyCalls(impl);
  }

  NetworkServiceProxy.unbound() :
      impl = new _NetworkServiceProxyImpl.unbound() {
    ptr = new _NetworkServiceProxyCalls(impl);
  }

  factory NetworkServiceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    NetworkServiceProxy p = new NetworkServiceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static NetworkServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NetworkServiceProxy"));
    return new NetworkServiceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => NetworkService.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "NetworkServiceProxy($impl)";
  }
}


class NetworkServiceStub extends bindings.Stub {
  NetworkService _impl;

  NetworkServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [NetworkService impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  NetworkServiceStub.fromHandle(
      core.MojoHandle handle, [NetworkService impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  NetworkServiceStub.unbound() : super.unbound();

  static NetworkServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NetworkServiceStub"));
    return new NetworkServiceStub.fromEndpoint(endpoint);
  }


  NetworkServiceCreateTcpBoundSocketResponseParams _networkServiceCreateTcpBoundSocketResponseParamsFactory(network_error_mojom.NetworkError result, net_address_mojom.NetAddress boundTo) {
    var result = new NetworkServiceCreateTcpBoundSocketResponseParams();
    result.result = result;
    result.boundTo = boundTo;
    return result;
  }
  NetworkServiceCreateTcpConnectedSocketResponseParams _networkServiceCreateTcpConnectedSocketResponseParamsFactory(network_error_mojom.NetworkError result, net_address_mojom.NetAddress localAddress) {
    var result = new NetworkServiceCreateTcpConnectedSocketResponseParams();
    result.result = result;
    result.localAddress = localAddress;
    return result;
  }
  NetworkServiceCreateHttpServerResponseParams _networkServiceCreateHttpServerResponseParamsFactory(network_error_mojom.NetworkError result, net_address_mojom.NetAddress boundTo) {
    var result = new NetworkServiceCreateHttpServerResponseParams();
    result.result = result;
    result.boundTo = boundTo;
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
      case _networkServiceMethodCreateUrlLoaderName:
        var params = _NetworkServiceCreateUrlLoaderParams.deserialize(
            message.payload);
        _impl.createUrlLoader(params.loader);
        break;
      case _networkServiceMethodGetCookieStoreName:
        var params = _NetworkServiceGetCookieStoreParams.deserialize(
            message.payload);
        _impl.getCookieStore(params.cookieStore);
        break;
      case _networkServiceMethodCreateWebSocketName:
        var params = _NetworkServiceCreateWebSocketParams.deserialize(
            message.payload);
        _impl.createWebSocket(params.socket);
        break;
      case _networkServiceMethodCreateTcpBoundSocketName:
        var params = _NetworkServiceCreateTcpBoundSocketParams.deserialize(
            message.payload);
        var response = _impl.createTcpBoundSocket(params.localAddress,params.boundSocket,_networkServiceCreateTcpBoundSocketResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _networkServiceMethodCreateTcpBoundSocketName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _networkServiceMethodCreateTcpBoundSocketName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _networkServiceMethodCreateTcpConnectedSocketName:
        var params = _NetworkServiceCreateTcpConnectedSocketParams.deserialize(
            message.payload);
        var response = _impl.createTcpConnectedSocket(params.remoteAddress,params.sendStream,params.receiveStream,params.clientSocket,_networkServiceCreateTcpConnectedSocketResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _networkServiceMethodCreateTcpConnectedSocketName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _networkServiceMethodCreateTcpConnectedSocketName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _networkServiceMethodCreateUdpSocketName:
        var params = _NetworkServiceCreateUdpSocketParams.deserialize(
            message.payload);
        _impl.createUdpSocket(params.socket);
        break;
      case _networkServiceMethodCreateHttpServerName:
        var params = _NetworkServiceCreateHttpServerParams.deserialize(
            message.payload);
        var response = _impl.createHttpServer(params.localAddress,params.delegate,_networkServiceCreateHttpServerResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _networkServiceMethodCreateHttpServerName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _networkServiceMethodCreateHttpServerName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _networkServiceMethodRegisterUrlLoaderInterceptorName:
        var params = _NetworkServiceRegisterUrlLoaderInterceptorParams.deserialize(
            message.payload);
        _impl.registerUrlLoaderInterceptor(params.factory);
        break;
      case _networkServiceMethodCreateHostResolverName:
        var params = _NetworkServiceCreateHostResolverParams.deserialize(
            message.payload);
        _impl.createHostResolver(params.hostResolver);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  NetworkService get impl => _impl;
  set impl(NetworkService d) {
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
    return "NetworkServiceStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _NetworkServiceServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



