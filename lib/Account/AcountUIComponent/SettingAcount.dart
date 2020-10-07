import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:wfoodalbayt/Account/utils/app_shared_preferences.dart';

class settingAcount extends StatefulWidget {
  @override
  _settingAcountState createState() => _settingAcountState();
}

class _settingAcountState extends State<settingAcount> {
  final globalKey = new GlobalKey<ScaffoldState>();
  var firstName;
  var lastName;
  var userGender;
  var userPhone;
  var userBirth;
  var userEmail;
  var userAvatar;
  var userId;
  var userName;
  var userEamil;
  bool isLogIn = false;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (userName == null || userEamil == null) {
      await initUserProfile();
    }
  }

  Future<void> initUserProfile() async {
    String firstNam = await AppSharedPreferences.getFromSession('firstName');
    String lastNam = await AppSharedPreferences.getFromSession('lastName');
    String userGende = await AppSharedPreferences.getFromSession('userGender');
    String userPhon = await AppSharedPreferences.getFromSession('userPhone');
    String userEmai = await AppSharedPreferences.getFromSession('userEmail');
    String userI = await AppSharedPreferences.getFromSession('userId');
    setState(() {
      _handleLogInLogOut();
      firstName = firstNam;
      lastName = lastNam;
      userGender = userGende;
      userPhone = userPhon;
      userEmail = userEmai;
      userId = userI;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "إعدادات الحساب",
          style: TextStyle(
            fontFamily: ArabicFonts.El_Messiri,
            package: 'google_fonts_arabic',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              setting(
                head: "الحساب",
                sub1: "العنوان",
                sub2: "الهاتف",
                sub3: "البريد الإلكتروني",
              ),
              setting(
                head: "الإعدادت",
                sub1: "الإشعارات",
                sub2: "العروض",
                sub3: "بطاقة الإئتمان",
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: _LogInOut(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _LogInOut(BuildContext context) {
    Widget holder;
    if (isLogIn) {
      holder = new InkWell(
        onTap: () {
          AppSharedPreferences.clear();
          Navigator.popAndPushNamed(context, '/Home');
        },
        child: Container(
          height: 50.0,
          width: 1000.0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 13.0, left: 20.0, right: 20.0, bottom: 15.0),
            child: Text(
              "تسجيل خروج",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
                fontFamily: ArabicFonts.El_Messiri,
                package: 'google_fonts_arabic',
              ),
            ),
          ),
        ),
      );
    } else {
      holder = new InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/SplashLogin');
        },
        child: Container(
          height: 50.0,
          width: 1000.0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 13.0, left: 20.0, right: 20.0, bottom: 15.0),
            child: Text(
              "تسجيل دخول",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
                fontFamily: ArabicFonts.El_Messiri,
                package: 'google_fonts_arabic',
              ),
            ),
          ),
        ),
      );
    }
    return holder;
  }

  void _handleLogInLogOut() async {
    bool isLoggedIn = await AppSharedPreferences.isUserLoggedIn();
    if (this.mounted) {
      setState(
        () {
          if (isLoggedIn != null && isLoggedIn) {
            isLogIn = isLoggedIn;
          } else {
            isLogIn = false;
          }
        },
      );
    }
  }
}

class setting extends StatelessWidget {
  String head, sub1, sub2, sub3;

  setting({this.head, this.sub1, this.sub2, this.sub3});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        height: 235.0,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
                child: Text(
                  head,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: ArabicFonts.El_Messiri,
                    package: 'google_fonts_arabic',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Divider(
                  color: Colors.black12,
                  height: 0.5,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        sub1,
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: ArabicFonts.El_Messiri,
                          package: 'google_fonts_arabic',
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.black38,
                      )
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Divider(
                  color: Colors.black12,
                  height: 0.5,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        sub2,
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: ArabicFonts.El_Messiri,
                          package: 'google_fonts_arabic',
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.black38,
                      )
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Divider(
                  color: Colors.black12,
                  height: 0.5,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        sub3,
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: ArabicFonts.El_Messiri,
                          package: 'google_fonts_arabic',
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.black38,
                      )
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Divider(
                  color: Colors.black12,
                  height: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
