import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'cases_builder.dart';

class GlobalCases extends StatelessWidget {
  String covLastUpdate;
  bool connectionAvailable = true;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, int>>(
      future: getData(),
      builder: (context, snapshot) {
        if(connectionAvailable || snapshot.data['cases'] != 0) {
          if (snapshot.hasData || snapshot.hasError) {
            return CasesBuilder(snapshot.data['cases'], snapshot.data['deaths'],
                snapshot.data['recovered'], covLastUpdate);
          }
        }else{
          return Center(child: Text('Please enable internet connection to get the statistics',textAlign: TextAlign.center,style: TextStyle(color: Colors.red),));
        }
        // By default, show a loading spinner.
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<Map<String, int>> getData()async{
    try {
      await fetchGlobalCase();
    }
    catch (e) {connectionAvailable = false;}
    finally {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      covLastUpdate = prefs.getString('covidlastupdate');
      return {
        'cases': prefs.getInt('globalcases') ?? 0,
        'deaths': prefs.getInt('globaldeaths') ?? 0,
        'recovered': prefs.getInt('globalrecovered') ?? 0,
      };
    }
  }

  Future<void> fetchGlobalCase() async {
    final response = await http.get('https://coronavirus-19-api.herokuapp.com/all');
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('globalcases', body['cases']??0);
      prefs.setInt('globaldeaths', body['deaths']??0);
      prefs.setInt('globalrecovered', body['recovered']??0);
      prefs.setString('covidlastupdate', DateFormat.yMMMd().format(DateTime.now())+ ' '+DateFormat.Hm().format(DateTime.now()));
    } else {
      print('exception');
      throw Exception('Failed to load cases');
    }
  }

}