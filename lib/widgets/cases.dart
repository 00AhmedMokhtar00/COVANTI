import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/case.dart';
import 'cases_builder.dart';



class Cases extends StatefulWidget {
  @override
  _CasesState createState() => _CasesState();
}

class _CasesState extends State<Cases> {
  Future<Case> futureCase;
  var offlineData = {
    'cases':000000,
    'deaths':000000,
    'recovered':000000
  };
  String covLastUpdate;
  @override
  void initState() {
    futureCase = fetchCase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return FutureBuilder<Case>(
      future: futureCase,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CasesBuilder(snapshot.data.totalGlobalCases, snapshot.data.totalGlobalDeaths, snapshot.data.totalGlobalrecovered, covLastUpdate);
        } else if (snapshot.hasError) {

          return CasesBuilder(offlineData['cases'], offlineData['deaths'], offlineData['recovered'], covLastUpdate);
        }
        // By default, show a loading spinner.
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<Case> fetchCase() async {
    final response = await http.get('https://coronavirus-19-api.herokuapp.com/countries/Egypt');
    var body = json.decode(response.body);

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('cases', body['cases']);
      prefs.setInt('deaths', body['deaths']);
      prefs.setInt('recovered', body['recovered']);
      prefs.setString('covidlastupdate', DateFormat.yMMMd().format(DateTime.now())+ ' '+DateFormat.Hm().format(DateTime.now()));
      return Case.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load cases');
    }
  }

   getData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      offlineData = {
        'cases': prefs.getInt('cases'),
        'deaths': prefs.getInt('deaths'),
        'recovered': prefs.getInt('recovered'),
      };
      covLastUpdate = prefs.getString('covidlastupdate')??'Now';
    });

  }

}
