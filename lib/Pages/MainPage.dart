import 'package:flutter/material.dart';
import 'package:restauranttest/Pages/DropdownLang.dart';
import 'BottomBar.dart';
import 'Burgers.dart';
import 'Appetizers.dart';
import 'Pizza.dart';
import 'Drinks.dart';

class MyApp extends StatefulWidget {
 
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TabController _tabController;

  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }
//language changing need help.
  void _changeLanguage(Language language) {
    Locale _temp;
    switch (language.languageCode) {
      case 'en':
        _temp = Locale(language.languageCode, 'US');
        break;
      case 'ar':
        _temp = Locale(language.languageCode, 'IQ');
        break;
      default:
        _temp = Locale(language.languageCode, 'US');
    }
   // MyApp.setLocale(context, _temp);
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: DropdownButton(
                      onChanged: (Language language) {
                        _changeLanguage(language);
                      },
                      icon: Icon(
                        Icons.language,
                        color: Color(0xFFC88067),
                        size: 50,
                      ),
                      underline: SizedBox(),
                      items: Language.languageList()
                          .map<DropdownMenuItem<Language>>(
                              (lang) => DropdownMenuItem(
                                    value: lang,
                                    child: Text(lang.name),
                                  ))
                          .toList()))
            ],
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
            title: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Fast Food',
                  style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 45.0,
                      color: Color(0xFFC88067)),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          body: ListView(
            padding: EdgeInsets.only(left: 20.0),
            children: <Widget>[
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 320.0),
                child: Text("Categories",
                    style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 45.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF545D68))),
              ),
              SizedBox(
                height: 15.0,
              ),
              TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.transparent,
                  labelColor: Color(0xFFC88067),
                  isScrollable: true,
                  labelPadding: EdgeInsets.symmetric(horizontal: 44.0),
                  unselectedLabelColor: Color(0xFFCDCDCD),
                  tabs: <Widget>[
                    Tab(
                      child: Text(
                        'Burger',
                        style: TextStyle(fontFamily: 'Varela', fontSize: 37.0),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Pizza',
                        style: TextStyle(fontFamily: 'Varela', fontSize: 37.0),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Drinks',
                        style: TextStyle(fontFamily: 'Varela', fontSize: 37.0),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Appetizers',
                        style: TextStyle(fontFamily: 'Varela', fontSize: 37.0),
                      ),
                    ),
                  ]),
              Container(
                height: 2000,
                width: double.infinity,
                child: TabBarView(controller: _tabController, children: [
                  Burger(),
                  Pizza(),
                  Drinks(),
                  Appetizers(),
                ]),
              )
            ],
          ),
          floatingActionButton: BottomBar(),
        ));
  }
}
