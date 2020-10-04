import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restauranttest/localization/localization_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../db/orderModel.dart';
import '../db/db.dart';
import '../db/firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'loading1.dart';

class Payment extends StatefulWidget {
  final value, foodpic, totalprice, foodname;
  Payment({Key key, this.value, this.foodpic, this.totalprice, this.foodname})
      : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool loading = false;

  int totalcash;
  final dbHelper = DatabaseHelper.instance;
  OrderModel m = new OrderModel();
  @override
  void initState() {
    super.initState();
    getpay();
  }

  void getpay() async {
    totalcash = await dbHelper.getpayment();
  }

  Future sendtofirebase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _tableNumber = prefs.getString('tablenumber');

    setState(() {
      loading = true;
    });
    var x = await dbHelper.orders();

    if (x.length > 0) {
      for (int i = 0; i < x.length; i++) {
        //older version of to send
        await DatabaseService().insertOrder(
          x[i][0].toString(),
          x[i][1].toString(),
          x[i][2].toString(),
          _tableNumber,
        );
      }

      await DatabaseService().isWaiting(_tableNumber);
      await DatabaseService().sendingPrice(_tableNumber, totalcash.toString());
      setState(() {
        loading = false;
      });
      /* Fluttertoast.showToast(
        msg:
            'All the items are sent please wait while we finish cooking your food',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Color(0xFFC88067),
        textColor: Colors.white,
        fontSize: 40,
      );*/
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Container(
              width: 800,
              height: 800,
              child: StreamBuilder(
                  stream: Firestore.instance
                      .collection('waiting')
                      .where('tablenumber', isEqualTo: _tableNumber)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.data.documents.length == 0 ||
                          snapshot.data.documents.length == null) {
                        return Container(
                          color: Colors.greenAccent,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    getTranslated(context, 'Donecooking') +
                                        ' ' +
                                        totalcash.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Varela',
                                        fontSize: 40,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 40),
                                RaisedButton(
                                  color: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text(
                                    getTranslated(context, 'Done'),
                                    style: TextStyle(
                                        fontFamily: 'Varela',
                                        fontSize: 40,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (snapshot.data.documents.length > 0) {
                        return Container(
                          color: Colors.redAccent,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  getTranslated(context, 'Stillcooking'),
                                  style: TextStyle(
                                      fontFamily: 'Varela',
                                      fontSize: 40,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    }
                    return Container();
                  }),
            ));
          });
      for (int i = 0; i <= x.length; i++) {
        dbHelper.delete(i);
      }
    } else {
      Fluttertoast.showToast(
        msg: getTranslated(context, 'Emptycart'),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Color(0xFFC88067),
        textColor: Colors.white,
        fontSize: 40,
      );
      setState(() {
        loading = false;
      });
    }
  }

  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
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
              title: Text(
                getTranslated(context, 'title'),
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 45.0,
                    color: Color(0xFFC88067)),
              ),

              //HERE GOES THE PAYMENT
            ),
            body: ListView(
              children: <Widget>[
                Container(
                  width: 1000,
                  height: 1090,
                  child: _futurebuilder(),
                ),
                FutureBuilder(
                  future: dbHelper.getpayment(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:

                      case ConnectionState.active:

                      case ConnectionState.waiting:

                      case ConnectionState.done:
                        return check();
                    }

                    return Container();
                  },
                ),
              ],
            ),
            floatingActionButton: Container(
              width: 200,
              height: 100,
              child: FloatingActionButton.extended(
                backgroundColor: Color(0xFFC88067),
                label: Text(
                  getTranslated(context, 'Sendorder'),
                  style: TextStyle(
                      fontSize: 30, fontFamily: 'Varela', color: Colors.white),
                ),
                onPressed: () {
                  sendtofirebase();
                },
              ),
            ),
          );
  }

  Widget check() {
    if (totalcash == null) {
      return Center(
        child: Text(
          getTranslated(context, 'Totalpayment0'),
          style: TextStyle(fontSize: 35, fontFamily: 'Varela'),
        ),
      );
    } else
      return Center(
        child: Text(
          getTranslated(context, 'Totalpayment') +
              ' ' +
              totalcash.toString() +
              ' ' +
              getTranslated(context, 'IQD'),
          style: TextStyle(fontSize: 35, fontFamily: 'Varela'),
        ),
      );
  }

  String hello = '';
  Widget _futurebuilder() {
    return new FutureBuilder<List>(
        future: m.queryRowCount1(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('');
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Text('');
            case ConnectionState.done:
              if (snapshot.data.length == 0) {
                return Center(
                    child: Text(
                  getTranslated(context, 'Noorderdesc'),
                  style: TextStyle(
                      fontSize: 50,
                      fontFamily: 'Varela',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFCC8053)),
                ));
              } else {}
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.only(
                            top: 15.0, bottom: 15.0, left: 15.0, right: 15.0),
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
                                SizedBox(height: 15),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Image.asset(
                                    snapshot.data[index].assetpic,
                                    width: 300,
                                    height: 250.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  snapshot.data[index].name,
                                  style: TextStyle(
                                      color: Color(0xFFCC8053),
                                      fontFamily: 'Varela',
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  getTranslated(context, 'Total') +
                                      ": " +
                                      snapshot.data[index].amount.toString(),
                                  style: TextStyle(
                                      color: Color(0xFF575E67),
                                      fontFamily: 'Varela',
                                      fontSize: 35),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  getTranslated(context, "Price") +
                                      ": " +
                                      snapshot.data[index].totalPrice
                                          .toString(),
                                  style: TextStyle(
                                      color: Color(0xFF575E67),
                                      fontFamily: 'Varela',
                                      fontSize: 35),
                                ),
                                SizedBox(height: 20),
                                Container(
                                    height: 70,
                                    child: RaisedButton(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      color: Color(0xFFCC8053),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.red)),
                                      child: Text(
                                        getTranslated(context, 'Deleteorder'),
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontFamily: 'Varela',
                                            color: Colors.white),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          dbHelper
                                              .delete(snapshot.data[index].id);
                                          getpay();
                                        });
                                      },
                                    )),
                                SizedBox(height: 25),
                              ],
                            )));
                  });
          }
          return Container();
        });
  }
}
