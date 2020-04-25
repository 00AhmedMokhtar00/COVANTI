import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


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
              Text('+' + NumberFormat.decimalPattern().format(todayCases) + ' today', style: TextStyle(fontSize: 10),),
            ],
          ),
          const SizedBox(height: 5,),
          const Text('Confirmed cases'),
          const SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(children: <Widget>[
                Column(
                  children: <Widget>[
                    Text( NumberFormat.decimalPattern().format(deathCases) ,style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 30),),
                    Text('+' + NumberFormat.decimalPattern().format(todayDeaths) + ' today', style: TextStyle(color: Colors.red, fontSize: 10),),
                  ],
                ),
                const Text('Deaths')
              ],),
              Column(children: <Widget>[
                Text(NumberFormat.decimalPattern().format(recoverCases),style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 30),),
                const Text('Cured')
              ],),
            ],
          ),
          Text('last update: $covLastUpdate',style: TextStyle(color: Colors.grey,fontSize: 8),),
          const SizedBox(height: 5,),
        ]
    );
  }
}
