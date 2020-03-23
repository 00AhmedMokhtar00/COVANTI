import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/home_page.dart';

main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  MyApp(){}

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
        future: getData(context),
        builder: (context, snapshot) {
          if(snapshot.hasData)
            return HomePage(snapshot.data);
          return Container(color: Colors.white,width: double.infinity,height: MediaQuery.of(context).size.height,child: Center(child: CircularProgressIndicator()),);
        }
      )
    );
  }

  getData(BuildContext context)async{
    int idx;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> data = json.decode(await DefaultAssetBundle.of(context).loadString('assets/countries.json'));
    var country = await FlutterSimCountryCode.simCountryCode;
    for(int i = 0 ; i < data.length ; i++){
      if(data[i]['code'] == country){
        idx = i;
        prefs.setString('country', data[i]['name']);

        return data[i]['name'];
      }
    }
    return data[idx]['name'];
  }

}
