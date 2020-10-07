import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:wfoodalbayt/static/introScreen.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.pushReplacementNamed(context, "/Home");
    } else {
      prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
        new MaterialPageRoute(
          builder: (context) => new IntroScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    new Timer(
      new Duration(milliseconds: 5000),
      () {
        checkFirstSeen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new IntroScreen(),
      photoSize: 200.0,
      loaderColor: Colors.brown,
      image: Image.asset(
        "assets/videos/splash.gif",
        fit: BoxFit.fill,
      ),
      gradientBackground: new LinearGradient(
        colors: [
          Color(0xFFF7F7F7),
          Color(0xFFF7F7F7),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      title: Text(
        'وفود البيت',
        style: TextStyle(
          color: Colors.brown,
          fontSize: 25.0,
          fontFamily: ArabicFonts.El_Messiri,
          package: 'google_fonts_arabic',
          fontWeight: FontWeight.bold,
          shadows: <Shadow>[
            Shadow(
              offset: Offset(3.0, 3.0),
              blurRadius: 3.0,
              color: Color.fromARGB(247, 247, 247, 247),
            ),
            Shadow(
              offset: Offset(3.0, 3.0),
              blurRadius: 8.0,
              color: Color.fromARGB(247, 247, 247, 247),
            ),
          ],
        ),
      ),
      loadingText: Text(
        'يتم التحميل...',
        style: TextStyle(
          color: Colors.brown,
          fontSize: 20.0,
          fontFamily: ArabicFonts.El_Messiri,
          package: 'google_fonts_arabic',
        ),
      ),
      styleTextUnderTheLoader: new TextStyle(
        color: Colors.brown,
      ),
      onClick: () => print("wfood albayt"),
    );
  }
}
