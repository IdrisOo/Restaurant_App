import 'package:flutter/material.dart';
import 'FoodDetail.dart';

class Pizza extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Pizza();
  }
}

class _Pizza extends State<Pizza> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFCFAF8),
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Container(
                padding: EdgeInsets.only(right: 15.0),
                width: MediaQuery.of(context).size.width - 30.0,
                height: MediaQuery.of(context).size.height - 50.0,
                child: GridView.count(
                  crossAxisCount: 2,
                  primary: false,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 15.0,
                  childAspectRatio: 0.8,
                  children: <Widget>[
                    _buildCard(
                        'Margherita Pizza',
                        '8000',
                        'Cheese, Tomatosauce, Vegies',
                        'assets/pictures/Pizza/Margherita_Pizza.jpg',
                        false,
                        context),
                    _buildCard(
                        'Peperoni Pizza',
                        '10000',
                        'Cheese, Peperonis, Tomato sause & Vegetables',
                        'assets/pictures/Pizza/Peperoni_Pizza.jpg',
                        false,
                        context),
                    _buildCard(
                        'Pineapple Pizza',
                        '12000',
                        'Cheese, Pineappples, sauce',
                        'assets/pictures/Pizza/Pineapple_Pizza.jpg',
                        false,
                        context),
                    _buildCard(
                        'Vegetable Pizza',
                        '9000',
                        'Cheese, Tomato sauce & Vegetables',
                        'assets/pictures/Pizza/Vegetable_Pizza.jpg',
                        false,
                        context),
                    SizedBox(height: 4),
                  ],
                )),
          ],
        ));
  }

  Widget _buildCard(
    String name,
    String price,
    String desc,
    String imgPath,
    bool added,
    context,
  ) {
    return Padding(
      padding:
          EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0, right: 15.0),
      child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FoodDetail(
                      assetpath: imgPath,
                      foodprice: price,
                      foodname: name,
                      fooddesc: desc,
                    )));
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3.0,
                      blurRadius: 5.0)
                ],
                color: Colors.white),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    imgPath,
                    width: 300,
                    height: 250.0,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 20.0),
                Text('IQD ' + price,
                    style: TextStyle(
                      color: Color(0xFFCC8053),
                      fontFamily: 'Valera',
                      fontSize: 30.0,
                    )),
                SizedBox(
                  height: 20,
                ),
                Text(name,
                    style: TextStyle(
                      color: Color(0xFF575E67),
                      fontFamily: 'Valera',
                      fontSize: 30.0,
                    )),
                Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Container(
                    color: Color(0xFFEBEBEB),
                    height: 1.0,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Text('Order',
                      style: TextStyle(
                          fontFamily: 'Valera',
                          color: Color(0xFFD17E50),
                          fontSize: 50.0)),
                ),
              ],
            ),
          )),
    );
  }
}

/*
 Hero(
                    tag: imgPath,
                    child: Container(
                      height: 200.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: 
                            AssetImage(
                              imgPath,
                            ),
                            fit: BoxFit.contain),
                      ),
                    )),
*/
