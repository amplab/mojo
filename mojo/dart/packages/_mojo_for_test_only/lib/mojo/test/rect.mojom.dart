// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library rect_mojom;
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;




class Rect extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int x = 0;
  int y = 0;
  int width = 0;
  int height = 0;

  Rect() : super(kVersions.last.size);

  static Rect deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Rect decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Rect result = new Rect();

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
      
      result.x = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.y = decoder0.decodeInt32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.width = decoder0.decodeInt32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.height = decoder0.decodeInt32(20);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(x, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "x of struct Rect: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(y, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "y of struct Rect: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(width, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "width of struct Rect: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(height, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "height of struct Rect: $e";
      rethrow;
    }
  }

  String toString() {
    return "Rect("
           "x: $x" ", "
           "y: $y" ", "
           "width: $width" ", "
           "height: $height" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["x"] = x;
    map["y"] = y;
    map["width"] = width;
    map["height"] = height;
    return map;
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
  var serializedRuntimeTypeInfo = "H4sIAAAJbogC/5JggAABKG0ApdHFYTQHGo2uzgKJz4ikTh6IxYE4JDLANd7bNdIqNz8rX68ktbhELyg1uQRsDiMWfQpo9nyAuZMVQnswYIL/QGCA5h6QGIh2YMAOeICYBYjBjgECMSDmA2I0Z2L4F+ROdiAOBGJPINbPyM9N1S8qTcnPzcxLLdIH6dcvLkqGMApKk3Iyk/Uz80pSi9ISk1OL9ZMy81Iy89KL9UF2FOsXAS3RAynNhZqvAXUXLBwUGKE0E5RmhtAOWMIfBFgZiAOEwhEdaOAQ54TGXwWO9MEJDTNahRep4cBCZjgwEhkOlTjCgWuQhQMHmeHARCAceKF2lmemlGRgCQfuQRYOPGSGAzOBcACVJWxAnJGamZ6BpRzhoXE4oJerEmh5AMYHBAAA//8bWnY5EAYAAA==";

  // Deserialize RuntimeTypeInfo
  var bytes = BASE64.decode(serializedRuntimeTypeInfo);
  var unzippedBytes = new ZLibDecoder().convert(bytes);
  var bdata = new ByteData.view(unzippedBytes.buffer);
  var message = new bindings.Message(bdata, null, unzippedBytes.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  return _runtimeTypeInfo;
}
