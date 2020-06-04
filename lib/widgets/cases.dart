import 'package:flutter/material.dart';

import '../prefs/pref_manager.dart';
import 'cases_builder.dart';

class Cases extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return PrefManager.cases != 0?CasesBuilder(
                PrefManager.cases,
                PrefManager.deaths,
                PrefManager.recovered,
                PrefManager.todayCases,
                PrefManager.todayDeaths,
                PrefManager.lastUpdate,
            ):Center(child: Text('Please enable internet connection to get the statistics',textAlign: TextAlign.center,style: TextStyle(color: Colors.red),));
        }

}
