
import 'package:cloud_firestore/cloud_firestore.dart';

class Location {
  final double latitude;
  final double longitude;
  final GeoPoint geoPoint;
  final  geoHash;
  Location({
    this.latitude,
    this.longitude,
    this.geoPoint,
    this.geoHash,
  });

  Location.formMap(Map<String,dynamic> snapshot):
    latitude=snapshot['latitude']?? 0,
    longitude=snapshot['longitude']?? 0,
    geoPoint=snapshot['geopoint']?? '',
    geoHash=snapshot['geohash']?? '';

}
