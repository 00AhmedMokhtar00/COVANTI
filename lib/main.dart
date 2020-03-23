import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';

import 'screens/home_page.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
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
            headline1: TextStyle(color: Colors.black,fontSize: 28, fontWeight: FontWeight.bold),
            bodyText2: TextStyle(fontSize: 16, color: Colors.black), // Default
            bodyText1: TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.75),fontWeight: FontWeight.bold), // bottomNavigationBar

        ),
        primarySwatch: Colors.blue
      ),
      home: FutureBuilder(
        future: getAllData(context),
        builder: (context, snapshot) {
          if(snapshot.hasData || snapshot.hasError) {
            return HomePage(snapshot.data[0], snapshot.data[1]);
          }
          return Container(color: Colors.white,width: double.infinity,height: MediaQuery.of(context).size.height,child: Center(child: CircularProgressIndicator()),);
        }
      )
    );
  }

  getAllData(BuildContext context)async{
    final response = await http.get('https://coronavirus-tracker-api.herokuapp.com/v2/locations');
    var body = json.decode(response.body);
    int idx;
    var country = await FlutterSimCountryCode.simCountryCode;
    for(int i = 0; i < 486 ; i++){
      print('Search');
      if(body['locations'][i]['country_code'] == country){
        print('Reached');
        idx = i;
        return [body['locations'][idx]['country'],body['locations'][idx]['country_code'].toString().toLowerCase()];
      }
    }
    return [body['locations'][idx]['country'].toString(),body['locations'][idx]['country_code'].toString().toLowerCase()];
  }
}
