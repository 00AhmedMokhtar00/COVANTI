
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../prefs/pref_keys.dart';
import '../prefs/pref_utils.dart';

class PrefManager {
  static String country;
  static String country_code;
  static LatLng current_location;

  static Future<void> initialPref()async{
    country = await getCountry();
    country_code = await getCountryCode();
    current_location = LatLng(await getLocationLatitude(), await getLocationLongitude());
  }

  static Future<String> getCountry() async {
    return await PrefUtils.getString(PrefKeys.COUNTRY)?? PrefDefaultValues.NO_COUNTRY;
  }

  static Future<String> getCountryCode() async {
    return await PrefUtils.getString(PrefKeys.COUNTRY_CODE)?? PrefDefaultValues.NO_COUNTRY_CODE;
  }

  static Future<double> getLocationLatitude() async {
    return await PrefUtils.getDouble(PrefKeys.LOCATION_LATITUDE)?? PrefDefaultValues.NO_LOCATION_LATITUDE;
  }

  static Future<double> getLocationLongitude() async {
    return await PrefUtils.getDouble(PrefKeys.LOCATION_LONGITUDE)?? PrefDefaultValues.NO_LOCATION_LONGITUDE;
  }


  static Future<bool> getUserLocation() async {
    LocationData myLocation;
    String error;
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    Location location = Location();
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    try {
      if(await checkInternetConnectivity()) {
        myLocation = await location.getLocation();
        current_location = LatLng(myLocation.latitude, myLocation.longitude);
      }else{
        return false;
      }
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'please grant permission';
      }
      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'permission denied- please enable it from app settings';
        print(error);
      }
      myLocation = null;
      return false;
    }catch(e){
      print("ERROR");
    }
    //currentLocation = myLocation;
    final coordinates = Coordinates(
        myLocation.latitude, myLocation.longitude
    );

    List<Address> addresses;
    try {
      addresses = await Geocoder.local.findAddressesFromCoordinates(
          coordinates);
    }catch(e){
      print('Can\'t get location');
      return false;
    }
    var first = addresses.first;
    country = first.countryName;
    country_code = first.countryCode;
    print('${first.countryCode}%20${first.countryName},');
    return true;
  }

  // ignore: missing_return
  static Future<bool> checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      return false;
    } else if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
      return true;
    }
  }
}
