import 'package:flutter/material.dart';

import '../localization/keys.dart';
import '../prefs/pref_keys.dart';
import '../prefs/pref_manager.dart';

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
              GlobalCases(ctx: context),
              Country('${PrefManager.tr(context, LocKeys.IN_COUNTRY)}${PrefManager.current_locale.languageCode == PrefKeys.ENGLISH?PrefManager.country:PrefManager.country_ar}'),
              Cases(ctx: context),
              SizedBox(height: 120,)
            ],
          ),
    );
  }
}


