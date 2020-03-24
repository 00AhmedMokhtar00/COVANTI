import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';

import 'screens/home_page.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}


class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future locationData;

  @override
  void initState() {
    locationData = getAllData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COVANTI',
      theme: ThemeData(
        fontFamily: 'SFUIText',
        textTheme: TextTheme(
            headline1: TextStyle(color: Colors.black,fontSize: 28, fontWeight: FontWeight.bold),
            bodyText2: TextStyle(fontSize: 16, color: Colors.black), // Default
            bodyText1: TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.75),fontWeight: FontWeight.bold), // bottomNavigationBar

        ),
        primarySwatch: Colors.blue
      ),
      home: FutureBuilder(
        future: locationData,
        builder: (context, snapshot) {
          if(snapshot.hasData || snapshot.hasError) {
            return HomePage(snapshot.data[0], snapshot.data[1]);
          }
          return Container(color: Colors.white,width: double.infinity,height: MediaQuery.of(context).size.height,child: Center(child: CircularProgressIndicator()),);
        }
      )
    );
  }

  getAllData()async{
    final String country = await FlutterSimCountryCode.simCountryCode;
    final String jsonString = await _loadAsset();
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
}
