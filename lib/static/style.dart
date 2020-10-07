import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

final ThemeData hrTheme = _buildHRTheme();

ThemeData _buildHRTheme() {
  return ThemeData(
    primarySwatch: Colors.brown,
    fontFamily: ArabicFonts.El_Messiri,
    brightness: Brightness.light,
    splashColor: Colors.brown[700],
    textSelectionColor: Colors.brown,
    primaryColor: Colors.brown,
    dividerColor: Colors.brown,
    selectedRowColor: Colors.brown[300],
    textSelectionHandleColor: Colors.brown[800],
  );
}
