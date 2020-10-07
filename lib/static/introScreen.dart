import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final pages = [
    PageViewModel(
      pageColor: Color(0xFFFFFFFF),
      bubbleBackgroundColor: Colors.brown,
      title: Container(),
      body: Column(
        children: <Widget>[
          Text(
            'منصة وفود البيت',
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: ArabicFonts.El_Messiri,
              package: 'google_fonts_arabic',
            ),
          ),
          Text(
            'منصة وفود البيت للسفر و السياحة لخدمات السفر',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: ArabicFonts.El_Messiri,
              package: 'google_fonts_arabic',
              color: Colors.black54,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
      mainImage: Image.asset(
        'assets/images/2.png',
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(
        color: Colors.black,
      ),
    ),
    PageViewModel(
      pageColor: Color(0xFFFFFFFF),
      iconColor: null,
      bubbleBackgroundColor: Colors.brown,
      title: Container(),
      body: Column(
        children: <Widget>[
          Text(
            'بضغطة زر احجز تذكرتك',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: ArabicFonts.El_Messiri,
              package: 'google_fonts_arabic',
            ),
          ),
          Text(
            'الأن بضغة رز قم بحجز تذكرتك ولا تتخلى عن اي شي اخر',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: ArabicFonts.El_Messiri,
              package: 'google_fonts_arabic',
              color: Colors.black54,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
      mainImage: Image.asset(
        'assets/images/3.png',
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(
        color: Colors.black,
      ),
    ),
    PageViewModel(
      pageColor: Color(0xFFFFFFFF),
      iconColor: null,
      bubbleBackgroundColor: Colors.brown,
      title: Container(),
      body: Column(
        children: <Widget>[
          Text(
            'خدمات السفر والسياحة',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: ArabicFonts.El_Messiri,
              package: 'google_fonts_arabic',
            ),
          ),
          Text(
            'هي منصة توفر لك كل خدمات السفر والسياحة',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: ArabicFonts.El_Messiri,
              package: 'google_fonts_arabic',
              color: Colors.black54,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
      mainImage: Image.asset(
        'assets/images/1.png',
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(
        color: Colors.black,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            IntroViewsFlutter(
              pages,
              onTapDoneButton: () {
                Navigator.pushReplacementNamed(context, "/Home");
              },
              showSkipButton: false,
              doneText: Text(
                "إبداء الأن",
                style: TextStyle(
                  fontFamily: ArabicFonts.El_Messiri,
                  package: 'google_fonts_arabic',
                ),
              ),
              pageButtonsColor: Colors.brown,
              pageButtonTextStyles: new TextStyle(
                // color: Colors.brown,
                fontSize: 16.0,
                fontFamily: ArabicFonts.El_Messiri,
                package: 'google_fonts_arabic',
              ),
            ),
            Positioned(
              top: 20.0,
              left: MediaQuery.of(context).size.width / 2 - 50,
              child: Image.asset(
                'assets/logo.png',
                width: 100,
              ),
            )
          ],
        ),
      ),
    );
  }
}
