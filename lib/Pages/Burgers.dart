import 'package:flutter/material.dart';
import 'package:restauranttest/localization/localization_constants.dart';
import 'FoodDetail.dart';

class Burger extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Burger();
  }
}

class _Burger extends State<Burger> {
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
                    _salesCard(
                        getTranslated(context, 'Burger1name'),
                        '4000',
                        '6500',
                        getTranslated(context, 'Burger1desc'),
                        'assets/pictures/Burger/Regular_Burger.jpg',
                        false,
                        context),
                    _buildCard(
                        getTranslated(context, 'Burger2name'),
                        '8000',
                        getTranslated(context, 'Burger2desc'),
                        'assets/pictures/Burger/Cheese_Burger.jpg',
                        false,
                        context),
                    _buildCard(
                        getTranslated(context, 'Burger3name'),
                        '10000',
                        getTranslated(context, 'Burger3name'),
                        'assets/pictures/Burger/Mushroom_Burger.jpg',
                        false,
                        context),
                    _buildCard(
                        getTranslated(context, 'Burger4name'),
                        '12500',
                        getTranslated(context, 'Burger4name'),
                        'assets/pictures/Burger/Double_Burger.jpg',
                        false,
                        context),
                    SizedBox(height: 4),
                  ],
                )),
          ],
        ));
  }

  Widget _salesCard(
    String name,
    String price,
    String oldPrice,
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
                Text(getTranslated(context, 'IQD') + ' ' + oldPrice,
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.redAccent,
                      fontFamily: 'Valera',
                      fontSize: 20.0,
                    )),
                Text(
                    getTranslated(context, 'NewPrice') +
                        ' ' +
                        getTranslated(context, 'IQD') +
                        ' ' +
                        price,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color(0xFFCC8053),
                      fontFamily: 'Valera',
                      fontSize: 25.0,
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
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    color: Color(0xFFEBEBEB),
                    height: 1.0,
                  ),
                ),
                Text(getTranslated(context, 'Order'),
                    style: TextStyle(
                        fontFamily: 'Valera',
                        color: Color(0xFFD17E50),
                        fontSize: 27.0)),
              ],
            ),
          )),
    );
  }
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
    padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0, right: 15.0),
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
              Text(getTranslated(context, 'IQD') + ' ' + price,
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
                padding: EdgeInsets.all(10.0),
                child: Container(
                  color: Color(0xFFEBEBEB),
                  height: 1.0,
                ),
              ),
              Text(getTranslated(context, 'Order'),
                  style: TextStyle(
                      fontFamily: 'Valera',
                      color: Color(0xFFD17E50),
                      fontSize: 27.0)),
            ],
          ),
        )),
  );
}
