import 'package:flutter/material.dart';
import 'package:solution_challenge/localization/keys.dart';

import '../prefs/pref_manager.dart';
import 'cases_builder.dart';

class Cases extends StatelessWidget {
  final BuildContext ctx;
  Cases({this.ctx});

  @override
  Widget build(BuildContext context) {
    return PrefManager.cases != 0?CasesBuilder(
                PrefManager.cases,
                PrefManager.deaths,
                PrefManager.recovered,
                PrefManager.todayCases,
                PrefManager.todayDeaths,
                PrefManager.lastUpdate,
                ctx: ctx,
            ):Center(child: Text(PrefManager.tr(context, LocKeys.ACTIVATE_INTERNET_MSG),textAlign: TextAlign.center,style: TextStyle(color: Colors.red),));
        }

}
