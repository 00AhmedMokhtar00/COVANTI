import 'package:flutter/material.dart';
import '../localization/language.dart';
import '../prefs/pref_manager.dart';

import '../main.dart';


class LanguageButton extends StatelessWidget {
  final BuildContext context;
  LanguageButton({this.context});
  void _changeLanguage(Language language) async {
    await PrefManager.setLocale(language.languageCode);
    MyApp.setLocale(context, PrefManager.current_locale);
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton<Language>(
        underline: SizedBox(),
        icon: Icon(
          Icons.language,
          color: Colors.white,
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
      ),
    );
  }
}
