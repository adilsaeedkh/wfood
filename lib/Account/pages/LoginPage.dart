import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:wfoodalbayt/pages/home.dart';

import '../customviews/progress_dialog.dart';
import '../utils/app_futures.dart';
import '../utils/app_shared_preferences.dart';
import '../utils/constants.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final globalKey = new GlobalKey<ScaffoldState>();

  ProgressDialog progressDialog =
      ProgressDialog.getProgressDialog(ProgressDialogTitles.USER_LOG_IN);

  TextEditingController emailController = new TextEditingController(text: "");

  TextEditingController passwordController =
      new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: globalKey,
      backgroundColor: Color(0xFFF7F7F7),
      body: new Stack(
        children: <Widget>[_loginContainer(), progressDialog],
      ),
    );
  }

  Widget _loginContainer() {
    return new Container(
        padding: const EdgeInsets.only(top: 120.0),
        child: new ListView(
          children: <Widget>[
            new Center(
              child: new Column(
                children: <Widget>[
//------------------------------------------------------------------------------
                  _appIcon(),
//------------------------------------------------------------------------------
                  _formContainer(),
//------------------------------------------------------------------------------
                ],
              ),
            ),
          ],
        ));
  }

  Widget _appIcon() {
    return new Container(
      child: new Image(
        image: new AssetImage("assets/logo.png"),
        height: 200.0,
        width: 300.0,
      ),
      margin: EdgeInsets.only(top: 20.0),
    );
  }

//------------------------------------------------------------------------------
  Widget _formContainer() {
    return new Container(
      child: new Form(
        child: new Theme(
          data: new ThemeData(primarySwatch: Colors.brown),
          child: Container(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            child: new Column(
              children: <Widget>[
//------------------------------------------------------------------------------
                _emailContainer(),
//------------------------------------------------------------------------------
                _passwordContainer(),
//------------------------------------------------------------------------------
                _loginButtonContainer(),
//------------------------------------------------------------------------------
                _registerNowLabel(),
//------------------------------------------------------------------------------
              ],
            ),
          ),
        ),
      ),
      margin: EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
    );
  }

  Widget _emailContainer() {
    return new Container(
      color: Colors.white,
      child: new TextFormField(
        controller: emailController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.mail_outline,
            color: Colors.brown,
          ),
          labelText: "إسم المستخدم",
          fillColor: Colors.brown,
          labelStyle: TextStyle(
            fontFamily: ArabicFonts.El_Messiri,
            package: 'google_fonts_arabic',
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        keyboardType: TextInputType.emailAddress,
      ),
      margin: EdgeInsets.only(bottom: 20.0),
    );
  }

  Widget _passwordContainer() {
    return new Container(
      color: Colors.white,
      child: new TextFormField(
        controller: passwordController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.brown,
          ),
          labelText: "كلمة المرور",
          fillColor: Colors.brown,
          labelStyle: TextStyle(
            fontFamily: ArabicFonts.El_Messiri,
            package: 'google_fonts_arabic',
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        keyboardType: TextInputType.text,
        obscureText: true,
      ),
      margin: EdgeInsets.only(bottom: 35.0),
    );
  }

  Widget _loginButtonContainer() {
    return new Container(
      width: double.infinity,
      child: new MaterialButton(
        height: 40.0,
        minWidth: 100.0,
        color: Colors.brown,
        splashColor: Colors.brown[200],
        textColor: Colors.white,
        padding: EdgeInsets.all(15.0),
        onPressed: _loginButtonAction,
        child: new Icon(FontAwesomeIcons.signInAlt),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white),
          borderRadius: new BorderRadius.circular(20.0),
        ),
      ),
      margin: EdgeInsets.only(bottom: 30.0),
    );
  }

  Widget _registerNowLabel() {
    return new GestureDetector(
      onTap: _goToRegisterScreen,
      child: new Container(
        child: new Text(
          "مستخدم جديد",
          style: TextStyle(
            color: Colors.black,
            fontFamily: ArabicFonts.El_Messiri,
            package: 'google_fonts_arabic',
          ),
        ),
        margin: EdgeInsets.only(bottom: 30.0),
      ),
    );
  }

  /*
   * Here we Just handel the Login Button Action
   * When we just OnTap check if the field is
   * really empty or not empty and showing you
   * a message to tell you about the status
   */
  Future _loginButtonAction() async {
    if (emailController.text == "") {
      globalKey.currentState.showSnackBar(
        new SnackBar(
          content: new Text(
            "يرجى إدخال البريد الإلكتروني",
            style: TextStyle(
              color: Colors.white,
              fontFamily: ArabicFonts.El_Messiri,
              fontWeight: FontWeight.bold,
              package: 'google_fonts_arabic',
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (passwordController.text == "") {
      globalKey.currentState.showSnackBar(
        new SnackBar(
          content: new Text(
            "يرجى إدخال كلمة المرور",
            style: TextStyle(
              color: Colors.white,
              fontFamily: ArabicFonts.El_Messiri,
              fontWeight: FontWeight.bold,
              package: 'google_fonts_arabic',
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    FocusScope.of(context).requestFocus(
      new FocusNode(),
    );
    progressDialog.showProgress();
    _loginUser(emailController.text, passwordController.text, context);
  }

  /*
   * Here we add the Function _loginUser
   * and pass the Id and Password
   * with check if the ID code is already
   * equals to the id on switch case
   * if true them we can show the message
   * and Save the response to Shared Preferences
   */
  void _loginUser(String id, String password, BuildContext context) async {
    var eventObject = await loginUser(id, password);
    Map<String, dynamic> user = eventObject.object;

    switch (eventObject.id) {
      case 1:
        {
          setState(
            () {
              AppSharedPreferences.setUserLoggedIn(true);
              AppSharedPreferences.setInSession(
                'userName',
                user['first_name'].toString(),
              );
              AppSharedPreferences.setInSession(
                'firstName',
                user['first_name'].toString(),
              );
              AppSharedPreferences.setInSession(
                'lastName',
                user['last_name'].toString(),
              );
              AppSharedPreferences.setInSession(
                'userGender',
                user['gender'].toString(),
              );
              AppSharedPreferences.setInSession(
                'userPhone',
                user['phone'].toString(),
              );

              AppSharedPreferences.setInSession(
                'userEmail',
                user['email'].toString(),
              );

              AppSharedPreferences.setInSession(
                'userId',
                user['id'].toString(),
              );

              globalKey.currentState.showSnackBar(
                new SnackBar(
                  content: new Text(
                    eventObject.message,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: ArabicFonts.El_Messiri,
                      fontWeight: FontWeight.bold,
                      package: 'google_fonts_arabic',
                    ),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              progressDialog.hideProgress();
              _goToHomeScreen();
            },
          );
        }
        break;
      case 2:
        {
          setState(
            () {
              globalKey.currentState.showSnackBar(
                new SnackBar(
                  content: new Text(
                    eventObject.message,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: ArabicFonts.El_Messiri,
                      package: 'google_fonts_arabic',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
              progressDialog.hideProgress();
            },
          );
        }
        break;

      case 0:
        {
          setState(
            () {
              globalKey.currentState.showSnackBar(
                new SnackBar(
                  content: new Text(
                    eventObject.message,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: ArabicFonts.El_Messiri,
                      package: 'google_fonts_arabic',
                    ),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
              progressDialog.hideProgress();
            },
          );
        }
        break;
    }
  }

  /*
   * Here when we just done from Login
   * then we can route to the home page
   */
  void _goToHomeScreen() {
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(
        builder: (context) => new Home(),
      ),
    );
  }

  /*
   * If we don't have account
   * then here we can route to
   * the registration page to
   * create account
   */
  void _goToRegisterScreen() {
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(
        builder: (context) => new RegisterPage(),
      ),
    );
  }
}
