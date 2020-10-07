import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:wfoodalbayt/Account/utils/app_shared_preferences.dart';

class ProfileTabView extends StatefulWidget {
  @override
  _profilState createState() => _profilState();
}

class _profilState extends State<ProfileTabView> {
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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              /// Setting Header Banner
              Container(
                height: 240.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/1.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// Calling _profile variable
              Padding(
                padding: EdgeInsets.only(
                  top: 185.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 100.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2.5),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/logo.png",
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text(
                            "${firstName != null ? firstName + lastName : "إسم المستخدم"}",
                            style: TextStyle(
                              fontFamily: ArabicFonts.El_Messiri,
                              package: 'google_fonts_arabic',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text(
                            "${userPhone != null ? userPhone : "رقم الهاتف"}",
                            style: TextStyle(
                              fontFamily: ArabicFonts.El_Messiri,
                              package: 'google_fonts_arabic',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text(
                            "${userEmail != null ? userEmail : "البريد الألكتروني"}",
                            style: TextStyle(
                              fontFamily: ArabicFonts.El_Messiri,
                              package: 'google_fonts_arabic',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 360.0),
                child: Column(
                  /// Setting Category List
                  children: <Widget>[
                    category(
                      txt: "الحجوزات",
                      padding: 30.0,
                      image: "assets/icon/setting.png",
                      tap: handleTapEventBookingHistory,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 85.0, right: 30.0),
                      child: Divider(
                        color: Colors.black12,
                        height: 2.0,
                      ),
                    ),
                    category(
                      txt: "الإعدادت",
                      padding: 30.0,
                      image: "assets/icon/setting.png",
                      tap: () {
                        Navigator.pushNamed(context, '/settingAcount');
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 85.0, right: 30.0),
                      child: Divider(
                        color: Colors.black12,
                        height: 2.0,
                      ),
                    ),
                    category(
                      txt: "مركز الإتصال",
                      padding: 30.0,
                      image: "assets/icon/callcenter.png",
                      tap: () {
                        Navigator.pushNamed(context, '/callCenter');
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 85.0, right: 30.0),
                      child: Divider(
                        color: Colors.black12,
                        height: 2.0,
                      ),
                    ),
                    category(
                      padding: 38.0,
                      txt: "حول التطبيق",
                      image: "assets/icon/aboutapp.png",
                      tap: () {
                        Navigator.pushNamed(context, '/aboutApps');
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleTapEventBookingHistory() async {
    bool isLoggedIn = await AppSharedPreferences.isUserLoggedIn();
    if (this.mounted) {
      setState(
        () {
          if (isLoggedIn != null && isLoggedIn) {
            Navigator.pushNamed(context, '/BookingHistory');
          } else {
            Navigator.pushNamed(context, '/SplashLogin');
          }
        },
      );
    }
  }

  void _handleTapEventProfile() async {
    bool isLoggedIn = await AppSharedPreferences.isUserLoggedIn();
    if (this.mounted) {
      setState(
        () {
          if (isLoggedIn != null && isLoggedIn) {
            Navigator.popAndPushNamed(context, '/ProfileTabView');
          } else {
            Navigator.pushNamed(context, '/SplashLogin');
          }
        },
      );
    }
  }
}

/// Component category class to set list
class category extends StatelessWidget {
  @override
  String txt, image;
  GestureTapCallback tap;
  double padding;

  category({this.txt, this.image, this.tap, this.padding});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 30.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: padding, right: 30.0),
                  child: Image.asset(
                    image,
                    height: 25.0,
                  ),
                ),
                Text(
                  txt,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: ArabicFonts.El_Messiri,
                    package: 'google_fonts_arabic',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
