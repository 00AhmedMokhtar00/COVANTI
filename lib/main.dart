import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:solution_challenge/prefs/pref_manager.dart';
import 'package:solution_challenge/res/asset_paths.dart';

import 'screens/home_page.dart';




void main()async{

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Permission.microphone.request().isGranted;
  await Permission.location.request().isGranted;
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'COVANTI',
        theme: ThemeData(
            fontFamily: 'SFUIText',
            textTheme: TextTheme(
              headline: TextStyle(color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
              display2: TextStyle(color: Colors.red,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
              display1: TextStyle(color: Colors.green,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
              body2: TextStyle(fontSize: 16, color: Colors.black),
              // Default
              body1: TextStyle(fontSize: 18,
                  color: Colors.black.withOpacity(0.75),
                  fontWeight: FontWeight.bold), // bottomNavigationBar

            ),
            primaryColor: Color(0xff153E87),
            accentColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
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
  bool isLoading = false;
  void getData()async{
    setState(() {isLoading = true;});
    await PrefManager.initialPref();
    setState(() {isLoading = false;});
  }
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final MQH = MediaQuery.of(context).size.height;
    final MQW = MediaQuery.of(context).size.width;
    return !isLoading?SafeArea(child: HomePage())
          :
            SafeArea(
            child: Container(
              color: Colors.white,
              width: MQW,
              height: MQH,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset(AssetPath.SPLASH_IMAGE, fit: BoxFit.cover, width: MQW * 0.8,),
                  CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor)
                ],
              ),
            ),
          );
  }
}

