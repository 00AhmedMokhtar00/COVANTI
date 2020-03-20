import 'package:flutter/material.dart';

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CTitle('Home'),
        HomeMap(),
        Country('In Egypt'),
        Cases(),
        COVIDInfo(),
        const ProtectYourselfButton(),
        COVANTI(),
      ],
    );
  }
}


