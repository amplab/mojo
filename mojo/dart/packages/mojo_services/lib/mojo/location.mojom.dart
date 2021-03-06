// WARNING: DO NOT EDIT. This file was generated by a program.
// See $MOJO_SDK/tools/bindings/mojom_bindings_generator.py.

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

  Location.init(
    int this.time, 
    bool this.hasElapsedRealTimeNanos, 
    bool this.hasAltitude, 
    bool this.hasSpeed, 
    bool this.hasBearing, 
    bool this.hasAccuracy, 
    double this.speed, 
    int this.elapsedRealTimeNanos, 
    double this.latitude, 
    double this.longitude, 
    double this.altitude, 
    double this.bearing, 
    double this.accuracy
  ) : super(kVersions.last.size);

  static Location deserialize(bindings.Message message) =>
      bindings.Struct.deserialize(decode, message);

  static Location decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Location result = new Location();

    var mainDataHeader = bindings.Struct.checkVersion(decoder0, kVersions);
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
    const String structName = "Location";
    String fieldName;
    try {
      fieldName = "time";
      encoder0.encodeUint64(time, 8);
      fieldName = "hasElapsedRealTimeNanos";
      encoder0.encodeBool(hasElapsedRealTimeNanos, 16, 0);
      fieldName = "hasAltitude";
      encoder0.encodeBool(hasAltitude, 16, 1);
      fieldName = "hasSpeed";
      encoder0.encodeBool(hasSpeed, 16, 2);
      fieldName = "hasBearing";
      encoder0.encodeBool(hasBearing, 16, 3);
      fieldName = "hasAccuracy";
      encoder0.encodeBool(hasAccuracy, 16, 4);
      fieldName = "speed";
      encoder0.encodeFloat(speed, 20);
      fieldName = "elapsedRealTimeNanos";
      encoder0.encodeUint64(elapsedRealTimeNanos, 24);
      fieldName = "latitude";
      encoder0.encodeDouble(latitude, 32);
      fieldName = "longitude";
      encoder0.encodeDouble(longitude, 40);
      fieldName = "altitude";
      encoder0.encodeDouble(altitude, 48);
      fieldName = "bearing";
      encoder0.encodeFloat(bearing, 56);
      fieldName = "accuracy";
      encoder0.encodeFloat(accuracy, 60);
    } on bindings.MojoCodecError catch(e) {
      bindings.Struct.fixErrorMessage(e, fieldName, structName);
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



