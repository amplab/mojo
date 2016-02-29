// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library terminal_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/files/file.mojom.dart' as file_mojom;
import 'package:mojo_services/mojo/files/types.mojom.dart' as types_mojom;
import 'package:mojo_services/mojo/terminal/terminal_client.mojom.dart' as terminal_client_mojom;



class _TerminalConnectParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object terminalFile = null;
  bool force = false;

  _TerminalConnectParams() : super(kVersions.last.size);

  static _TerminalConnectParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TerminalConnectParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TerminalConnectParams result = new _TerminalConnectParams();

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
      
      result.terminalFile = decoder0.decodeInterfaceRequest(8, false, file_mojom.FileStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.force = decoder0.decodeBool(12, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(terminalFile, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "terminalFile of struct _TerminalConnectParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(force, 12, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "force of struct _TerminalConnectParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_TerminalConnectParams("
           "terminalFile: $terminalFile" ", "
           "force: $force" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




class TerminalConnectResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  TerminalConnectResponseParams() : super(kVersions.last.size);

  static TerminalConnectResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TerminalConnectResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TerminalConnectResponseParams result = new TerminalConnectResponseParams();

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
      
        result.error = types_mojom.Error.decode(decoder0, 8);
        if (result.error == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Error.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct TerminalConnectResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "TerminalConnectResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}




class _TerminalConnectToClientParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  Object terminalClient = null;
  bool force = false;

  _TerminalConnectToClientParams() : super(kVersions.last.size);

  static _TerminalConnectToClientParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TerminalConnectToClientParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TerminalConnectToClientParams result = new _TerminalConnectToClientParams();

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
      
      result.terminalClient = decoder0.decodeServiceInterface(8, false, terminal_client_mojom.TerminalClientProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.force = decoder0.decodeBool(16, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(terminalClient, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "terminalClient of struct _TerminalConnectToClientParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(force, 16, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "force of struct _TerminalConnectToClientParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_TerminalConnectToClientParams("
           "terminalClient: $terminalClient" ", "
           "force: $force" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




class TerminalConnectToClientResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  TerminalConnectToClientResponseParams() : super(kVersions.last.size);

  static TerminalConnectToClientResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TerminalConnectToClientResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TerminalConnectToClientResponseParams result = new TerminalConnectToClientResponseParams();

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
      
        result.error = types_mojom.Error.decode(decoder0, 8);
        if (result.error == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Error.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct TerminalConnectToClientResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "TerminalConnectToClientResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}




class _TerminalGetSizeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _TerminalGetSizeParams() : super(kVersions.last.size);

  static _TerminalGetSizeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TerminalGetSizeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TerminalGetSizeParams result = new _TerminalGetSizeParams();

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
    return "_TerminalGetSizeParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}




class TerminalGetSizeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  types_mojom.Error error = null;
  int rows = 0;
  int columns = 0;

  TerminalGetSizeResponseParams() : super(kVersions.last.size);

  static TerminalGetSizeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TerminalGetSizeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TerminalGetSizeResponseParams result = new TerminalGetSizeResponseParams();

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
      
        result.error = types_mojom.Error.decode(decoder0, 8);
        if (result.error == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Error.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.rows = decoder0.decodeUint32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.columns = decoder0.decodeUint32(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct TerminalGetSizeResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(rows, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "rows of struct TerminalGetSizeResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(columns, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "columns of struct TerminalGetSizeResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "TerminalGetSizeResponseParams("
           "error: $error" ", "
           "rows: $rows" ", "
           "columns: $columns" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    map["rows"] = rows;
    map["columns"] = columns;
    return map;
  }
}




class _TerminalSetSizeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int rows = 0;
  int columns = 0;
  bool reset = false;

  _TerminalSetSizeParams() : super(kVersions.last.size);

  static _TerminalSetSizeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TerminalSetSizeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TerminalSetSizeParams result = new _TerminalSetSizeParams();

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
      
      result.rows = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.columns = decoder0.decodeUint32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.reset = decoder0.decodeBool(16, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(rows, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "rows of struct _TerminalSetSizeParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(columns, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "columns of struct _TerminalSetSizeParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(reset, 16, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "reset of struct _TerminalSetSizeParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_TerminalSetSizeParams("
           "rows: $rows" ", "
           "columns: $columns" ", "
           "reset: $reset" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["rows"] = rows;
    map["columns"] = columns;
    map["reset"] = reset;
    return map;
  }
}




class TerminalSetSizeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  types_mojom.Error error = null;
  int rows = 0;
  int columns = 0;

  TerminalSetSizeResponseParams() : super(kVersions.last.size);

  static TerminalSetSizeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TerminalSetSizeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TerminalSetSizeResponseParams result = new TerminalSetSizeResponseParams();

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
      
        result.error = types_mojom.Error.decode(decoder0, 8);
        if (result.error == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Error.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.rows = decoder0.decodeUint32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.columns = decoder0.decodeUint32(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct TerminalSetSizeResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(rows, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "rows of struct TerminalSetSizeResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(columns, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "columns of struct TerminalSetSizeResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "TerminalSetSizeResponseParams("
           "error: $error" ", "
           "rows: $rows" ", "
           "columns: $columns" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    map["rows"] = rows;
    map["columns"] = columns;
    return map;
  }
}




const int _Terminal_connectName = 0;
const int _Terminal_connectToClientName = 1;
const int _Terminal_getSizeName = 2;
const int _Terminal_setSizeName = 3;



class _TerminalServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class Terminal {
  static const String serviceName = "mojo::terminal::Terminal";
  dynamic connect(Object terminalFile,bool force,[Function responseFactory = null]);
  dynamic connectToClient(Object terminalClient,bool force,[Function responseFactory = null]);
  dynamic getSize([Function responseFactory = null]);
  dynamic setSize(int rows,int columns,bool reset,[Function responseFactory = null]);
}


class _TerminalProxyImpl extends bindings.Proxy {
  _TerminalProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _TerminalProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _TerminalProxyImpl.unbound() : super.unbound();

  static _TerminalProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _TerminalProxyImpl"));
    return new _TerminalProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _TerminalServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _Terminal_connectName:
        var r = TerminalConnectResponseParams.deserialize(
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
      case _Terminal_connectToClientName:
        var r = TerminalConnectToClientResponseParams.deserialize(
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
      case _Terminal_getSizeName:
        var r = TerminalGetSizeResponseParams.deserialize(
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
      case _Terminal_setSizeName:
        var r = TerminalSetSizeResponseParams.deserialize(
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
    return "_TerminalProxyImpl($superString)";
  }
}


class _TerminalProxyCalls implements Terminal {
  _TerminalProxyImpl _proxyImpl;

  _TerminalProxyCalls(this._proxyImpl);
    dynamic connect(Object terminalFile,bool force,[Function responseFactory = null]) {
      var params = new _TerminalConnectParams();
      params.terminalFile = terminalFile;
      params.force = force;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Terminal_connectName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic connectToClient(Object terminalClient,bool force,[Function responseFactory = null]) {
      var params = new _TerminalConnectToClientParams();
      params.terminalClient = terminalClient;
      params.force = force;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Terminal_connectToClientName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic getSize([Function responseFactory = null]) {
      var params = new _TerminalGetSizeParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Terminal_getSizeName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic setSize(int rows,int columns,bool reset,[Function responseFactory = null]) {
      var params = new _TerminalSetSizeParams();
      params.rows = rows;
      params.columns = columns;
      params.reset = reset;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Terminal_setSizeName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class TerminalProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  Terminal ptr;

  TerminalProxy(_TerminalProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _TerminalProxyCalls(proxyImpl);

  TerminalProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _TerminalProxyImpl.fromEndpoint(endpoint) {
    ptr = new _TerminalProxyCalls(impl);
  }

  TerminalProxy.fromHandle(core.MojoHandle handle) :
      impl = new _TerminalProxyImpl.fromHandle(handle) {
    ptr = new _TerminalProxyCalls(impl);
  }

  TerminalProxy.unbound() :
      impl = new _TerminalProxyImpl.unbound() {
    ptr = new _TerminalProxyCalls(impl);
  }

  factory TerminalProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    TerminalProxy p = new TerminalProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static TerminalProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TerminalProxy"));
    return new TerminalProxy.fromEndpoint(endpoint);
  }

  String get serviceName => Terminal.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "TerminalProxy($impl)";
  }
}


class TerminalStub extends bindings.Stub {
  Terminal _impl = null;

  TerminalStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  TerminalStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  TerminalStub.unbound() : super.unbound();

  static TerminalStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TerminalStub"));
    return new TerminalStub.fromEndpoint(endpoint);
  }


  TerminalConnectResponseParams _TerminalConnectResponseParamsFactory(types_mojom.Error error) {
    var mojo_factory_result = new TerminalConnectResponseParams();
    mojo_factory_result.error = error;
    return mojo_factory_result;
  }
  TerminalConnectToClientResponseParams _TerminalConnectToClientResponseParamsFactory(types_mojom.Error error) {
    var mojo_factory_result = new TerminalConnectToClientResponseParams();
    mojo_factory_result.error = error;
    return mojo_factory_result;
  }
  TerminalGetSizeResponseParams _TerminalGetSizeResponseParamsFactory(types_mojom.Error error, int rows, int columns) {
    var mojo_factory_result = new TerminalGetSizeResponseParams();
    mojo_factory_result.error = error;
    mojo_factory_result.rows = rows;
    mojo_factory_result.columns = columns;
    return mojo_factory_result;
  }
  TerminalSetSizeResponseParams _TerminalSetSizeResponseParamsFactory(types_mojom.Error error, int rows, int columns) {
    var mojo_factory_result = new TerminalSetSizeResponseParams();
    mojo_factory_result.error = error;
    mojo_factory_result.rows = rows;
    mojo_factory_result.columns = columns;
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
      case _Terminal_connectName:
        var params = _TerminalConnectParams.deserialize(
            message.payload);
        var response = _impl.connect(params.terminalFile,params.force,_TerminalConnectResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Terminal_connectName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Terminal_connectName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _Terminal_connectToClientName:
        var params = _TerminalConnectToClientParams.deserialize(
            message.payload);
        var response = _impl.connectToClient(params.terminalClient,params.force,_TerminalConnectToClientResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Terminal_connectToClientName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Terminal_connectToClientName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _Terminal_getSizeName:
        var response = _impl.getSize(_TerminalGetSizeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Terminal_getSizeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Terminal_getSizeName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _Terminal_setSizeName:
        var params = _TerminalSetSizeParams.deserialize(
            message.payload);
        var response = _impl.setSize(params.rows,params.columns,params.reset,_TerminalSetSizeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Terminal_setSizeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Terminal_setSizeName,
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

  Terminal get impl => _impl;
  set impl(Terminal d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "TerminalStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _TerminalServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



