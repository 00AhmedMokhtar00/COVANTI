import 'package:flutter/material.dart';

import '../prefs/pref_manager.dart';
import '../res/assets.dart';
import '../widgets/cases.dart';
import '../widgets/country.dart';
import '../widgets/covant.dart';
import '../widgets/covid_info.dart';
import '../widgets/home_map.dart';
import '../widgets/protect_yourself.dart';
import '../widgets/title.dart';


class Home extends StatelessWidget {

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
                  FloatingActionButton(
                    onPressed: () => Links.launchURL(Links.CORONA_TEST),
                    tooltip: 'coronavirus test',
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(Icons.verified_user, color: Colors.white,),
                    mini: true,
                  )
                ],
              ),
              HomeMap(),
              Country('In ${PrefManager.country}'),
              Cases(),
              COVIDInfo(),
              const ProtectYourselfButton(),
              COVANTI(),
              SizedBox(height: 120,)
            ],
          ),
    );
  }
}


