import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

class Category extends StatelessWidget {
  final String image, title;
  final Color backgroundColor;

  const Category({
    Key key,
    @required String this.image,
    @required String this.title,
    Color this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.all(10.0),
      width: 100,
      child: Column(
        children: <Widget>[
          Image.asset(
            image,
            height: 40.0,
            width: 40.0,
          ),
          Text(
            title,
            style: TextStyle(
              fontFamily: ArabicFonts.El_Messiri,
              package: 'google_fonts_arabic',
            ),
          )
        ],
      ),
    );
  }
}
