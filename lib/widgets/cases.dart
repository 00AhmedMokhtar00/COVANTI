import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'cases_builder.dart';

class Cases extends StatelessWidget {
  final String country;
  String covLastUpdate;
  bool connectionAvailable = true;
  Future offlineData;

  Cases(this.country){offlineData = getData();}

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<Map<String, int>>(
      future: offlineData,
      builder: (context, snapshot) {
        if(connectionAvailable || snapshot.data['cases'] != 0) {
          if (snapshot.hasData || snapshot.hasError) {
            return CasesBuilder(
                snapshot.data['cases'] ?? 0, snapshot.data['deaths'] ?? 0,
                snapshot.data['recovered'] ?? 0, covLastUpdate);
          }
        }else{
          return Center(child: Text('Please enable internet connection to get the statistics',textAlign: TextAlign.center,style: TextStyle(color: Colors.red),));
        }
        // By default, show a loading spinner.
        return const Center(child: CircularProgressIndicator());
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
      };
    }
  }

  Future<void> fetchCase() async {
    final response = await http.get('https://coronavirus-19-api.herokuapp.com/countries/${country}');
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('cases', body['cases'] ?? 0);
      prefs.setInt('deaths', body['deaths'] ?? 0);
      prefs.setInt('recovered', body['recovered'] ?? 0);
      prefs.setString('covidlastupdate', DateFormat.yMMMd().format(DateTime.now()) + ' ' + DateFormat.Hm().format(DateTime.now()));
    }
    else{print('ERROR!!');}
  }
}
