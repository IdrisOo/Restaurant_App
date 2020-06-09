import 'package:flutter/material.dart';
import 'Pages/LoginPage.dart';

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Varela'), home: Page());
  }
}

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
void main() => runApp(Main());
