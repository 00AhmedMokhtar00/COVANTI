import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

import 'prefs/pref_manager.dart';
import 'res/asset_paths.dart';
import 'screens/advice_details.dart';
import 'screens/chatbot.dart';
import 'screens/global_active_map.dart';
import 'screens/protect_yourself.dart';
import 'screens/home_page.dart';


void main()async{

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Permission.microphone.request().isGranted;
  //await Permission.location.request().isGranted;
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
        home: Splash(),
      routes: {
          Chatbot.routeName : (BuildContext _) => Chatbot(),
          GlobalActiveMap.routeName : (BuildContext _) => GlobalActiveMap(),
          ProtectYourself.routeName: (BuildContext _) => ProtectYourself(),
          AdviceDetails.routeName: (BuildContext _) => AdviceDetails(),

      },
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
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){
        getData();
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final MQH = MediaQuery.of(context).size.height;
    final MQW = MediaQuery.of(context).size.width;
    return !isLoading?SafeArea(child: HomePage())
          : SafeArea(
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

