import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:intl/intl.dart';

import '../customviews/progress_dialog.dart';
import '../models/EventObject.dart';
import '../utils/app_futures.dart';
import '../utils/constants.dart';
import 'LoginPage.dart';

class RegisterPage extends StatefulWidget {
  @override
  createState() => new RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final globalKey = new GlobalKey<ScaffoldState>();

  //show date time pick up
  Future _chooseDate(BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var initialDate = convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now)
        ? initialDate
        : now);
    var result = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: new DateTime(1900),
      lastDate: new DateTime.now(),
    );
    if (result == null) return;
    setState(() {
      dateTimeController.text = new DateFormat.yMd().format(result);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  int _gender = -1;

  DateTime convertToDate(String input) {
    try {
      var d = new DateFormat.yMd().parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }

  ProgressDialog progressDialog =
      ProgressDialog.getProgressDialog(ProgressDialogTitles.USER_REGISTER);

  TextEditingController firstNameController =
      new TextEditingController(text: "");
  TextEditingController dateTimeController =
      new TextEditingController(text: "");
  TextEditingController lastNameController =
      new TextEditingController(text: "");
  TextEditingController emailController = new TextEditingController(text: "");
  TextEditingController phoneController = new TextEditingController(text: "");
  TextEditingController passwordController =
      new TextEditingController(text: "");
  TextEditingController genderController = new TextEditingController(text: "");

//------------------------------------------------------------------------------

  bool isValidEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

//------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: globalKey,
      backgroundColor: Color(0xFFF7F7F7),
      body: new Stack(
        children: <Widget>[
          _loginContainer(),
          progressDialog,
        ],
      ),
    );
  }

//------------------------------------------------------------------------------
  Widget _loginContainer() {
    return new Container(
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

//------------------------------------------------------------------------------
  Widget _appIcon() {
    return new Container(
      padding: const EdgeInsets.only(top: 50.0),
      child: new Text(
        "إنشاء حساب",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: ArabicFonts.El_Messiri,
          fontSize: 25.0,
          package: 'google_fonts_arabic',
          fontWeight: FontWeight.bold,
          color: Colors.brown,
        ),
      ),
      margin: EdgeInsets.only(top: 15.0),
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
                _firstNameContainer(),
//------------------------------------------------------------------------------
                _lastNameContainer(),
//------------------------------------------------------------------------------
//                _dateOfBarth(),
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
                _phoneContainer(),
//------------------------------------------------------------------------------
                _emailContainer(),
//------------------------------------------------------------------------------
                _passwordContainer(),
//------------------------------------------------------------------------------

                _selectGenderTow(),
//------------------------------------------------------------------------------

                _registerButtonContainer(),
//------------------------------------------------------------------------------
                _loginNowLabel(),
//------------------------------------------------------------------------------
              ],
            ),
          ),
        ),
      ),
      margin: EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
    );
  }

//------------------------------------------------------------------------------
  Widget _firstNameContainer() {
    return new Container(
      color: Colors.white,
      //height: 70.0,
      child: new TextFormField(
          maxLength: 10,
          controller: firstNameController,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.person,
              color: Colors.brown,
            ),
            labelText: "الإسم الاول",
            labelStyle: TextStyle(
              fontFamily: ArabicFonts.El_Messiri,
              package: 'google_fonts_arabic',
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          keyboardType: TextInputType.text),
      margin: EdgeInsets.only(bottom: 5.0),
    );
  }

  Widget _lastNameContainer() {
    return new Container(
      color: Colors.white,
      child: new TextFormField(
          maxLength: 10,
          controller: lastNameController,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.person,
              color: Colors.brown,
            ),
            labelText: "الإسم الثاني",
            labelStyle: TextStyle(
              fontFamily: ArabicFonts.El_Messiri,
              package: 'google_fonts_arabic',
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          keyboardType: TextInputType.text),
      margin: EdgeInsets.only(bottom: 5.0),
    );
  }

  @override
  Widget _selectGenderTow() {
    return Container(
      child: Column(
        children: <Widget>[
          _myRadioButton(
            title: "ذكر",
            value: 0,
            onChanged: (newValue) => setState(() => _gender = newValue),
          ),
          _myRadioButton(
            title: "انثى",
            value: 1,
            onChanged: (newValue) => setState(() => _gender = newValue),
          ),
        ],
      ),
    );
  }

  Widget _myRadioButton({String title, int value, Function onChanged}) {
    return RadioListTile(
      activeColor: Colors.brown,
      value: value,
      groupValue: _gender,
      onChanged: onChanged,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.brown,
          fontWeight: FontWeight.bold,
          fontFamily: ArabicFonts.El_Messiri,
          package: 'google_fonts_arabic',
        ),
      ),
    );
  }

//  Widget _dateOfBarth() {
//    return GestureDetector(
//      onTap: () {
//        _chooseDate(context, dateTimeController.text);
//      },
//      child: Container(
//        color: Colors.white,
//        //height: 70.0,
//        child: new TextFormField(
//          maxLength: 12,
//          decoration: new InputDecoration(
//            contentPadding: const EdgeInsets.symmetric(vertical: 1.0),
//            prefixIcon: const Icon(
//              Icons.calendar_today,
//              color: Colors.brown,
//            ),
//            suffixIcon: new IconButton(
//              icon: new Icon(
//                Icons.date_range,
//                color: Colors.brown,
//              ),
//              onPressed: (() {
//                _chooseDate(context, dateTimeController.text);
//              }),
//            ),
//            hintText: "إدخل تاريخ الميلاد",
//            labelText: "تاريخ الميلاد",
//            labelStyle: TextStyle(
//              color: Colors.brown,
//              fontWeight: FontWeight.bold,
//              fontFamily: ArabicFonts.El_Messiri,
//              package: 'google_fonts_arabic',
//            ),
//            hintStyle: TextStyle(
//              fontFamily: ArabicFonts.El_Messiri,
//              package: 'google_fonts_arabic',
//            ),
//          ),
//          controller: dateTimeController,
//          keyboardType: TextInputType.datetime,
//          validator: (val) => isValidDateBarth(val) ? null : 'ليس تاريخ صالح',
//        ),
//        margin: EdgeInsets.only(bottom: 5.0),
//      ),
//    );
//  }

//------------------------------------------------------------------------------
  Widget _emailContainer() {
    return new Container(
      color: Colors.white,
      child: new TextFormField(
          maxLength: 10,
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
          keyboardType: TextInputType.emailAddress),
      margin: EdgeInsets.only(bottom: 5.0),
    );
  }

//------------------------------------------------------------------------------
  Widget _passwordContainer() {
    return new Container(
        color: Colors.white,
        child: new TextFormField(
          maxLength: 15,
//          minLines: 8,
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
              )),
          keyboardType: TextInputType.text,
          obscureText: true,
        ),
        margin: EdgeInsets.only(bottom: 5.0));
  }

  Widget _phoneContainer() {
    return new Container(
      color: Colors.white,
      child: new TextFormField(
          maxLength: 15,
          controller: phoneController,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.person,
              color: Colors.brown,
            ),
            labelText: "رقم الهاتف",
            labelStyle: TextStyle(
              fontFamily: ArabicFonts.El_Messiri,
              package: 'google_fonts_arabic',
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          keyboardType: TextInputType.phone),
      margin: EdgeInsets.only(bottom: 5.0),
    );
  }

//------------------------------------------------------------------------------
  Widget _registerButtonContainer() {
    return new Container(
        width: double.infinity,
        //decoration: new BoxDecoration(color: Colors.deepOrange),
        child: new MaterialButton(
          height: 40.0,
          minWidth: 200.0,
          color: Colors.brown,
          splashColor: Colors.brown[200],
          textColor: Colors.white,
          child: new Icon(FontAwesomeIcons.signInAlt),
          padding: EdgeInsets.all(15.0),
          onPressed: _registerButtonAction,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white),
            borderRadius: new BorderRadius.circular(20.0),
          ),
        ),
        margin: EdgeInsets.only(bottom: 10.0));
  }

//------------------------------------------------------------------------------
  Widget _loginNowLabel() {
    return new GestureDetector(
      onTap: _goToLoginScreen,
      child: new Container(
          child: new Text(
            "هل لديك حساب؟ تسجيل دخول",
            style: TextStyle(
              color: Colors.black,
              fontFamily: ArabicFonts.El_Messiri,
              package: 'google_fonts_arabic',
            ),
          ),
          margin: EdgeInsets.only(bottom: 30.0)),
    );
  }

  //check if the dateBarth is right or not
  bool isValidDateBarth(String birthDate) {
    if (birthDate.isEmpty) return true;
    var d = convertToDate(birthDate);
    return d != null && d.isBefore(new DateTime.now());
  }

//------------------------------------------------------------------------------
  void _registerButtonAction() {
    if (firstNameController.text == "" && lastNameController.text == "") {
      globalKey.currentState.showSnackBar(
        new SnackBar(
          content: new Text(
            'يرجى إدخال الإسم',
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

    if (emailController.text == "") {
      globalKey.currentState.showSnackBar(
        new SnackBar(
          content: new Text(
            'يرجى إدخال البريد الإلكتروني',
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

    if (!isValidEmail(emailController.text)) {
      globalKey.currentState.showSnackBar(
        new SnackBar(
          content: new Text(
            'يرجى كتابة بريد صحيح',
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

    if (emailController.text == "") {
      globalKey.currentState.showSnackBar(
        new SnackBar(
          content: new Text(
            "يرجى إدال البريد الإلكتروني",
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
            'يرجى إدخال كلمة المرور',
            style: TextStyle(
              color: Colors.white,
              fontFamily: ArabicFonts.El_Messiri,
              fontWeight: FontWeight.bold,
              package: 'google_fonts_arabic',
            ),
          ),
        ),
      );
      return;
    }

    FocusScope.of(context).requestFocus(new FocusNode());
    progressDialog.showProgress();

    _registerUser(
      firstNameController.text,
      lastNameController.text,
      _gender,
      phoneController.text,
      emailController.text,
      passwordController.text,
      dateTimeController.text,
    );
  }

//------------------------------------------------------------------------------
  void _registerUser(String firstName, String lastName, int gender,
      String phone, String email, String password, String birthDate) async {
    String genderTemp;
    switch (gender) {
      case 0:
        genderTemp = 'male';
        break;
      case 1:
        genderTemp = "female";
        break;
    }
    EventObject eventObject = await registerUser(
        firstName, lastName, genderTemp, phone, email, password, birthDate);
    switch (eventObject.id) {
      case 1:
        {
          setState(() {
            globalKey.currentState.showSnackBar(
              new SnackBar(
                content: new Text(
                  'تم إنشاء حساب بنجاح',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: ArabicFonts.El_Messiri,
                    fontWeight: FontWeight.bold,
                    package: 'google_fonts_arabic',
                  ),
                ),
                backgroundColor: Colors.blueAccent,
              ),
            );
            progressDialog.hideProgress();
            _goToLoginScreen();
          });
        }
        break;
      case 2:
        {
          setState(
            () {
              globalKey.currentState.showSnackBar(
                new SnackBar(
                  content: new Text(
                    'المستخدم موجود مسبقاً',
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
              progressDialog.hideProgress();
            },
          );
        }
        break;
      case 0:
        {
          setState(() {
            globalKey.currentState.showSnackBar(
              new SnackBar(
                content: new Text(
                  "لم يتم إنشاء الحساب يرجى المحاوله مرى إخرى",
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
            progressDialog.hideProgress();
          });
        }
        break;
    }
  }

//------------------------------------------------------------------------------

  void _goToLoginScreen() {
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(builder: (context) => new LoginPage()),
    );
  }
//------------------------------------------------------------------------------
}
