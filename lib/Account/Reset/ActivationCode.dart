import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:wfoodalbayt/account/reset/ChangePassword.dart';

class ActivationCode extends StatefulWidget {
  @override
  State createState() => _ActivationCode();
}

class _ActivationCode extends State<ActivationCode>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    _iconAnimation = new CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.bounceOut,
    );
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "كود التفعيل",
                style: TextStyle(
                  color: Color(0xFF37505D),
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: ArabicFonts.El_Messiri,
                  package: 'google_fonts_arabic',
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                child: Form(
                  autovalidate: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        textAlign: TextAlign.center,
                        decoration: new InputDecoration(
                          //prefixIcon: Icon(Icons.phone),
                          labelText: "إدخل كود التفعيل",
                          fillColor: Color(0xFF37505D),
                          labelStyle: TextStyle(
                            fontFamily: ArabicFonts.El_Messiri,
                            package: 'google_fonts_arabic',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                      ),
                      MaterialButton(
                        height: 30.0,
                        minWidth: 200.0,
                        color: Color(0xFF13A1C5),
                        splashColor: Color(0xFF009AFF),
                        textColor: Colors.white,
                        child: new Text(
                          "تأكيد",
                          style: TextStyle(
                            fontFamily: ArabicFonts.El_Messiri,
                            package: 'google_fonts_arabic',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            new MaterialPageRoute(
                              builder: (context) => new ChangePassword(),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      new GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            new MaterialPageRoute(
                              builder: (context) => new ActivationCode(),
                            ),
                          );
                        },
                        child: new Text(
                          "إعادة إرسال",
                          style: TextStyle(
                            color: Color(0xFF37505D),
                            fontFamily: ArabicFonts.El_Messiri,
                            package: 'google_fonts_arabic',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
