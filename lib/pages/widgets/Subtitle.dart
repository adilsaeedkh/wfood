import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

class Subtitle extends StatelessWidget {
  const Subtitle({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey,
        fontFamily: ArabicFonts.El_Messiri,
        package: 'google_fonts_arabic',
      ),
    );
  }
}

class GroceryTitle extends StatelessWidget {
  const GroceryTitle({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 15.0,
        fontFamily: ArabicFonts.El_Messiri,
        package: 'google_fonts_arabic',
      ),
    );
  }
}
