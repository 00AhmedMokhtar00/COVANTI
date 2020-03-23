import 'package:flutter/material.dart';

import '../widgets/global_map.dart';
import '../widgets/cases.dart';
import '../widgets/country.dart';
import '../widgets/global_cases.dart';
import '../widgets/title.dart';


class CMap extends StatelessWidget{

  final String country;
  CMap(this.country);

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CTitle('Map'),
            GlobalMap(),
            Country('Globally'),
            GlobalCases(),
            Country('In $country'),
            Cases(country),
          ],
        );
  }
}


