import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:solution_challenge/res/assets.dart';

import '../prefs/pref_keys.dart';
import '../prefs/pref_utils.dart';

class PrefManager {
  static String country;
  static String country_code;
  static LatLng current_location;
  static int cases, deaths, recovered;
  static int todayCases, todayDeaths;
  static String lastUpdate;

  static Future<bool> initialPref()async{
    await getUserLocation();
    await fetchCase();
    country = await getCountry();
    country_code = await getCountryCode();
    current_location = LatLng(await getLocationLatitude(), await getLocationLongitude());
    cases = await getCases();
    deaths = await getDeaths();
    recovered = await getRecovered();
    todayCases = await getTodayCases();
    todayDeaths = await getTodayDeaths();
    lastUpdate = await getLastUpdate();
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

  static Future<void> fetchCase() async {
    final response = await http.get('${Links.CORONA_CASES}${PrefManager.country}');
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      await setCases(body['cases']);
      await setDeaths(body['deaths']);
      await setRecovered(body['recovered']);
      await setTodayCases(body['todayCases']);
      await setTodayDeaths(body['todayDeaths']);
      await setLastUpdate(DateFormat.yMMMd().format(DateTime.now()) + ' ' + DateFormat.Hm().format(DateTime.now()));
    }
    else{print('ERROR!!');}
  }

  static Future<void> setCases(int val) async {
    if(val == null){
      await PrefUtils.setInt(PrefKeys.CASES, 0);
    }else{
      await PrefUtils.setInt(PrefKeys.CASES, val);
    }
  }
  static Future<int> getCases() async {
    return await PrefUtils.getInt(PrefKeys.CASES);
  }

  static Future<void> setDeaths(int val) async {
    if(val == null){
      await PrefUtils.setInt(PrefKeys.DEATHS, 0);
    }else{
      await PrefUtils.setInt(PrefKeys.DEATHS, val);
    }
  }
  static Future<int> getDeaths() async {
    return await PrefUtils.getInt(PrefKeys.DEATHS);
  }

  static Future<void> setRecovered(int val) async {
    if(val == null){
      await PrefUtils.setInt(PrefKeys.RECOVERED, 0);
    }else{
      await PrefUtils.setInt(PrefKeys.RECOVERED, val);
    }
  }
  static Future<int> getRecovered() async {
    return await PrefUtils.getInt(PrefKeys.RECOVERED);
  }

  static Future<void> setTodayCases(int val) async {
    if(val == null){
      await PrefUtils.setInt(PrefKeys.TODAY_CASES, 0);
    }else if(val > 0){
      await PrefUtils.setInt(PrefKeys.TODAY_CASES, val);
    }
  }
  static Future<int> getTodayCases() async {
    return await PrefUtils.getInt(PrefKeys.TODAY_CASES);
  }

  static Future<void> setTodayDeaths(int val) async {
    if(val == null){
      await PrefUtils.setInt(PrefKeys.TODAY_DEATHS, 0);
    }else if(val > 0){
      await PrefUtils.setInt(PrefKeys.TODAY_DEATHS, val);
    }
  }
  static Future<int> getTodayDeaths() async {
    return await PrefUtils.getInt(PrefKeys.TODAY_DEATHS);
  }

  static Future<void> setLastUpdate(String val) async {
    if(val == null){
      await PrefUtils.setString(PrefKeys.LAST_UPDATE, "unknown");
    }else{
      await PrefUtils.setString(PrefKeys.LAST_UPDATE, val);
    }
  }
  static Future<String> getLastUpdate() async {
    return await PrefUtils.getString(PrefKeys.LAST_UPDATE)??"unknown";
  }
}
