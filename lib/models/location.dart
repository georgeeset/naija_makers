
import 'package:geoflutterfire/geoflutterfire.dart';

class UserLocation {
  final double latitude;
  final double longitude;
  final GeoFirePoint geoPoint;
  //final String geoHash;
  final int timestamp;
  UserLocation({
    this.latitude,
    this.longitude,
    this.geoPoint,
    //this.geoHash,
    this.timestamp,
  });

  UserLocation.formMap(Map<String,dynamic> snapshot,):
    latitude=snapshot['latitude']?? 0,
    longitude=snapshot['longitude']?? 0,
    geoPoint=snapshot['geopoint']?? '',
    //geoHash=snapshot['geohash']?? '',
    timestamp=snapshot['time_stamp'];
}
