import 'package:devlomatix/utils/pref.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import 'package:geolocator/geolocator.dart';

class AppProvider extends ChangeNotifier {
  int bottonNavIndex = 0;
  bool loadOnboard = true;

  bool location = true;
  String city = '';
  String pincode = '';
  double longitude = 0.0;
  double lattitude = 0.0;

  void changeBottomNav(index) {
    bottonNavIndex = index;
    notifyListeners();
  }

  onboarding() async {
    bool onboard = await SharePref.getBool('onboard');

    if (onboard == false) {
      return true;
    } else {
      return false;
    }
  }

  void appSplashLoad() async {
    print('App Splash Screen');

    bool _onBoarding = await SharePref.getBool('onBoarding');
    bool _loggedIn = await SharePref.getBool('loggedIn');
    String token = await SharePref.getString('token');

    print(_onBoarding.toString());
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
