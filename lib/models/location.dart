

class UserLocation {
  final double latitude;
  final double longitude;
  final geoPoint;
  final geoHash;
  final DateTime lastUpdated;
  UserLocation({
    this.latitude,
    this.longitude,
    this.geoPoint,
    this.geoHash,
    this.lastUpdated,
  });

  UserLocation.formMap(Map<String,dynamic> snapshot):
    latitude=snapshot['latitude']?? 0,
    longitude=snapshot['longitude']?? 0,
    geoPoint=snapshot['geopoint']?? '',
    geoHash=snapshot['geohash']?? '',
    lastUpdated=snapshot['last_updated']?? '';

}
