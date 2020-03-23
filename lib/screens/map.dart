import 'package:flutter/material.dart';

import '../widgets/cases.dart';
import '../widgets/country.dart';
import '../widgets/global_cases.dart';
import '../widgets/home_map.dart';
import '../widgets/title.dart';


class CMap extends StatelessWidget{

  String country;
  CMap(this.country);

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CTitle('Map'),
            HomeMap(),
            Country('Globally'),
            GlobalCases(),
            Country('In $country'),
            Cases(country),
          ],
        );
  }
}


