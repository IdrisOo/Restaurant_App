import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoLocalizations {
  final Locale locale;
  DemoLocalizations(this.locale);

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  Map<String, String> _localizedValues;

  Future load() async {
    String jsonStringValues = await rootBundle
        .loadString('assets/Languages/${locale.languageCode}.json');

    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);

    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String getTranslatedValue(String key) {
    return _localizedValues[key];
  }

  static const LocalizationsDelegate<DemoLocalizations> delegate = DemoLocalizationsDelegate();
  
}

class DemoLocalizationsDelegate extends LocalizationsDelegate<DemoLocalizations>{
  const DemoLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en','ar'].contains(locale.languageCode);
    }
  
    @override
    Future<DemoLocalizations> load(Locale locale) async{
      DemoLocalizations localization = new DemoLocalizations(locale);
      await localization.load();
      return localization;
    }
  
    @override
   bool shouldReload(DemoLocalizationsDelegate old) => false;
  

}
