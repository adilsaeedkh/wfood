//EditUserProfile

import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:intl/intl.dart';
import 'package:wfoodalbayt/Account/Reset/ChangePassword.dart';
import 'package:wfoodalbayt/Account/customviews/progress_dialog.dart';
import 'package:wfoodalbayt/Account/pages/LoginPage.dart';
import 'package:wfoodalbayt/Account/utils/app_shared_preferences.dart';
import 'package:wfoodalbayt/Account/utils/constants.dart';
import 'package:wfoodalbayt/ui_widgets/SizedText.dart';

class EditUserProfile extends StatefulWidget {
  @override
  createState() => new EditUserProfileState();
}

class EditUserProfileState extends State<EditUserProfile> {
  final globalKey = new GlobalKey<ScaffoldState>();

  var firstName;
  var lastName;
  var userGender;
  var userPhone;
  var userBirth;
  var userEmail;
  var userAvatar;
  var userId;

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

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (firstName == null ||
        lastName == null ||
        userGender == null ||
        userPhone == null ||
        userBirth == null ||
        userEmail == null ||
        userAvatar == null ||
        userId == null) {
      await initUserProfile();
    }
  }

  Future<void> initUserProfile() async {
    String firstNam = await AppSharedPreferences.getFromSession('firstName');
    String lastNam = await AppSharedPreferences.getFromSession('lastName');
    String userGende = await AppSharedPreferences.getFromSession('userGender');
    String userPhon = await AppSharedPreferences.getFromSession('userPhone');
    String userBirt = await AppSharedPreferences.getFromSession('userBirth');
    String userEmai = await AppSharedPreferences.getFromSession('userEmail');
    String userAvata = await AppSharedPreferences.getFromSession('userAvatar');
    String userI = await AppSharedPreferences.getFromSession('userId');
    setState(() {
      firstNameController.text = firstNam;
      phoneController.text = userPhon;
      lastNameController.text = lastNam;
      genderController.text = userGende;
      emailController.text = userEmai;

      firstName = firstNam;
      lastName = lastNam;
      userGender = userGende;
      userPhone = userPhon;
      userBirth = userBirt;
      userEmail = userEmai;
      userAvatar = userAvata;
      userId = userI;
    });
  }

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

  String _gender = '';

  DateTime convertToDate(String input) {
    try {
      var d = new DateFormat.yMd().parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }

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
        backgroundColor: Colors.white,
        body: new Stack(
          children: <Widget>[_loginContainer(), progressDialog],
        ));
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
      padding: const EdgeInsets.only(top: 30.0),
      child: new Text(
        "تعديل الصفحة اشخصية",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: ArabicFonts.El_Messiri,
            fontSize: 25.0,
            package: 'google_fonts_arabic',
            fontWeight: FontWeight.bold,
            color: Color(0xFF23AFB1)),
      ),
      margin: EdgeInsets.only(top: 50.0),
    );
  }

//------------------------------------------------------------------------------
  Widget _formContainer() {
    return new Container(
      child: new Form(
          child: new Theme(
              data: new ThemeData(primarySwatch: Colors.lightBlue),
              child: Container(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                child: new Column(
                  children: <Widget>[
//------------------------------------------------------------------------------

                    _firstNameContainer(),
//------------------------------------------------------------------------------

                    _lastNameContainer(),
//-----------------------------------------------------------------------------

                    _dateOfBarth(),
//-----------------------------------------------------------------------------

                    _phoneContainer(),
//-----------------------------------------------------------------------------

                    _selectedGender(),
//------------------------------------------------------------------------------

                    _emailContainer(),
//------------------------------------------------------------------------------

                    _registerButtonContainer(),
//------------------------------------------------------------------------------
                    _changePasswordLabel()
                  ],
                ),
              ))),
      margin: EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
    );
  }

//------------------------------------------------------------------------------
  Widget _firstNameContainer() {
    return new Container(
      height: 40.0,
      child: new TextFormField(
          controller: firstNameController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person),
            labelStyle: TextStyle(
              fontFamily: ArabicFonts.El_Messiri,
              package: 'google_fonts_arabic',
              fontWeight: FontWeight.bold,
            ),
          ),
          keyboardType: TextInputType.text),
      margin: EdgeInsets.only(bottom: 5.0),
    );
  }

  Widget _lastNameContainer() {
    return new Container(
        height: 40.0,
        child: new TextFormField(
            controller: lastNameController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelStyle: TextStyle(
                  fontFamily: ArabicFonts.El_Messiri,
                  package: 'google_fonts_arabic',
                  fontWeight: FontWeight.bold,
                )),
            keyboardType: TextInputType.text),
        margin: EdgeInsets.only(bottom: 5.0));
  }

  Widget _selectedGender() {
    return new Container(
        height: 40.0,
        child: new TextFormField(
            enabled: false,
            controller: genderController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person_pin),
              labelStyle: TextStyle(
                fontFamily: ArabicFonts.El_Messiri,
                package: 'google_fonts_arabic',
                fontWeight: FontWeight.bold,
              ),
            ),
            keyboardType: TextInputType.text),
        margin: EdgeInsets.only(bottom: 5.0));
  }

  Widget _dateOfBarth() {
    return Container(
      height: 40.0,
      child: new TextFormField(
        enabled: false,
        decoration: new InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 1.0),
          prefixIcon: const Icon(Icons.calendar_today),
          suffixIcon: new IconButton(
            icon: new Icon(Icons.date_range),
            onPressed: (() {
              _chooseDate(context, dateTimeController.text);
            }),
          ),
          labelText: userBirth,
          labelStyle: TextStyle(
            color: Color(0xFF37505D),
            fontWeight: FontWeight.bold,
            fontFamily: ArabicFonts.El_Messiri,
            package: 'google_fonts_arabic',
          ),
          hintStyle: TextStyle(
            fontFamily: ArabicFonts.El_Messiri,
            package: 'google_fonts_arabic',
          ),
        ),
        controller: dateTimeController,
        keyboardType: TextInputType.datetime,
        validator: (val) =>
            isValidDateBarth(val) ? null : 'عفواً ليس تاريخ صحيح',
      ),
      margin: EdgeInsets.only(bottom: 5.0),
    );
  }

//------------------------------------------------------------------------------
  Widget _emailContainer() {
    return new Container(
        height: 40.0,
        child: new TextFormField(
            controller: emailController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.mail_outline),
                fillColor: Color(0xFF37505D),
                labelStyle: TextStyle(
                  fontFamily: ArabicFonts.El_Messiri,
                  package: 'google_fonts_arabic',
                  fontWeight: FontWeight.bold,
                )),
            keyboardType: TextInputType.emailAddress),
        margin: EdgeInsets.only(bottom: 10.0));
  }

  Widget _phoneContainer() {
    return new Container(
      height: 40.0,
      child: new TextFormField(
          controller: phoneController,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              labelStyle: TextStyle(
                fontFamily: ArabicFonts.El_Messiri,
                package: 'google_fonts_arabic',
                fontWeight: FontWeight.bold,
              )),
          keyboardType: TextInputType.phone),
      margin: EdgeInsets.only(bottom: 5.0),
    );
  }

//------------------------------------------------------------------------------
  Widget _registerButtonContainer() {
    return new Container(
        height: 50.0,
        width: double.infinity,
        //decoration: new BoxDecoration(color: Colors.deepOrange),
        child: new MaterialButton(
          height: 40.0,
          minWidth: 200.0,
          color: Color(0xFF13A1C5),
          splashColor: Color(0xFF009AFF),
          textColor: Colors.white,
          child: new Text(
            "حفظ المعلومات",
            style: TextStyle(
              fontFamily: ArabicFonts.El_Messiri,
              package: 'google_fonts_arabic',
              fontSize: EventSizedConstants.TextButtonFontSized,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: <Shadow>[
                new Shadow(
                  offset: Offset(3.0, 3.0),
                  blurRadius: 3.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                new Shadow(
                  offset: Offset(3.0, 3.0),
                  blurRadius: 8.0,
                  color: Color.fromARGB(125, 0, 0, 255),
                ),
              ],
            ),
          ),
          padding: EdgeInsets.all(15.0),
          onPressed: _registerButtonAction,
        ),
        margin: EdgeInsets.only(bottom: 30.0));
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
      globalKey.currentState.showSnackBar(new SnackBar(
        content: new Text(
          "يرجى إدخال الإسم",
          style: TextStyle(color: Colors.black),
        ),
      ));
      return;
    }

    if (emailController.text == "") {
      globalKey.currentState.showSnackBar(new SnackBar(
        content: new Text(
          "يرجى إدخال البريد الإلكتروني",
          style: TextStyle(color: Colors.black),
        ),
      ));
      return;
    }

    if (!isValidEmail(emailController.text)) {
      globalKey.currentState.showSnackBar(new SnackBar(
        content: new Text("البريد الإلكتروني غير صحيح"),
      ));
      return;
    }

    if (emailController.text == "") {
      globalKey.currentState.showSnackBar(new SnackBar(
        content: new Text(
          "يرجى إدخال البريد الإلكتروني",
          style: TextStyle(color: Colors.black),
        ),
      ));
      return;
    }

    FocusScope.of(context).requestFocus(new FocusNode());
    progressDialog.showProgress();
  }

  //------------------------------------------------------------------------------
  Widget _changePasswordLabel() {
    return new GestureDetector(
      onTap: _goToChangePasswordScreen,
      child: new Container(
        child: new Text(
          "تغيير كلمة المرور",
          style: TextStyle(
            color: Color(0xFF37505D),
            fontFamily: ArabicFonts.El_Messiri,
            package: 'google_fonts_arabic',
          ),
        ),
        margin: EdgeInsets.only(bottom: 30.0),
      ),
    );
  }

//------------------------------------------------------------------------------
  void _goToChangePasswordScreen() {
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(
        builder: (context) => new ChangePassword(),
      ),
    );
  }

  void _goTochangePasswordScreen() {
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(builder: (context) => new LoginPage()),
    );
  }
//------------------------------------------------------------------------------
}
