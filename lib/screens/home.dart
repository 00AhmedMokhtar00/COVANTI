import 'package:flutter/material.dart';
import 'package:solution_challenge/localization/language.dart';

import '../main.dart';
import '../prefs/pref_manager.dart';
import '../res/assets.dart';
import '../widgets/widgets.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CTitle('Home'),
                  MaterialButton(
                    onPressed: () => Links.launchURL(Links.CORONA_TEST),
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    elevation: 5.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.verified_user, color: Colors.white,),
                        Text(' corona test', textAlign: TextAlign.end, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                      ],
                    ),
                  )
                ],
              ),
              HomeMap(),
              Country('In ${PrefManager.country}'),
              Cases(),
              COVIDInfo(),
              const ProtectYourselfButton(),
              COVANTI(),
              SizedBox(height: 120,),
            ],
          ),
    );
  }
}


