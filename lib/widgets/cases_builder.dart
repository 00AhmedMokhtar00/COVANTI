import 'package:flutter/material.dart';


class CasesBuilder extends StatelessWidget {
  final int totalCases, deathCases, recoverCases;
  final String covLastUpdate;

  CasesBuilder(this.totalCases, this.deathCases, this.recoverCases, this.covLastUpdate);
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(totalCases.toString(),style: Theme.of(context).textTheme.headline1,),
          const SizedBox(height: 5,),
          const Text('Confirmed cases'),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(children: <Widget>[
                Text(deathCases.toString(),style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 30),),
                const Text('Deaths')
              ],),
              Column(children: <Widget>[
                Text(recoverCases.toString(),style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 30),),
                const Text('Cured')
              ],),
            ],
          ),
          Text('last update: $covLastUpdate',style: TextStyle(color: Colors.grey,fontSize: 8),),
          const SizedBox(height: 10,),
        ]
    );
  }
}
