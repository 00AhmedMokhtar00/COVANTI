import 'package:flutter/material.dart';
import '../localization/language.dart';
import '../prefs/pref_manager.dart';

import '../main.dart';


class LanguageButton extends StatelessWidget {
  final BuildContext context;
  LanguageButton({this.context});
  void _changeLanguage(Language language) async {
    await PrefManager.setLocale(language.languageCode);
    Locale cur = PrefManager.locale(language.languageCode);
    MyApp.setLocale(context, cur);
  }
  @override
  Widget build(BuildContext context) {
    return DropdownButton<Language>(
      underline: SizedBox(),
      icon: Icon(
        Icons.language,
        color: Color(0xff153E87),
      ),
      onChanged: (Language language) {
        _changeLanguage(language);
      },
      items: Language.languageList()
          .map<DropdownMenuItem<Language>>(
            (e) => DropdownMenuItem<Language>(
          value: e,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                e.flag,
                style: TextStyle(fontSize: 30),
              ),
              Text(e.name)
            ],
          ),
        ),
      )
          .toList(),
    );
  }
}
