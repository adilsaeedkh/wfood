import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:wfoodalbayt/Account/customviews/progress_dialog.dart';
import 'package:wfoodalbayt/Account/models/EventObject.dart';
import 'package:wfoodalbayt/Account/utils/app_futures.dart';
import 'package:wfoodalbayt/Account/utils/app_shared_preferences.dart';
import 'package:wfoodalbayt/Account/utils/constants.dart';
import 'package:wfoodalbayt/pages/home.dart';

class ChangePassword extends StatefulWidget {
  @override
  State createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  final globalKey = new GlobalKey<ScaffoldState>();
  String emailId;
  TextEditingController oldPasswordController =
      new TextEditingController(text: "");
  TextEditingController newPasswordController =
      new TextEditingController(text: "");
  TextEditingController cNewPasswordController =
      new TextEditingController(text: "");

  ProgressDialog progressDialog =
      ProgressDialog.getProgressDialog(ProgressDialogTitles.USER_LOG_IN);

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.bounceOut);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (emailId == null) {
      await initUserProfile();
    }
  }

  Future<void> initUserProfile() async {
    try {
      String email = await AppSharedPreferences.getFromSession('userEmail');
      setState(() {
        emailId = email;
      });
    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              "تغيير كلمة المرور",
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
                      decoration: new InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.lock),
                        labelText: "كلمة المرور القديمة",
                        fillColor: Color(0xFF37505D),
                        labelStyle: TextStyle(
                          fontFamily: ArabicFonts.El_Messiri,
                          package: 'google_fonts_arabic',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      obscureText: true,
                      controller: oldPasswordController,
                      keyboardType: TextInputType.text,
                    ),
                    TextFormField(
                      decoration: new InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.lock),
                        labelText: "كلمة المرور الجديدة",
                        fillColor: Color(0xFF37505D),
                        labelStyle: TextStyle(
                          fontFamily: ArabicFonts.El_Messiri,
                          package: 'google_fonts_arabic',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      obscureText: true,
                      controller: newPasswordController,
                      keyboardType: TextInputType.text,
                    ),
                    TextFormField(
                      decoration: new InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.lock),
                        labelText: "تأكيد كلمة المرور",
                        fillColor: Color(0xFF37505D),
                        labelStyle: TextStyle(
                          fontFamily: ArabicFonts.El_Messiri,
                          package: 'google_fonts_arabic',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      obscureText: true,
                      controller: cNewPasswordController,
                      keyboardType: TextInputType.text,
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
                        "تغيير",
                        style: TextStyle(
                          fontFamily: ArabicFonts.El_Messiri,
                          package: 'google_fonts_arabic',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        _changePassword(
                            oldPasswordController.text,
                            newPasswordController.text,
                            cNewPasswordController.text);
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }

//------------------------------------------------------------------------------
  void _changePassword(
      String oldPassword, String newPassword, String cNewPassword) async {
    print('String oldPassword ' +
        oldPassword +
        ', String newPassword,' +
        newPassword +
        ' String cNewPassword' +
        cNewPassword);
    if (oldPassword == '' || newPassword == '' || cNewPassword == '') {
      setState(() {
        globalKey.currentState.showSnackBar(new SnackBar(
          content: new Text('ALL INPUTS ARE REQUIRED'),
          backgroundColor: Colors.grey,
        ));
        progressDialog.hideProgress();
      });
    }

    if (newPassword != cNewPassword) {
      setState(() {
        globalKey.currentState.showSnackBar(new SnackBar(
          content: new Text(' كلمات السر غير متطابقة !'),
          backgroundColor: Colors.grey,
        ));
        progressDialog.hideProgress();
      });
    }

    EventObject eventObject =
        await changePassword(emailId, oldPassword, newPassword);

    switch (eventObject.id) {
      case 1:
        {
          setState(() {
            globalKey.currentState.showSnackBar(new SnackBar(
              content: new Text('BASSWORD SUCCESSFULY UPDATED'),
            ));
            progressDialog.hideProgress();
            _goToHomeScreen();
          });
        }
        break;
      case 2:
        {
          setState(() {
            globalKey.currentState.showSnackBar(new SnackBar(
              content: new Text(eventObject.message.toString()),
            ));
//            progressDialog.hideProgress();
          });
        }
        break;
      case 0:
        {
          setState(() {
            globalKey.currentState.showSnackBar(new SnackBar(
              content: new Text('INTERNET CONNECTION ERROR '),
            ));
            progressDialog.hideProgress();
          });
        }
        break;
    }
  }

  //------------------------------------------------------------------------------
  void _goToHomeScreen() {
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(
        builder: (context) => new Home(),
      ),
    );
  }
}
