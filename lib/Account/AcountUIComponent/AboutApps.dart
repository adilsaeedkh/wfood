import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

class aboutApps extends StatefulWidget {
  @override
  _aboutAppsState createState() => _aboutAppsState();
}

class _aboutAppsState extends State<aboutApps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "حول التطبيق",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: ArabicFonts.El_Messiri,
            package: 'google_fonts_arabic',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Divider(
                  height: 0.5,
                  color: Colors.black12,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, right: 15.0),
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      "assets/logo.png",
                      height: 80.0,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "وفود البيت",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: ArabicFonts.El_Messiri,
                              package: 'google_fonts_arabic',
                            ),
                          ),
                          Text(
                            "تصميم وبرمجة شركة سيتي سوفت",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: ArabicFonts.El_Messiri,
                              package: 'google_fonts_arabic',
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Divider(
                  height: 0.5,
                  color: Colors.black12,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  " تطبيق منصة وفود البيت عبارة عن تطبيق منصة وفود البيت عبارة عن تطبيق منصة وفود البيت عبارة عن تطبيق منصة وفود البيت عبارة عن تطبيق منصة وفود البيت عبارة عن تطبيق منصة وفود البيت عبارة عن تطبيق منصة وفود البيت عبارة عن",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: ArabicFonts.El_Messiri,
                    package: 'google_fonts_arabic',
                  ),
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
