
class Location {
  final double latitude;
  final double longitude;
  final geoPoint;
  final geoHash;
  Location({
    this.latitude,
    this.longitude,
    this.geoPoint,
    this.geoHash,
  });

  Location.formMap(Map<String,dynamic> snapshot):
    latitude=snapshot['latitude']?? '',
    longitude=snapshot['longitude']?? '',
    geoPoint=snapshot['geopoint']?? '',
    geoHash=snapshot['geohash']?? '';

}
