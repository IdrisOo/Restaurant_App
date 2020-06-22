import 'package:flutter/material.dart';
import 'package:restauranttest/Pages/auth.dart';
import 'MainPage.dart';
import 'loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Variables

  final AuthService _auth = AuthService();
  String tablenum = '';
  String email = '';
  String pass = '';
  String error = '';
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Column(children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Color(0xFFFFAD7D), Color(0xFFCC8053)])),
                child: Center(
                  child: Text(
                    'FastFood',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 100,
                      fontFamily: 'Pacifico',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Expanded(
                child: Container(
                  width: 500,
                  child: ListView(children: <Widget>[
                    //tablenum Field
                    TextFormField(
                        maxLength: 2,
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        onChanged: (val) {
                          setState(() {
                            tablenum = val;
                          });
                        },
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'TableNum',
                            labelStyle: TextStyle(
                                color: Color(0xFFCC8053),
                                fontFamily: 'Varela',
                                fontSize: 50)),
                        validator: (val) {
                          if (val.isEmpty) {
                            return error = 'please enter a tablenumber';
                          } else if (val.contains(' ')) {
                            return error =
                                'please no empty spaces in the table number';
                          } else
                            return null;
                        },
                        onSaved: (String value) {
                          tablenum = value;
                        }),
                    //Table email field

                    TextFormField(
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                color: Color(0xFFCC8053),
                                fontFamily: 'Varela',
                                fontSize: 50)),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onSaved: (String value) {
                          tablenum = value;
                        }),
                    //Table pass field

                    TextFormField(
                        onChanged: (val) {
                          setState(() {
                            pass = val;
                          });
                        },
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                color: Color(0xFFCC8053),
                                fontFamily: 'Varela',
                                fontSize: 50)),
                        validator: (val) =>
                            val.isEmpty ? 'Enter a password' : null,
                        onSaved: (String value) {
                          tablenum = value;
                        }),
                    //button
                    SizedBox(height: 100),
                    Center(
                      child: RaisedButton(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontFamily: 'Varela',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 50),
                        ),
                        color: Color(0xFFCC8053),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result =
                                await _auth.signInWithEmailAndPassword(
                                    email.trim(), pass.trim());
                            if (result == null) {
                              setState(() {
                                error = 'Could not signin';
                                loading = false;
                              });
                            } else {
                              addStringToSF();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyApp()));
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                        child: Text(error,
                            style: TextStyle(
                                fontFamily: 'Varela',
                                fontWeight: FontWeight.bold,
                                fontSize: 50,
                                color: Color(0xFFCC8053))))
                  ]),
                ),
              ),
            ),
          ]));
  }

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('tablenumber', tablenum);
    prefs.setBool('isWaiting', true);
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
