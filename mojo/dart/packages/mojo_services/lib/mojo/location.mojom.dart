// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library location_mojom;
import 'package:mojo/bindings.dart' as bindings;




class Location extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(64, 0)
  ];
  int time = 0;
  bool hasElapsedRealTimeNanos = false;
  bool hasAltitude = false;
  bool hasSpeed = false;
  bool hasBearing = false;
  bool hasAccuracy = false;
  double speed = 0.0;
  int elapsedRealTimeNanos = 0;
  double latitude = 0.0;
  double longitude = 0.0;
  double altitude = 0.0;
  double bearing = 0.0;
  double accuracy = 0.0;

  Location() : super(kVersions.last.size);

  static Location deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Location decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Location result = new Location();

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
      
      result.time = decoder0.decodeUint64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.hasElapsedRealTimeNanos = decoder0.decodeBool(16, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.hasAltitude = decoder0.decodeBool(16, 1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.hasSpeed = decoder0.decodeBool(16, 2);
    }
    if (mainDataHeader.version >= 0) {
      
      result.hasBearing = decoder0.decodeBool(16, 3);
    }
    if (mainDataHeader.version >= 0) {
      
      result.hasAccuracy = decoder0.decodeBool(16, 4);
    }
    if (mainDataHeader.version >= 0) {
      
      result.speed = decoder0.decodeFloat(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.elapsedRealTimeNanos = decoder0.decodeUint64(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.latitude = decoder0.decodeDouble(32);
    }
    if (mainDataHeader.version >= 0) {
      
      result.longitude = decoder0.decodeDouble(40);
    }
    if (mainDataHeader.version >= 0) {
      
      result.altitude = decoder0.decodeDouble(48);
    }
    if (mainDataHeader.version >= 0) {
      
      result.bearing = decoder0.decodeFloat(56);
    }
    if (mainDataHeader.version >= 0) {
      
      result.accuracy = decoder0.decodeFloat(60);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint64(time, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "time of struct Location: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(hasElapsedRealTimeNanos, 16, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "hasElapsedRealTimeNanos of struct Location: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(hasAltitude, 16, 1);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "hasAltitude of struct Location: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(hasSpeed, 16, 2);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "hasSpeed of struct Location: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(hasBearing, 16, 3);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "hasBearing of struct Location: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(hasAccuracy, 16, 4);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "hasAccuracy of struct Location: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(speed, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "speed of struct Location: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint64(elapsedRealTimeNanos, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "elapsedRealTimeNanos of struct Location: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(latitude, 32);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "latitude of struct Location: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(longitude, 40);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "longitude of struct Location: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(altitude, 48);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "altitude of struct Location: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(bearing, 56);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "bearing of struct Location: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(accuracy, 60);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "accuracy of struct Location: $e";
      rethrow;
    }
  }

  String toString() {
    return "Location("
           "time: $time" ", "
           "hasElapsedRealTimeNanos: $hasElapsedRealTimeNanos" ", "
           "hasAltitude: $hasAltitude" ", "
           "hasSpeed: $hasSpeed" ", "
           "hasBearing: $hasBearing" ", "
           "hasAccuracy: $hasAccuracy" ", "
           "speed: $speed" ", "
           "elapsedRealTimeNanos: $elapsedRealTimeNanos" ", "
           "latitude: $latitude" ", "
           "longitude: $longitude" ", "
           "altitude: $altitude" ", "
           "bearing: $bearing" ", "
           "accuracy: $accuracy" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["time"] = time;
    map["hasElapsedRealTimeNanos"] = hasElapsedRealTimeNanos;
    map["hasAltitude"] = hasAltitude;
    map["hasSpeed"] = hasSpeed;
    map["hasBearing"] = hasBearing;
    map["hasAccuracy"] = hasAccuracy;
    map["speed"] = speed;
    map["elapsedRealTimeNanos"] = elapsedRealTimeNanos;
    map["latitude"] = latitude;
    map["longitude"] = longitude;
    map["altitude"] = altitude;
    map["bearing"] = bearing;
    map["accuracy"] = accuracy;
    return map;
  }
}






