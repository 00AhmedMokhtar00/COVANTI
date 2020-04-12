import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

import 'screens/home_page.dart';

Future<void>fetchCurrentLocation() async {
  var location = Location();
  location.changeSettings(accuracy: LocationAccuracy.high);
  if (await location.hasPermission() != true) {
    await location.requestPermission();
  }
  try {
    await location.onLocationChanged.listen((LocationData currentLocation) {
    });
  } on PlatformException {
    location = null;
  }
}



main()async{

  WidgetsFlutterBinding.ensureInitialized();
  await Permission.microphone.request().isGranted;
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'COVANTI',
        theme: ThemeData(
            fontFamily: 'SFUIText',
            textTheme: TextTheme(
              headline: TextStyle(color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
              body2: TextStyle(fontSize: 16, color: Colors.black),
              // Default
              body1: TextStyle(fontSize: 18,
                  color: Colors.black.withOpacity(0.75),
                  fontWeight: FontWeight.bold), // bottomNavigationBar

            ),
            primaryColor: Color(0xff1c55d1)
        ),
        home: Splash()
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future locationData;
  LatLng cur;

  @override
  void initState() {
    locationData = getAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MQH = MediaQuery.of(context).size.height;
    final MQW = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: locationData,
        builder: (context, snapshot) {
          if(snapshot.hasData || snapshot.hasError) {
            return SafeArea(child: HomePage(snapshot.data[0], snapshot.data[1], cur));
          }
          return SafeArea(
            child: Container(
              color: Colors.white,
              width: MQW,
              height: MQH,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset('assets/images/splash.jpg', fit: BoxFit.fill,height: 200, width: MQW,),
                  CircularProgressIndicator()
                ],
              ),
            ),
          );
        }
    );
  }

  getAllData()async{
    final String country = await FlutterSimCountryCode.simCountryCode;
    final String jsonString = await _loadAsset();
    cur = await getCurrentLocation();
    final body = json.decode(jsonString);
    int idx;

    for(int i = 0; i < body.length; i++){

      if(body[i]['code'] == country){
        idx = i;
        return [body[idx]['name'],body[idx]['code'].toString().toLowerCase()];
      }
    }
    return [body[idx]['name'].toString(),body[idx]['code'].toString().toLowerCase()];
  }
  Future<String> _loadAsset() async {
    return await rootBundle.loadString('assets/countries.json');
  }
  Future<LatLng> getCurrentLocation()async{
    var location = Location();
    LocationData position = await location.getLocation();
    final cur = LatLng(position.latitude, position.longitude);
    return cur;
  }
}

