// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library surface_id_mojom;
import 'package:mojo/bindings.dart' as bindings;




class SurfaceId extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int local = 0;
  int idNamespace = 0;

  SurfaceId() : super(kVersions.last.size);

  static SurfaceId deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SurfaceId decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SurfaceId result = new SurfaceId();

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
      
      result.local = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.idNamespace = decoder0.decodeUint32(12);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(local, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "local of struct SurfaceId: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(idNamespace, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "idNamespace of struct SurfaceId: $e";
      rethrow;
    }
  }

  String toString() {
    return "SurfaceId("
           "local: $local" ", "
           "idNamespace: $idNamespace" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["local"] = local;
    map["idNamespace"] = idNamespace;
    return map;
  }
}



