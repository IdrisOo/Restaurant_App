import 'package:flutter/material.dart';

class Waiting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WaitingState();
  }
}

class _WaitingState extends State<Waiting>{
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:Text("helo"))
    );
}
}