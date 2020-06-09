import 'package:flutter/material.dart';
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
        await DatabaseService().insertOrder(x[i][0].toString(),
            x[i][1].toString(), x[i][2].toString(), _tableNumber);
      }
      setState(() {
        loading = false;
      });
      Fluttertoast.showToast(
        msg:
            'All the items are sent please wait while we finish cooking your food',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Color(0xFFC88067),
        textColor: Colors.white,
        fontSize: 40,
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Payment();
      }));
    } else {
      Fluttertoast.showToast(
        msg: 'Your ordering list is empty',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Color(0xFFC88067),
        textColor: Colors.white,
        fontSize: 40,
      );
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
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 270,
                      ),
                      Text(
                        'Fast Food',
                        style: TextStyle(
                            fontFamily: 'Pacifico',
                            fontSize: 45.0,
                            color: Color(0xFFC88067)),
                      ),
                      SizedBox(width: 100),
                      Container(
                        width: 200,
                        height: 60,
                        child: RaisedButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            color: Color(0xFFC88067),
                            child: Text(
                              "Send Order",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'Varela',
                                  color: Colors.white),
                            ),
                            onPressed: () {
                              sendtofirebase();
                            }),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
            body: ListView(children: <Widget>[
              Container(
                width: 1000,
                height: 1100,
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
            ]));
  }

  Widget check() {
    if (totalcash == null) {
      return Center(
        child: Text(
          'TotalPayment: 0 IQD',
          style: TextStyle(fontSize: 30, fontFamily: 'Varela'),
        ),
      );
    } else
      return Center(
        child: Text(
          'TotalPayment: ' + totalcash.toString() + 'IQD',
          style: TextStyle(fontSize: 30, fontFamily: 'Varela'),
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
                  '    You didn\'t order anything yet.\nGo back and try to order items first.',
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
                                  'Total: ${snapshot.data[index].amount.toString()}',
                                  style: TextStyle(
                                      color: Color(0xFF575E67),
                                      fontFamily: 'Varela',
                                      fontSize: 35),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Price: ${snapshot.data[index].totalPrice.toString()}',
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
                                        "Delete Order",
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
