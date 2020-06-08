import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solution_challenge/localization/keys.dart';
import 'package:solution_challenge/prefs/pref_manager.dart';

import '../widgets/global_map.dart';
import '../widgets/cases.dart';
import '../widgets/country.dart';
import '../widgets/global_cases.dart';
import '../widgets/title.dart';


class CMap extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CTitle(PrefManager.tr(context, LocKeys.MAP_TITLE)),
              GlobalMap(),
              Country(PrefManager.tr(context, LocKeys.MAP_GLOBALLY_TXT)),
              GlobalCases(),
              Country('${PrefManager.tr(context, LocKeys.IN_COUNTRY)}${PrefManager.country}'),
              Cases(),
              SizedBox(height: 120,)
            ],
          ),
    );
  }
}


