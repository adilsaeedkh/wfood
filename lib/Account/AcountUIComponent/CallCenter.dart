import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class callCenter extends StatefulWidget {
  @override
  _callCenterState createState() => _callCenterState();
}

class _callCenterState extends State<callCenter>
    with SingleTickerProviderStateMixin, TickerProviderStateMixin {
  AnimationController _controllers;

  String result;

  @override
  void dispose() {
    _controllers.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controllers = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "مركز الإتصال والدعم الفني",
          style: TextStyle(
            fontFamily: ArabicFonts.El_Messiri,
            package: 'google_fonts_arabic',
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/icon/girlcallcenter.png",
                height: 175.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: Text(
                  "تسرنا خدمتكم أي وقت!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: ArabicFonts.El_Messiri,
                    package: 'google_fonts_arabic',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 5.0, right: 20.0, left: 20.0),
                child: Text(
                  "إذا كانت هنالك اي مشكلة مع التطبيق يمكنك مراسلتنا...",
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: ArabicFonts.El_Messiri,
                    package: 'google_fonts_arabic',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: GestureDetector(
                  onTap: () {
                    _ChackSendEmail(context);
                  },
                  child: Center(
                    child: Container(
                      height: 50.0,
                      width: 200.0,
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "راسلنا الأن",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15.0,
                            fontFamily: ArabicFonts.El_Messiri,
                            package: 'google_fonts_arabic',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _ChackSendEmail(context) {
    Alert(
        context: context,
        title: "خدمة الدعم الفني",
        content: Text(
          "هل تريد إرسال بريد إلكتروني؟",
          style: TextStyle(
            fontFamily: ArabicFonts.El_Messiri,
            package: 'google_fonts_arabic',
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        buttons: [
          DialogButton(
            onPressed: () => launch(
                "mailto:info@citysoftech.net?subject=طلب المساعدة بخصوص تطبيق وفود البيت&body=السلام عليكم ورحمة الله "),
            color: Colors.brown,
            child: Text(
              "موافق",
              style: TextStyle(
                fontFamily: ArabicFonts.El_Messiri,
                package: 'google_fonts_arabic',
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ]).show();
  }
}
