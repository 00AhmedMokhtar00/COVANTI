import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solution_challenge/prefs/pref_manager.dart';
import 'package:url_launcher/url_launcher.dart';

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
                    onPressed: _test,
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


  Future<void> _test() async {
    const url = 'https://covapp.charite.de/questionnaire';
    if (await canLaunch(url)) {
    await launch(url);
    } else {
    throw 'Could not launch $url';
    }
  }
}


