import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solution_challenge/prefs/pref_keys.dart';

class CovantiLocalization{
  final Locale locale;
  CovantiLocalization(this.locale);

  static CovantiLocalization of(BuildContext context){
    return Localizations.of<CovantiLocalization>(context, CovantiLocalization);
  }

  Map<String, String> _localizedValues;

  Future load()async{
    final String jsonFile = await rootBundle.loadString("lang/${locale.languageCode}.json");

    Map<String, dynamic> mappedJson = json.decode(jsonFile);

    _localizedValues = mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String translate(String key){
    return _localizedValues[key];
  }

  static const LocalizationsDelegate<CovantiLocalization> delegate
      = _CovantiLocalizationDelegate();
}

class _CovantiLocalizationDelegate extends LocalizationsDelegate<CovantiLocalization>{

  const _CovantiLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return [PrefKeys.ENGLISH, PrefKeys.ARABIC].contains(locale.languageCode);
  }

  @override
  Future<CovantiLocalization> load(Locale locale) async{
    CovantiLocalization localization = CovantiLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_CovantiLocalizationDelegate old)
        => false;

}