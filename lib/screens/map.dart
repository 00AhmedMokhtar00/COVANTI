import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../widgets/global_map.dart';
import '../widgets/cases.dart';
import '../widgets/country.dart';
import '../widgets/global_cases.dart';
import '../widgets/title.dart';


class CMap extends StatelessWidget{

  final String country;
  final LatLng cur_location;
  CMap(this.country, this.cur_location);

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CTitle('Map'),
            GlobalMap(cur_location),
            Country('Globally'),
            GlobalCases(),
            Country('In $country'),
            Cases(country),
          ],
        );
  }
}


