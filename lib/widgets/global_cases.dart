import 'package:flutter/material.dart';

import '../prefs/pref_manager.dart';
import 'cases_builder.dart';

class GlobalCases extends StatelessWidget {
  GlobalCases({this.ctx});
  final BuildContext ctx;
  @override
  Widget build(BuildContext context) {
    return PrefManager.globalCases != 0?CasesBuilder(
      PrefManager.globalCases,
      PrefManager.globalDeaths,
      PrefManager.globalRecovered,
      PrefManager.todayGlobalCases,
      PrefManager.todayGlobalDeaths,
      PrefManager.lastUpdate,
      ctx: ctx,
    ):Center(child: Text('Please enable internet connection to get the statistics',textAlign: TextAlign.center,style: TextStyle(color: Colors.red),));
  }
}