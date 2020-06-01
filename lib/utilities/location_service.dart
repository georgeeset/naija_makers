import 'dart:async';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';
import '../models/location.dart';

class LocationService {
  UserLocation _currentLocation;
  var location = Location();
  Geoflutterfire geo = Geoflutterfire();

  Future<UserLocation> getLocation() async {
    await location.requestPermission().then((granted) async {
      // location.changeSettings(accuracy: LocationAccuracy.high,interval: 5000,distanceFilter: 10);
      if (granted==PermissionStatus.granted) {
        // If granted 
        try {
          var userLocation = await location.getLocation();
          _currentLocation = UserLocation(
            latitude: userLocation.latitude,
            longitude: userLocation.longitude,
          );
        } on Exception catch (e) {
          print('Could not get location: ${e.toString()}');
          throw 'Could not get location: ${e.toString()}';
        }
        
      }else{throw 'Location Permision not granted';}
    });
    return _currentLocation;
  }

  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>();

  Stream<UserLocation> get getlocationStream => _locationController.stream;
  LocationService() {
    // Request permission to use location
    location.requestPermission().then((granted) {
      // location.changeSettings(accuracy: LocationAccuracy.high,interval: 5000,distanceFilter: 10);
      if (granted==PermissionStatus.granted) {
        // If granted listen to the onLocationChanged stream and emit over our controller

        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            GeoFirePoint myLocation = geo.point(
                latitude: locationData.latitude,
                longitude: locationData.longitude);
            _locationController.add(UserLocation(
              latitude: locationData.latitude,
              longitude: locationData.longitude,
              geoPoint: myLocation.geoPoint,
              geoHash: myLocation.hash,
            ));
          }
        });
      }
    });
   }
  }
