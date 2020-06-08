import 'package:flutter/material.dart';
import '../localization/keys.dart';
import '../prefs/pref_keys.dart';

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
              SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(child: CTitle(PrefManager.tr(context, LocKeys.HOME_TITLE))),
                  LanguageButton(context: context),
                ],
              ),
              HomeMap(),
              Country('${PrefManager.tr(context, LocKeys.IN_COUNTRY)}${PrefManager.current_locale.languageCode == PrefKeys.ENGLISH?PrefManager.country:PrefManager.country_ar}'),
              Cases(ctx: context),
              COVIDInfo(),
              const ProtectYourselfButton(),
              Center(
                child: Container(
                  width: 155.0,
                  child: MaterialButton(
                    onPressed: () => Links.launchURL(Links.CORONA_TEST),
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    elevation: 5.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.verified_user, color: Colors.white,),
                        Text(PrefManager.tr(context, LocKeys.CORONA_TEST_BUTTON), textAlign: TextAlign.end, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ),
              ),
              COVANTI(),
              SizedBox(height: 120,),
            ],
          ),
    );
  }
}


