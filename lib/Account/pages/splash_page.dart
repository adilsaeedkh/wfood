import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

import '../utils/app_shared_preferences.dart';
import 'LoginPage.dart';

class SplashLogin extends StatefulWidget {
  @override
  createState() => new SplashLoginState();
}

class SplashLoginState extends State<SplashLogin> {
  final globalKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    new Future.delayed(const Duration(seconds: 3), _handleTapEvent);
    return new Scaffold(
      key: globalKey,
      body: _splashContainer(),
    );
  }

  Widget _splashContainer() {
    return GestureDetector(
      onTap: _handleTapEvent,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: new BoxDecoration(color: Color(0xFFF7F7F7)),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Container(
              child: new Image(
                height: 200.0,
                width: 300.0,
                image: new AssetImage("assets/logo.png"),
                fit: BoxFit.fill,
              ),
            ),
            new Container(
              margin: EdgeInsets.only(top: 20.0),
              child: new Text(
                "تسجيل الدخول",
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 40.0,
                  fontFamily: ArabicFonts.El_Messiri,
                  package: 'google_fonts_arabic',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleTapEvent() async {
    bool isLoggedIn = await AppSharedPreferences.isUserLoggedIn();
    if (this.mounted) {
      setState(
        () {
          if (isLoggedIn != null && isLoggedIn) {
            Navigator.popAndPushNamed(context, '/MainPage');
          } else {
            Navigator.pushReplacement(
              context,
              new MaterialPageRoute(builder: (context) => new LoginPage()),
            );
          }
        },
      );
    }
  }
}
