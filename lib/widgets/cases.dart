import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:solution_challenge/prefs/pref_manager.dart';
import 'cases_builder.dart';

class Cases extends StatelessWidget {
  String covLastUpdate;
  bool connectionAvailable = true;
  Future offlineData;

  Cases(){offlineData = getData();}

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<Map<String, int>>(
      future: offlineData,
      builder: (context, snapshot) {
        if(connectionAvailable || snapshot.data['cases'] != 0) {
          if (snapshot.hasData || snapshot.hasError) {
            return CasesBuilder(
                snapshot.data['cases'] ?? 0,
                snapshot.data['deaths'] ?? 0,
                snapshot.data['recovered'] ?? 0,
                snapshot.data['todayCases'] ?? 0,
                snapshot.data['todayDeaths'] ?? 0,
              covLastUpdate,
            );
          }
        }else{
          return Center(child: Text('Please enable internet connection to get the statistics',textAlign: TextAlign.center,style: TextStyle(color: Colors.red),));
        }
        // By default, show a loading spinner.
        return Center(child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor));
      },
    );
  }

  Future<Map<String, int>> getData()async {
    try {
      await fetchCase();
    }
    catch (e) {connectionAvailable = false;}
    finally {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      covLastUpdate = prefs.getString('covidlastupdate') ?? ' ';
      return {
        'cases': prefs.getInt('cases') ?? 0,
        'deaths': prefs.getInt('deaths') ?? 0,
        'recovered': prefs.getInt('recovered') ?? 0,
        'todayCases': prefs.getInt('todayCases') ?? 0,
        'todayDeaths': prefs.getInt('todayDeaths') ?? 0,
      };
    }
  }

  Future<void> fetchCase() async {
    final response = await http.get('https://corona.lmao.ninja/v2/countries/${PrefManager.country}');
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('cases', body['cases'] ?? 0);
      await prefs.setInt('deaths', body['deaths'] ?? 0);
      await prefs.setInt('recovered', body['recovered'] ?? 0);
      await prefs.setInt('todayCases', body['todayCases'] ?? 0);
      await prefs.setInt('todayDeaths', body['todayDeaths'] ?? 0);
      await prefs.setString('covidlastupdate', DateFormat.yMMMd().format(DateTime.now()) + ' ' + DateFormat.Hm().format(DateTime.now()));
    }
    else{print('ERROR!!');}
  }
}
