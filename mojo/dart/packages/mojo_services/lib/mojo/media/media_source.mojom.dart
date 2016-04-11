// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library media_source_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/media/media_metadata.mojom.dart' as media_metadata_mojom;
import 'package:mojo_services/mojo/media/media_state.mojom.dart' as media_state_mojom;
import 'package:mojo_services/mojo/media/media_transport.mojom.dart' as media_transport_mojom;
import 'package:mojo_services/mojo/media/media_types.mojom.dart' as media_types_mojom;



class MediaSourceStreamDescriptor extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  int index = 0;
  media_types_mojom.MediaType mediaType = null;
  media_types_mojom.MediaType originalMediaType = null;

  MediaSourceStreamDescriptor() : super(kVersions.last.size);

  static MediaSourceStreamDescriptor deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaSourceStreamDescriptor decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaSourceStreamDescriptor result = new MediaSourceStreamDescriptor();

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
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.mediaType = media_types_mojom.MediaType.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      result.originalMediaType = media_types_mojom.MediaType.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(index, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "index of struct MediaSourceStreamDescriptor: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(mediaType, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "mediaType of struct MediaSourceStreamDescriptor: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(originalMediaType, 24, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "originalMediaType of struct MediaSourceStreamDescriptor: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaSourceStreamDescriptor("
           "index: $index" ", "
           "mediaType: $mediaType" ", "
           "originalMediaType: $originalMediaType" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["index"] = index;
    map["mediaType"] = mediaType;
    map["originalMediaType"] = originalMediaType;
    return map;
  }
}


class MediaSourceStatus extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  media_state_mojom.MediaState state = null;
  media_metadata_mojom.MediaMetadata metadata = null;

  MediaSourceStatus() : super(kVersions.last.size);

  static MediaSourceStatus deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaSourceStatus decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaSourceStatus result = new MediaSourceStatus();

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
      
        result.state = media_state_mojom.MediaState.decode(decoder0, 8);
        if (result.state == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable media_state_mojom.MediaState.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.metadata = media_metadata_mojom.MediaMetadata.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(state, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "state of struct MediaSourceStatus: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(metadata, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "metadata of struct MediaSourceStatus: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaSourceStatus("
           "state: $state" ", "
           "metadata: $metadata" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["state"] = state;
    map["metadata"] = metadata;
    return map;
  }
}


class _MediaSourceGetStreamsParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaSourceGetStreamsParams() : super(kVersions.last.size);

  static _MediaSourceGetStreamsParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSourceGetStreamsParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSourceGetStreamsParams result = new _MediaSourceGetStreamsParams();

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
    return "_MediaSourceGetStreamsParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class MediaSourceGetStreamsResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<MediaSourceStreamDescriptor> streams = null;

  MediaSourceGetStreamsResponseParams() : super(kVersions.last.size);

  static MediaSourceGetStreamsResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaSourceGetStreamsResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaSourceGetStreamsResponseParams result = new MediaSourceGetStreamsResponseParams();

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
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.streams = new List<MediaSourceStreamDescriptor>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.streams[i1] = MediaSourceStreamDescriptor.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      if (streams == null) {
        encoder0.encodeNullPointer(8, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(streams.length, 8, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < streams.length; ++i0) {
          encoder1.encodeStruct(streams[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "streams of struct MediaSourceGetStreamsResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaSourceGetStreamsResponseParams("
           "streams: $streams" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["streams"] = streams;
    return map;
  }
}


class _MediaSourceGetProducerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int streamIndex = 0;
  Object producer = null;

  _MediaSourceGetProducerParams() : super(kVersions.last.size);

  static _MediaSourceGetProducerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSourceGetProducerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSourceGetProducerParams result = new _MediaSourceGetProducerParams();

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
      
      result.streamIndex = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.producer = decoder0.decodeInterfaceRequest(12, false, media_transport_mojom.MediaProducerStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(streamIndex, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "streamIndex of struct _MediaSourceGetProducerParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(producer, 12, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "producer of struct _MediaSourceGetProducerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaSourceGetProducerParams("
           "streamIndex: $streamIndex" ", "
           "producer: $producer" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _MediaSourceGetPullModeProducerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int streamIndex = 0;
  Object producer = null;

  _MediaSourceGetPullModeProducerParams() : super(kVersions.last.size);

  static _MediaSourceGetPullModeProducerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSourceGetPullModeProducerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSourceGetPullModeProducerParams result = new _MediaSourceGetPullModeProducerParams();

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
      
      result.streamIndex = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.producer = decoder0.decodeInterfaceRequest(12, false, media_transport_mojom.MediaPullModeProducerStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(streamIndex, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "streamIndex of struct _MediaSourceGetPullModeProducerParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(producer, 12, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "producer of struct _MediaSourceGetPullModeProducerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaSourceGetPullModeProducerParams("
           "streamIndex: $streamIndex" ", "
           "producer: $producer" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _MediaSourceGetStatusParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int versionLastSeen = 0;

  _MediaSourceGetStatusParams() : super(kVersions.last.size);

  static _MediaSourceGetStatusParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSourceGetStatusParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSourceGetStatusParams result = new _MediaSourceGetStatusParams();

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
      
      result.versionLastSeen = decoder0.decodeUint64(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint64(versionLastSeen, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "versionLastSeen of struct _MediaSourceGetStatusParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaSourceGetStatusParams("
           "versionLastSeen: $versionLastSeen" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["versionLastSeen"] = versionLastSeen;
    return map;
  }
}


class MediaSourceGetStatusResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int version = 0;
  MediaSourceStatus status = null;

  MediaSourceGetStatusResponseParams() : super(kVersions.last.size);

  static MediaSourceGetStatusResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaSourceGetStatusResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaSourceGetStatusResponseParams result = new MediaSourceGetStatusResponseParams();

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
      
      result.version = decoder0.decodeUint64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.status = MediaSourceStatus.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint64(version, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "version of struct MediaSourceGetStatusResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(status, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "status of struct MediaSourceGetStatusResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaSourceGetStatusResponseParams("
           "version: $version" ", "
           "status: $status" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["version"] = version;
    map["status"] = status;
    return map;
  }
}


class _MediaSourcePrepareParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaSourcePrepareParams() : super(kVersions.last.size);

  static _MediaSourcePrepareParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSourcePrepareParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSourcePrepareParams result = new _MediaSourcePrepareParams();

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
    return "_MediaSourcePrepareParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class MediaSourcePrepareResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  MediaSourcePrepareResponseParams() : super(kVersions.last.size);

  static MediaSourcePrepareResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaSourcePrepareResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaSourcePrepareResponseParams result = new MediaSourcePrepareResponseParams();

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
    return "MediaSourcePrepareResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _MediaSourcePrimeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaSourcePrimeParams() : super(kVersions.last.size);

  static _MediaSourcePrimeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSourcePrimeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSourcePrimeParams result = new _MediaSourcePrimeParams();

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
    return "_MediaSourcePrimeParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class MediaSourcePrimeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  MediaSourcePrimeResponseParams() : super(kVersions.last.size);

  static MediaSourcePrimeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaSourcePrimeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaSourcePrimeResponseParams result = new MediaSourcePrimeResponseParams();

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
    return "MediaSourcePrimeResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _MediaSourceFlushParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaSourceFlushParams() : super(kVersions.last.size);

  static _MediaSourceFlushParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSourceFlushParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSourceFlushParams result = new _MediaSourceFlushParams();

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
    return "_MediaSourceFlushParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class MediaSourceFlushResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  MediaSourceFlushResponseParams() : super(kVersions.last.size);

  static MediaSourceFlushResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaSourceFlushResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaSourceFlushResponseParams result = new MediaSourceFlushResponseParams();

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
    return "MediaSourceFlushResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _MediaSourceSeekParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int position = 0;

  _MediaSourceSeekParams() : super(kVersions.last.size);

  static _MediaSourceSeekParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSourceSeekParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSourceSeekParams result = new _MediaSourceSeekParams();

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
      
      result.position = decoder0.decodeInt64(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(position, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "position of struct _MediaSourceSeekParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaSourceSeekParams("
           "position: $position" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["position"] = position;
    return map;
  }
}


class MediaSourceSeekResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  MediaSourceSeekResponseParams() : super(kVersions.last.size);

  static MediaSourceSeekResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaSourceSeekResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaSourceSeekResponseParams result = new MediaSourceSeekResponseParams();

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
    return "MediaSourceSeekResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _mediaSourceMethodGetStreamsName = 0;
const int _mediaSourceMethodGetProducerName = 1;
const int _mediaSourceMethodGetPullModeProducerName = 2;
const int _mediaSourceMethodGetStatusName = 3;
const int _mediaSourceMethodPrepareName = 4;
const int _mediaSourceMethodPrimeName = 5;
const int _mediaSourceMethodFlushName = 6;
const int _mediaSourceMethodSeekName = 7;

class _MediaSourceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class MediaSource {
  static const String serviceName = null;
  dynamic getStreams([Function responseFactory = null]);
  void getProducer(int streamIndex, Object producer);
  void getPullModeProducer(int streamIndex, Object producer);
  dynamic getStatus(int versionLastSeen,[Function responseFactory = null]);
  dynamic prepare([Function responseFactory = null]);
  dynamic prime([Function responseFactory = null]);
  dynamic flush([Function responseFactory = null]);
  dynamic seek(int position,[Function responseFactory = null]);
  static const int kInitialStatus = 0;
}


class _MediaSourceProxyImpl extends bindings.Proxy {
  _MediaSourceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _MediaSourceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _MediaSourceProxyImpl.unbound() : super.unbound();

  static _MediaSourceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _MediaSourceProxyImpl"));
    return new _MediaSourceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _MediaSourceServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _mediaSourceMethodGetStreamsName:
        var r = MediaSourceGetStreamsResponseParams.deserialize(
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
      case _mediaSourceMethodGetStatusName:
        var r = MediaSourceGetStatusResponseParams.deserialize(
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
      case _mediaSourceMethodPrepareName:
        var r = MediaSourcePrepareResponseParams.deserialize(
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
      case _mediaSourceMethodPrimeName:
        var r = MediaSourcePrimeResponseParams.deserialize(
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
      case _mediaSourceMethodFlushName:
        var r = MediaSourceFlushResponseParams.deserialize(
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
      case _mediaSourceMethodSeekName:
        var r = MediaSourceSeekResponseParams.deserialize(
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
    return "_MediaSourceProxyImpl($superString)";
  }
}


class _MediaSourceProxyCalls implements MediaSource {
  _MediaSourceProxyImpl _proxyImpl;

  _MediaSourceProxyCalls(this._proxyImpl);
    dynamic getStreams([Function responseFactory = null]) {
      var params = new _MediaSourceGetStreamsParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _mediaSourceMethodGetStreamsName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void getProducer(int streamIndex, Object producer) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _MediaSourceGetProducerParams();
      params.streamIndex = streamIndex;
      params.producer = producer;
      _proxyImpl.sendMessage(params, _mediaSourceMethodGetProducerName);
    }
    void getPullModeProducer(int streamIndex, Object producer) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _MediaSourceGetPullModeProducerParams();
      params.streamIndex = streamIndex;
      params.producer = producer;
      _proxyImpl.sendMessage(params, _mediaSourceMethodGetPullModeProducerName);
    }
    dynamic getStatus(int versionLastSeen,[Function responseFactory = null]) {
      var params = new _MediaSourceGetStatusParams();
      params.versionLastSeen = versionLastSeen;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _mediaSourceMethodGetStatusName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic prepare([Function responseFactory = null]) {
      var params = new _MediaSourcePrepareParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _mediaSourceMethodPrepareName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic prime([Function responseFactory = null]) {
      var params = new _MediaSourcePrimeParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _mediaSourceMethodPrimeName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic flush([Function responseFactory = null]) {
      var params = new _MediaSourceFlushParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _mediaSourceMethodFlushName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic seek(int position,[Function responseFactory = null]) {
      var params = new _MediaSourceSeekParams();
      params.position = position;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _mediaSourceMethodSeekName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class MediaSourceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  MediaSource ptr;

  MediaSourceProxy(_MediaSourceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _MediaSourceProxyCalls(proxyImpl);

  MediaSourceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _MediaSourceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _MediaSourceProxyCalls(impl);
  }

  MediaSourceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _MediaSourceProxyImpl.fromHandle(handle) {
    ptr = new _MediaSourceProxyCalls(impl);
  }

  MediaSourceProxy.unbound() :
      impl = new _MediaSourceProxyImpl.unbound() {
    ptr = new _MediaSourceProxyCalls(impl);
  }

  factory MediaSourceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    MediaSourceProxy p = new MediaSourceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static MediaSourceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaSourceProxy"));
    return new MediaSourceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => MediaSource.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "MediaSourceProxy($impl)";
  }
}


class MediaSourceStub extends bindings.Stub {
  MediaSource _impl = null;

  MediaSourceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  MediaSourceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  MediaSourceStub.unbound() : super.unbound();

  static MediaSourceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaSourceStub"));
    return new MediaSourceStub.fromEndpoint(endpoint);
  }


  MediaSourceGetStreamsResponseParams _mediaSourceGetStreamsResponseParamsFactory(List<MediaSourceStreamDescriptor> streams) {
    var result = new MediaSourceGetStreamsResponseParams();
    result.streams = streams;
    return result;
  }
  MediaSourceGetStatusResponseParams _mediaSourceGetStatusResponseParamsFactory(int version, MediaSourceStatus status) {
    var result = new MediaSourceGetStatusResponseParams();
    result.version = version;
    result.status = status;
    return result;
  }
  MediaSourcePrepareResponseParams _mediaSourcePrepareResponseParamsFactory() {
    var result = new MediaSourcePrepareResponseParams();
    return result;
  }
  MediaSourcePrimeResponseParams _mediaSourcePrimeResponseParamsFactory() {
    var result = new MediaSourcePrimeResponseParams();
    return result;
  }
  MediaSourceFlushResponseParams _mediaSourceFlushResponseParamsFactory() {
    var result = new MediaSourceFlushResponseParams();
    return result;
  }
  MediaSourceSeekResponseParams _mediaSourceSeekResponseParamsFactory() {
    var result = new MediaSourceSeekResponseParams();
    return result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _mediaSourceMethodGetStreamsName:
        var response = _impl.getStreams(_mediaSourceGetStreamsResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaSourceMethodGetStreamsName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaSourceMethodGetStreamsName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _mediaSourceMethodGetProducerName:
        var params = _MediaSourceGetProducerParams.deserialize(
            message.payload);
        _impl.getProducer(params.streamIndex, params.producer);
        break;
      case _mediaSourceMethodGetPullModeProducerName:
        var params = _MediaSourceGetPullModeProducerParams.deserialize(
            message.payload);
        _impl.getPullModeProducer(params.streamIndex, params.producer);
        break;
      case _mediaSourceMethodGetStatusName:
        var params = _MediaSourceGetStatusParams.deserialize(
            message.payload);
        var response = _impl.getStatus(params.versionLastSeen,_mediaSourceGetStatusResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaSourceMethodGetStatusName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaSourceMethodGetStatusName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _mediaSourceMethodPrepareName:
        var response = _impl.prepare(_mediaSourcePrepareResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaSourceMethodPrepareName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaSourceMethodPrepareName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _mediaSourceMethodPrimeName:
        var response = _impl.prime(_mediaSourcePrimeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaSourceMethodPrimeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaSourceMethodPrimeName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _mediaSourceMethodFlushName:
        var response = _impl.flush(_mediaSourceFlushResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaSourceMethodFlushName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaSourceMethodFlushName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _mediaSourceMethodSeekName:
        var params = _MediaSourceSeekParams.deserialize(
            message.payload);
        var response = _impl.seek(params.position,_mediaSourceSeekResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaSourceMethodSeekName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaSourceMethodSeekName,
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

  MediaSource get impl => _impl;
  set impl(MediaSource d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "MediaSourceStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _MediaSourceServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



