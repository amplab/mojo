// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library media_demux_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/media/media_metadata.mojom.dart' as media_metadata_mojom;
import 'package:mojo_services/mojo/media/media_transport.mojom.dart' as media_transport_mojom;
import 'package:mojo_services/mojo/media/media_types.mojom.dart' as media_types_mojom;



class _MediaDemuxDescribeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaDemuxDescribeParams() : super(kVersions.last.size);

  static _MediaDemuxDescribeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaDemuxDescribeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaDemuxDescribeParams result = new _MediaDemuxDescribeParams();

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
    return "_MediaDemuxDescribeParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class MediaDemuxDescribeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<media_types_mojom.MediaType> streamTypes = null;

  MediaDemuxDescribeResponseParams() : super(kVersions.last.size);

  static MediaDemuxDescribeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaDemuxDescribeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaDemuxDescribeResponseParams result = new MediaDemuxDescribeResponseParams();

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
        result.streamTypes = new List<media_types_mojom.MediaType>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.streamTypes[i1] = media_types_mojom.MediaType.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      if (streamTypes == null) {
        encoder0.encodeNullPointer(8, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(streamTypes.length, 8, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < streamTypes.length; ++i0) {
          encoder1.encodeStruct(streamTypes[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "streamTypes of struct MediaDemuxDescribeResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaDemuxDescribeResponseParams("
           "streamTypes: $streamTypes" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["streamTypes"] = streamTypes;
    return map;
  }
}


class _MediaDemuxGetProducerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int streamIndex = 0;
  Object producer = null;

  _MediaDemuxGetProducerParams() : super(kVersions.last.size);

  static _MediaDemuxGetProducerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaDemuxGetProducerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaDemuxGetProducerParams result = new _MediaDemuxGetProducerParams();

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
          "streamIndex of struct _MediaDemuxGetProducerParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(producer, 12, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "producer of struct _MediaDemuxGetProducerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaDemuxGetProducerParams("
           "streamIndex: $streamIndex" ", "
           "producer: $producer" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _MediaDemuxGetMetadataParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int versionLastSeen = 0;

  _MediaDemuxGetMetadataParams() : super(kVersions.last.size);

  static _MediaDemuxGetMetadataParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaDemuxGetMetadataParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaDemuxGetMetadataParams result = new _MediaDemuxGetMetadataParams();

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
          "versionLastSeen of struct _MediaDemuxGetMetadataParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaDemuxGetMetadataParams("
           "versionLastSeen: $versionLastSeen" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["versionLastSeen"] = versionLastSeen;
    return map;
  }
}


class MediaDemuxGetMetadataResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int version = 0;
  media_metadata_mojom.MediaMetadata metadata = null;

  MediaDemuxGetMetadataResponseParams() : super(kVersions.last.size);

  static MediaDemuxGetMetadataResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaDemuxGetMetadataResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaDemuxGetMetadataResponseParams result = new MediaDemuxGetMetadataResponseParams();

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
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.metadata = media_metadata_mojom.MediaMetadata.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint64(version, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "version of struct MediaDemuxGetMetadataResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(metadata, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "metadata of struct MediaDemuxGetMetadataResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaDemuxGetMetadataResponseParams("
           "version: $version" ", "
           "metadata: $metadata" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["version"] = version;
    map["metadata"] = metadata;
    return map;
  }
}


class _MediaDemuxPrimeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaDemuxPrimeParams() : super(kVersions.last.size);

  static _MediaDemuxPrimeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaDemuxPrimeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaDemuxPrimeParams result = new _MediaDemuxPrimeParams();

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
    return "_MediaDemuxPrimeParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class MediaDemuxPrimeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  MediaDemuxPrimeResponseParams() : super(kVersions.last.size);

  static MediaDemuxPrimeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaDemuxPrimeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaDemuxPrimeResponseParams result = new MediaDemuxPrimeResponseParams();

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
    return "MediaDemuxPrimeResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _MediaDemuxFlushParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaDemuxFlushParams() : super(kVersions.last.size);

  static _MediaDemuxFlushParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaDemuxFlushParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaDemuxFlushParams result = new _MediaDemuxFlushParams();

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
    return "_MediaDemuxFlushParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class MediaDemuxFlushResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  MediaDemuxFlushResponseParams() : super(kVersions.last.size);

  static MediaDemuxFlushResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaDemuxFlushResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaDemuxFlushResponseParams result = new MediaDemuxFlushResponseParams();

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
    return "MediaDemuxFlushResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _MediaDemuxSeekParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int position = 0;

  _MediaDemuxSeekParams() : super(kVersions.last.size);

  static _MediaDemuxSeekParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaDemuxSeekParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaDemuxSeekParams result = new _MediaDemuxSeekParams();

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
          "position of struct _MediaDemuxSeekParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaDemuxSeekParams("
           "position: $position" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["position"] = position;
    return map;
  }
}


class MediaDemuxSeekResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  MediaDemuxSeekResponseParams() : super(kVersions.last.size);

  static MediaDemuxSeekResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaDemuxSeekResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaDemuxSeekResponseParams result = new MediaDemuxSeekResponseParams();

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
    return "MediaDemuxSeekResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _mediaDemuxMethodDescribeName = 0;
const int _mediaDemuxMethodGetProducerName = 1;
const int _mediaDemuxMethodGetMetadataName = 2;
const int _mediaDemuxMethodPrimeName = 3;
const int _mediaDemuxMethodFlushName = 4;
const int _mediaDemuxMethodSeekName = 5;

class _MediaDemuxServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class MediaDemux {
  static const String serviceName = null;
  dynamic describe([Function responseFactory = null]);
  void getProducer(int streamIndex, Object producer);
  dynamic getMetadata(int versionLastSeen,[Function responseFactory = null]);
  dynamic prime([Function responseFactory = null]);
  dynamic flush([Function responseFactory = null]);
  dynamic seek(int position,[Function responseFactory = null]);
  static const int kInitialMetadata = 0;
}


class _MediaDemuxProxyImpl extends bindings.Proxy {
  _MediaDemuxProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _MediaDemuxProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _MediaDemuxProxyImpl.unbound() : super.unbound();

  static _MediaDemuxProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _MediaDemuxProxyImpl"));
    return new _MediaDemuxProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _MediaDemuxServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _mediaDemuxMethodDescribeName:
        var r = MediaDemuxDescribeResponseParams.deserialize(
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
      case _mediaDemuxMethodGetMetadataName:
        var r = MediaDemuxGetMetadataResponseParams.deserialize(
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
      case _mediaDemuxMethodPrimeName:
        var r = MediaDemuxPrimeResponseParams.deserialize(
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
      case _mediaDemuxMethodFlushName:
        var r = MediaDemuxFlushResponseParams.deserialize(
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
      case _mediaDemuxMethodSeekName:
        var r = MediaDemuxSeekResponseParams.deserialize(
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
    return "_MediaDemuxProxyImpl($superString)";
  }
}


class _MediaDemuxProxyCalls implements MediaDemux {
  _MediaDemuxProxyImpl _proxyImpl;

  _MediaDemuxProxyCalls(this._proxyImpl);
    dynamic describe([Function responseFactory = null]) {
      var params = new _MediaDemuxDescribeParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _mediaDemuxMethodDescribeName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void getProducer(int streamIndex, Object producer) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _MediaDemuxGetProducerParams();
      params.streamIndex = streamIndex;
      params.producer = producer;
      _proxyImpl.sendMessage(params, _mediaDemuxMethodGetProducerName);
    }
    dynamic getMetadata(int versionLastSeen,[Function responseFactory = null]) {
      var params = new _MediaDemuxGetMetadataParams();
      params.versionLastSeen = versionLastSeen;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _mediaDemuxMethodGetMetadataName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic prime([Function responseFactory = null]) {
      var params = new _MediaDemuxPrimeParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _mediaDemuxMethodPrimeName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic flush([Function responseFactory = null]) {
      var params = new _MediaDemuxFlushParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _mediaDemuxMethodFlushName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic seek(int position,[Function responseFactory = null]) {
      var params = new _MediaDemuxSeekParams();
      params.position = position;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _mediaDemuxMethodSeekName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class MediaDemuxProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  MediaDemux ptr;

  MediaDemuxProxy(_MediaDemuxProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _MediaDemuxProxyCalls(proxyImpl);

  MediaDemuxProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _MediaDemuxProxyImpl.fromEndpoint(endpoint) {
    ptr = new _MediaDemuxProxyCalls(impl);
  }

  MediaDemuxProxy.fromHandle(core.MojoHandle handle) :
      impl = new _MediaDemuxProxyImpl.fromHandle(handle) {
    ptr = new _MediaDemuxProxyCalls(impl);
  }

  MediaDemuxProxy.unbound() :
      impl = new _MediaDemuxProxyImpl.unbound() {
    ptr = new _MediaDemuxProxyCalls(impl);
  }

  factory MediaDemuxProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    MediaDemuxProxy p = new MediaDemuxProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static MediaDemuxProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaDemuxProxy"));
    return new MediaDemuxProxy.fromEndpoint(endpoint);
  }

  String get serviceName => MediaDemux.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "MediaDemuxProxy($impl)";
  }
}


class MediaDemuxStub extends bindings.Stub {
  MediaDemux _impl;

  MediaDemuxStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [MediaDemux impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  MediaDemuxStub.fromHandle(
      core.MojoHandle handle, [MediaDemux impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  MediaDemuxStub.unbound() : super.unbound();

  static MediaDemuxStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaDemuxStub"));
    return new MediaDemuxStub.fromEndpoint(endpoint);
  }


  MediaDemuxDescribeResponseParams _mediaDemuxDescribeResponseParamsFactory(List<media_types_mojom.MediaType> streamTypes) {
    var result = new MediaDemuxDescribeResponseParams();
    result.streamTypes = streamTypes;
    return result;
  }
  MediaDemuxGetMetadataResponseParams _mediaDemuxGetMetadataResponseParamsFactory(int version, media_metadata_mojom.MediaMetadata metadata) {
    var result = new MediaDemuxGetMetadataResponseParams();
    result.version = version;
    result.metadata = metadata;
    return result;
  }
  MediaDemuxPrimeResponseParams _mediaDemuxPrimeResponseParamsFactory() {
    var result = new MediaDemuxPrimeResponseParams();
    return result;
  }
  MediaDemuxFlushResponseParams _mediaDemuxFlushResponseParamsFactory() {
    var result = new MediaDemuxFlushResponseParams();
    return result;
  }
  MediaDemuxSeekResponseParams _mediaDemuxSeekResponseParamsFactory() {
    var result = new MediaDemuxSeekResponseParams();
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
      case _mediaDemuxMethodDescribeName:
        var response = _impl.describe(_mediaDemuxDescribeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaDemuxMethodDescribeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaDemuxMethodDescribeName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _mediaDemuxMethodGetProducerName:
        var params = _MediaDemuxGetProducerParams.deserialize(
            message.payload);
        _impl.getProducer(params.streamIndex, params.producer);
        break;
      case _mediaDemuxMethodGetMetadataName:
        var params = _MediaDemuxGetMetadataParams.deserialize(
            message.payload);
        var response = _impl.getMetadata(params.versionLastSeen,_mediaDemuxGetMetadataResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaDemuxMethodGetMetadataName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaDemuxMethodGetMetadataName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _mediaDemuxMethodPrimeName:
        var response = _impl.prime(_mediaDemuxPrimeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaDemuxMethodPrimeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaDemuxMethodPrimeName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _mediaDemuxMethodFlushName:
        var response = _impl.flush(_mediaDemuxFlushResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaDemuxMethodFlushName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaDemuxMethodFlushName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _mediaDemuxMethodSeekName:
        var params = _MediaDemuxSeekParams.deserialize(
            message.payload);
        var response = _impl.seek(params.position,_mediaDemuxSeekResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaDemuxMethodSeekName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaDemuxMethodSeekName,
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

  MediaDemux get impl => _impl;
  set impl(MediaDemux d) {
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
    return "MediaDemuxStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _MediaDemuxServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



