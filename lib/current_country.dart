import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CurrentCountry extends StatefulWidget {
  static String CountryName;
  @override
  _CurrentCountryState createState() => _CurrentCountryState();
}

class _CurrentCountryState extends State<CurrentCountry> {
  var country;

  List<dynamic> data = [];

  @override
  Widget build(BuildContext context) {
    //getCountry();
    return FutureBuilder(
      future: getData(context),
      builder: (_, snap){
        if(snap.hasData){
          return Container(child: Text(CurrentCountry.CountryName,textDirection: TextDirection.rtl,),);
        }
        return CircularProgressIndicator();
      },
    );
  }

   getData(BuildContext context)async{
    data = json.decode(await DefaultAssetBundle.of(context).loadString('assets/countries.json'));
    country = await FlutterSimCountryCode.simCountryCode;
    for(int i = 0 ; i < data.length ; i++){
      if(data[i]['code'] == country){
        CurrentCountry.CountryName = data[i]['name'];
        break;
      }
    }
    return CurrentCountry.CountryName;
  }

  SaveData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('country', CurrentCountry.CountryName);
  }
}

