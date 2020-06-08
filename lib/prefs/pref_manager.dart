import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import '../localization/covanti_localization.dart';
import '../res/assets.dart';

import '../prefs/pref_keys.dart';
import '../prefs/pref_utils.dart';

class PrefManager {
  static String country;
  static String country_code;
  static LatLng current_location;
  static int cases, deaths, recovered;
  static int todayCases, todayDeaths;
  static int globalCases, globalDeaths, globalRecovered;
  static int todayGlobalCases, todayGlobalDeaths;
  static String lastUpdate;
  static Locale current_locale;

  static Future<bool> initialPref()async{

    if(!await getUserLocation()){
      print('1');
      country            = await getCountry();
      country_code       = await getCountryCode();
      current_location   = LatLng(await getLocationLatitude(), await getLocationLongitude());
    }
    print('2');
    await fetchCase();
    print('3');
    await fetchGlobalCase();
    print('4');
    cases              = await getCases();
    deaths             = await getDeaths();
    recovered          = await getRecovered();
    todayCases         = await getTodayCases();
    todayDeaths        = await getTodayDeaths();
    lastUpdate         = await getLastUpdate();
    globalCases        = await getGlobalCases();
    globalDeaths       = await getGlobalDeaths();
    globalRecovered    = await getGlobalRecovered();
    todayGlobalCases   = await getTodayGlobalCases();
    todayGlobalDeaths  = await getTodayGlobalDeaths();
    print('5');
    await fetchNews();
    print('6');
  }

  static Future<void> setCountry(String val) async {
    if(val == null){
      await PrefUtils.setString(PrefKeys.COUNTRY, PrefDefaultValues.NO_COUNTRY);
    }else{
      await PrefUtils.setString(PrefKeys.COUNTRY, val);
    }
  }

  static Future<void> setCountryCode(String val) async {
    if(val == null){
      await PrefUtils.setString(PrefKeys.COUNTRY_CODE, PrefDefaultValues.NO_COUNTRY_CODE);
    }else{
      await PrefUtils.setString(PrefKeys.COUNTRY_CODE, val);
    }
  }

  static Future<void> setLocationLatitude(double val) async {
    if(val == null){
      await PrefUtils.setDouble(PrefKeys.LOCATION_LATITUDE, PrefDefaultValues.NO_LOCATION_LATITUDE);
    }else{
      await PrefUtils.setDouble(PrefKeys.LOCATION_LATITUDE, val);
    }
  }

  static Future<void> setLocationLongitude(double val) async {
    if(val == null){
      await PrefUtils.setDouble(PrefKeys.LOCATION_LONGITUDE, PrefDefaultValues.NO_LOCATION_LONGITUDE);
    }else{
      await PrefUtils.setDouble(PrefKeys.LOCATION_LONGITUDE, val);
    }
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
        setLocationLatitude(myLocation.latitude);
        setLocationLongitude(myLocation.longitude);
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
    setCountry(first.countryName);
    setCountryCode(first.countryCode);
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

  static Future<bool> fetchCase() async {
    var response;
    try {
      response = await http.get(
          '${Links.CORONA_CASES}/${PrefManager.country}');
    }catch(e){
      print("MOKHOTAAAR" + e.toString());
      return false;
    }
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      await setCases(body['cases']);
      await setDeaths(body['deaths']);
      await setRecovered(body['recovered']);
      await setTodayCases(body['todayCases']);
      await setTodayDeaths(body['todayDeaths']);
      await setLastUpdate(DateFormat.yMMMd().format(DateTime.now()) + ' ' + DateFormat.Hm().format(DateTime.now()));
      return true;
    }
    else{
      print('ERROR!!');
      return false;
    }
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

  static Future<bool> fetchGlobalCase() async {
    var response;
    try {
      response = await http.get(Links.CORONA_GLOBAL_CASES);
    }catch(e){
      print("MOKHOOOO" + e.toString());
      return false;
    }
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      await setGlobalCases(body['cases']);
      await setGlobalDeaths(body['deaths']);
      await setGlobalRecovered(body['recovered']);
      await setTodayGlobalCases(body['todayCases']);
      await setTodayGlobalDeaths(body['todayDeaths']);
      await setLastUpdate(DateFormat.yMMMd().format(DateTime.now())+ ' '+DateFormat.Hm().format(DateTime.now()));
      return true;
    } else {
      print('exception');
      return false;
    }
  }


  static Future<void> setGlobalCases(int val) async {
    if(val == null){
      await PrefUtils.setInt(PrefKeys.GLOBAL_CASES, 0);
    }else{
      await PrefUtils.setInt(PrefKeys.GLOBAL_CASES, val);
    }
  }
  static Future<int> getGlobalCases() async {
    return await PrefUtils.getInt(PrefKeys.GLOBAL_CASES);
  }

  static Future<void> setGlobalDeaths(int val) async {
    if(val == null){
      await PrefUtils.setInt(PrefKeys.GLOBAL_DEATHS, 0);
    }else{
      await PrefUtils.setInt(PrefKeys.GLOBAL_DEATHS, val);
    }
  }
  static Future<int> getGlobalDeaths() async {
    return await PrefUtils.getInt(PrefKeys.GLOBAL_DEATHS);
  }

  static Future<void> setGlobalRecovered(int val) async {
    if(val == null){
      await PrefUtils.setInt(PrefKeys.GLOBAL_RECOVERED, 0);
    }else{
      await PrefUtils.setInt(PrefKeys.GLOBAL_RECOVERED, val);
    }
  }
  static Future<int> getGlobalRecovered() async {
    return await PrefUtils.getInt(PrefKeys.GLOBAL_RECOVERED);
  }

  static Future<void> setTodayGlobalCases(int val) async {
    if(val == null){
      await PrefUtils.setInt(PrefKeys.TODAY_GLOBAL_CASES, 0);
    }else if(val > 0){
      await PrefUtils.setInt(PrefKeys.TODAY_GLOBAL_CASES, val);
    }
  }
  static Future<int> getTodayGlobalCases() async {
    return await PrefUtils.getInt(PrefKeys.TODAY_GLOBAL_CASES);
  }

  static Future<void> setTodayGlobalDeaths(int val) async {
    if(val == null){
      await PrefUtils.setInt(PrefKeys.TODAY_GLOBAL_DEATHS, 0);
    }else if(val > 0){
      await PrefUtils.setInt(PrefKeys.TODAY_GLOBAL_DEATHS, val);
    }
  }
  static Future<int> getTodayGlobalDeaths() async {
    return await PrefUtils.getInt(PrefKeys.TODAY_GLOBAL_DEATHS);
  }

  static Future<bool> fetchNews() async {
    var response;
    try {
      response = await http.get(
          'http://newsapi.org/v2/top-headlines?country=${PrefManager
              .country_code}&category=health&apiKey=323019aaa9fd463e83cce512b425a1ab');
    }catch(e){
      print("NEWS" + e.toString());
      return false;
    }
    var body = json.decode(response.body);

    if (response.statusCode == 200){
      for (int idx = 0; idx <= 19; idx++) {
        await PrefUtils.setString('newsTitle$idx', body['articles'][idx]['title']);
        await PrefUtils.setString('newsDescription$idx', body['articles'][idx]['description']);
        await PrefUtils.setString('newsUrl$idx', body['articles'][idx]['url']);
        await PrefUtils.setString('newsImg$idx', body['articles'][idx]['urlToImage']);
      }
      return true;
    }
    return false;
  }

  static Future<Map<String, String>> getOfflineNews() async {
      int hasData = 19;
      Map<String, String> temp = {};
      String title, description, url, img;

      for (int idx = 0; idx <= 19; idx++) {
        title =       await PrefUtils.getString('newsTitle$idx') ?? ' ';
        description = await PrefUtils.getString('newsDescription$idx') ?? ' ';
        url =         await PrefUtils.getString('newsUrl$idx') ?? ' ';
        img =         await PrefUtils.getString('newsImg$idx') ?? ' ';
        if(title == ' ' && description == ' ' && url == ' ' && img == ' '){
          hasData--;
        }
        temp.addAll({
          'newsTitle$idx':       title,
          'newsDescription$idx': description,
          'newsUrl$idx':         url,
          'newsImg$idx':         img,
        });
      }
      return hasData > 10?temp:null;
  }

  static Future<void> setLocale(String languageCode) async {
    await PrefUtils.setString(PrefKeys.LANGUAGE_CODE, languageCode);
  }

  static Future<Locale> getLocale() async {
    String languageCode = await PrefUtils.getString(PrefKeys.LANGUAGE_CODE) ?? PrefKeys.ENGLISH;
    return locale(languageCode);
  }
  static Locale locale(String languageCode) {
    switch (languageCode) {
      case PrefKeys.ENGLISH:
        return Locale(PrefKeys.ENGLISH, 'US');
      case PrefKeys.ARABIC:
        return Locale(PrefKeys.ARABIC, "SA");
      default:
        return Locale(PrefKeys.ENGLISH, 'US');
    }
  }

  static String tr(BuildContext context, String key) {
    return CovantiLocalization.of(context).translate(key);
  }
}
