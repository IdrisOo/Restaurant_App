import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restauranttest/localization/localization_constants.dart';
import '../db/db.dart';
import 'BottomBar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FoodDetail extends StatefulWidget {
  final assetpath, foodprice, foodname, fooddesc;

  FoodDetail({this.assetpath, this.foodprice, this.foodname, this.fooddesc});
  @override
  State<StatefulWidget> createState() {
    return _FoodDetail();
  }
}

class _FoodDetail extends State<FoodDetail> {
  final dbHelper = DatabaseHelper.instance;
  String picpath;
  int _counter = 0;
  double _totalCost = 0;

  void _addition() {
    setState(() {
      _counter = _counter + 1;
      _totalCost = _totalCost + double.parse(widget.foodprice);
    });
  }

  void _subtraction() {
    setState(() {
      if (_counter > 0) {
        _counter = _counter - 1;
        _totalCost = _totalCost - double.parse(widget.foodprice);
      }
    });
  }

  void _whenclicked() async {
    if (_counter > 0) {
      Map<String, dynamic> row = {
        DatabaseHelper.columnName: widget.foodname,
        DatabaseHelper.columnPic: widget.assetpath,
        DatabaseHelper.columnAmount: _counter,
        DatabaseHelper.columnPrice: _totalCost,
      };
      await dbHelper.insert(row);
      Fluttertoast.showToast(
        msg: getTranslated(context, 'Addeditem'),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Color(0xFFC88067),
        textColor: Colors.white,
        fontSize: 50,
      );
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
        msg: getTranslated(context, 'Addednone'),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Color(0xFFC88067),
        textColor: Colors.white,
        fontSize: 50,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
            color: Color(0xFFC88067),
            size: 40,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              getTranslated(context, 'title'),
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
      body: Padding(
          padding:
              EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0, right: 15.0),
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
              child: Column(children: <Widget>[
                SizedBox(height: 15),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    widget.assetpath,
                    width: 300,
                    height: 250.0,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 20.0),
                Column(children: <Widget>[
                  Center(
                    child: Text(widget.foodname,
                        style: TextStyle(
                            color: Color(0xFF575E67),
                            fontFamily: 'Valera',
                            fontSize: 65.0)),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          width: 400,
                          height: 600,
                          
                          
                          child: Card(
                              color: Color(0xFFF17532),
                              child: Column(children: <Widget>[
                                SizedBox(
                                  height: 100,
                                ),
                                Container(
                                  height: 200,
                                  width:
                                      MediaQuery.of(context).size.width - 50.0,
                                  child: Text(
                                    widget.fooddesc,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        shadows: [
                                          Shadow(
                                            blurRadius: 1.0,
                                            color: Colors.black,
                                            offset: Offset(0.0, 0.0),
                                          )
                                        ],
                                        fontFamily: 'Valera',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 35.0,
                                        color: Colors.white),
                                  ),
                                ),
                                SizedBox(height: 50),
                                Container(
                                  height: 100,
                                  width:
                                      MediaQuery.of(context).size.width - 50.0,
                                  child: Text(getTranslated(context, 'Price') + ' ' + widget.foodprice + ' ' + getTranslated(context, 'IQD'),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        shadows: [
                                          Shadow(
                                            blurRadius: 1.0,
                                            color: Colors.black,
                                            offset: Offset(0.0, 0.0),
                                          )
                                        ],
                                          fontFamily: 'Valera',
                                          fontSize: 50.0,
                                          color: Colors.white)),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Container(
                                    width: 300,
                                    height: 70,
                                    child: RaisedButton(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.red)),
                                      color: Colors.white,
                                      child: Text(getTranslated(context, 'Addorder'),
                                          style: TextStyle(
                                              fontFamily: 'Varela',
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFF17532))),
                                      onPressed: _whenclicked,
                                    )),
                              ]))),
                      Container(
                          width: 400,
                          height: 600,
                          decoration: BoxDecoration(boxShadow: [
                            new BoxShadow(
                                color: Color(0xFFC88067),
                                blurRadius: 4.0,
                                offset: Offset(4.0,3.0)),
                          ]),
                          child: Card(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 100,
                                ),
                                Container(
                                    height: 200,
                                    width: 300,
                                    child: Text(getTranslated(context, 'ItemNumber'),
                                        style: TextStyle(
                                            fontFamily: 'Varela',
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFF17532)))),
                                SizedBox(
                                  height: 50,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 19,
                                      ),
                                      Container(
                                          width: 150,
                                          height: 100,
                                          child: Center(
                                            child: Text(_counter.toString(),
                                                style: TextStyle(
                                                    fontFamily: 'Valera',
                                                    fontSize: 55,
                                                    color: Colors.grey)),
                                          ))
                                    ]),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: 200,
                                  height: 100,
                                  child: Center(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                        IconButton(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          iconSize: 60,
                                          icon: Icon(
                                              FontAwesomeIcons.minusSquare,
                                              size: 60,
                                              color: Color(0xFFF17532)),
                                          onPressed: _subtraction,
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        IconButton(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          iconSize: 60,
                                          icon: Icon(
                                              FontAwesomeIcons.plusSquare,
                                              size: 60,
                                              color: Color(0xFFF17532)),
                                          onPressed: _addition,
                                        ),
                                      ])),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ]),
              ]))),
      bottomNavigationBar: BottomBar(),
    );
  }
}
