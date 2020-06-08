import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../localization/keys.dart';
import '../prefs/pref_manager.dart';


class CasesBuilder extends StatelessWidget {
  final int totalCases, deathCases, recoverCases, todayCases, todayDeaths;
  final String covLastUpdate;

  CasesBuilder(this.totalCases, this.deathCases, this.recoverCases, this.todayCases, this.todayDeaths, this.covLastUpdate,);
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(NumberFormat.decimalPattern().format(totalCases),style: Theme.of(context).textTheme.headline,),
            ],
          ),
          const SizedBox(height: 5,),
          Text(PrefManager.tr(context, LocKeys.CONFIRMED_CASES_TXT)),
          Text('+' + NumberFormat.decimalPattern().format(todayCases) + PrefManager.tr(context, LocKeys.TODAY), style: TextStyle(fontSize: 10),),
          const SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(children: <Widget>[
                Column(
                  children: <Widget>[
                    Text( NumberFormat.decimalPattern().format(deathCases) ,style: Theme.of(context).textTheme.display2),
                  ],
                ),
                Text(PrefManager.tr(context, LocKeys.DEATH_CASES_TXT)),
                Text('+' + NumberFormat.decimalPattern().format(todayDeaths) + PrefManager.tr(context, LocKeys.TODAY), style: TextStyle(color: Colors.red, fontSize: 10),),
              ],),
              Column(children: <Widget>[
                Text(NumberFormat.decimalPattern().format(recoverCases),style: Theme.of(context).textTheme.display1),
                Text(PrefManager.tr(context, LocKeys.RECOVERED_CASES_TXT)),
                Text(' ', style: TextStyle(fontSize: 10),),
              ],),
            ],
          ),

          Text('${PrefManager.tr(context, LocKeys.LAST_UPDATE)}: $covLastUpdate',style: TextStyle(color: Colors.grey,fontSize: 8),),
          const SizedBox(height: 5,),
        ]
    );
  }
}
