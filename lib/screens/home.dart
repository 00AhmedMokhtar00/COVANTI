import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/cases.dart';
import '../widgets/country.dart';
import '../widgets/covant.dart';
import '../widgets/covid_info.dart';
import '../widgets/home_map.dart';
import '../widgets/protect_yourself.dart';
import '../widgets/title.dart';


class Home extends StatelessWidget {

  Home(this.country, this.cur_location);

  final String country;
  final LatLng cur_location;

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
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(Icons.verified_user),
                    mini: true,
                  )
                ],
              ),
              HomeMap(cur_location),
              Country('In $country'),
              Cases(country),
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


