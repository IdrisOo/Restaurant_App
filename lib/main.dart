import 'package:flutter/material.dart';

import 'Pages/LoginPage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localization/demo_localization.dart';

class Main extends StatefulWidget {
  // yesterday i was trying to set local and there's an error in the mainpage. try to solve it
  static void setLocale(BuildContext context, Locale locale) {
    _MainState state = context.findAncestorStateOfType<_MainState>();
    state.setLocale(locale);
  }

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  Locale _locale;
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        locale: _locale,
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ar', 'IQ'),
        ],
        localizationsDelegates: [
          DemoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale.languageCode &&
                locale.countryCode == deviceLocale.countryCode) {
              return deviceLocale;
            }
          }
          return supportedLocales.first;
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Varela'),
        home: Page());
  }
}

class Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}

void main() => runApp(Main());
