import 'package:flutter/material.dart';
import '../Pages/Paypage.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 330,
        height: 80,
        child: FloatingActionButton.extended(
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Payment();
            }));
          },
          label: Text("Your Orders",
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC88067))),
          icon: Icon(
            Icons.shopping_cart,
            size: 30,
            color: Color(0xFFC88067),
          ),
        ));
  }
}

