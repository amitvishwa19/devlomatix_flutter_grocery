import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider extends ChangeNotifier {
  bool location = true;
  String city = 'New Delhi';
  String pincode = '390002';
  double longitude = 28.6139;
  double lattitude = 77.2090;

  bool locationServiceActive = false;
  bool locationSet = false;
  LatLng? latLng;

  locationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print('No permission is there to use location service');
      locationServiceActive = false;
      LocationPermission permissionAsked = await Geolocator.requestPermission();
    } else {
      locationServiceActive = true;
      var currentPposition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    }
  }

  getUserLocation() async {
    if (locationServiceActive) {
      print('---------Get current location-----------');
      var currentPposition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      var lastPosition = await Geolocator.getLastKnownPosition();
      lattitude = currentPposition.latitude.toDouble();
      longitude = currentPposition.longitude.toDouble();

      List<Placemark> placemarks =
          await placemarkFromCoordinates(lattitude, longitude);

      Placemark place = placemarks[0];
      city = place.locality.toString();
      pincode = place.postalCode.toString();

      notifyListeners();
    }
  }

  void getLocation() async {
    bool serviceEnabled;

    LocationPermission permission = await Geolocator.checkPermission();

    print('Permission : ${permission}');

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print('No permission is there to use location service');
      LocationPermission permissionAsked = await Geolocator.requestPermission();
    } else {
      var currentPposition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      var lastPosition = await Geolocator.getLastKnownPosition();
      lattitude = currentPposition.latitude.toDouble();
      longitude = currentPposition.longitude.toDouble();

      List<Placemark> placemarks =
          await placemarkFromCoordinates(lattitude, longitude);

      Placemark place = placemarks[0];
      city = place.locality.toString();
      pincode = place.postalCode.toString();

      notifyListeners();
    }
  }
}
