import 'package:flutter/material.dart';
import 'package:solution_challenge/widgets/cases.dart';
import 'package:solution_challenge/widgets/country.dart';
import 'package:solution_challenge/widgets/global_cases.dart';
import 'package:solution_challenge/widgets/home_map.dart';
import 'package:solution_challenge/widgets/title.dart';


class CMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MQ = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CTitle('Map'),
        HomeMap(),
        Country('Globally'),
        GlobalCases(),
        Country('In Egypt'),
        Cases(),
      ],
    );
  }






  CasesG(ctx){
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('0000000',style: Theme.of(ctx).textTheme.headline1,),
          const SizedBox(height: 5,),
          Text('Confirmed cases'),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(children: <Widget>[
                Text('0000',style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 30),),
                Text('Deaths')
              ],),
              Column(children: <Widget>[
                Text('0000',style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 30),),
                Text('Cured')
              ],),
            ],
          ),
          const SizedBox(height: 10,),
        ]
    );
  }

  CasesE(ctx){
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('0000000',style: Theme.of(ctx).textTheme.headline1,),
          const SizedBox(height: 5,),
          Text('Confirmed cases'),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(children: <Widget>[
                Text('0000',style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 30),),
                Text('Deaths')
              ],),
              Column(children: <Widget>[
                Text('0000',style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 30),),
                Text('Cured')
              ],),
            ],
          ),
          const SizedBox(height: 10,),
        ]
    );
  }

}


