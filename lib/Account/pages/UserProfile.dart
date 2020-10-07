//import 'package:flutter/material.dart';
//import 'package:google_fonts_arabic/fonts.dart';
//import 'package:wfoodalbayt/Account/pages/EditUserProfile.dart';
//import 'package:wfoodalbayt/Account/utils/app_shared_preferences.dart';
//import 'package:wfoodalbayt/translation/translation_strings.dart';
//import 'package:wfoodalbayt/ui_widgets/SizedText.dart';
//
//class UserProfileOld extends StatefulWidget {
//  @override
//  _UserProfileState createState() => _UserProfileState();
//}
//
//class _UserProfileState extends State<UserProfileOld>
//    with SingleTickerProviderStateMixin {
//  var firstName;
//  var lastName;
//  var userGender;
//  var userPhone;
//  var userBirth;
//  var userEmail;
//  var userAvatar;
//  var userId;
//
//  @override
//  Future<void> didChangeDependencies() async {
//    super.didChangeDependencies();
//    if (firstName == null ||
//        lastName == null ||
//        userGender == null ||
//        userPhone == null ||
//        userEmail == null ||
//        userId == null) {
//      await initUserProfile();
//    }
//  }
//
//  Future<void> initUserProfile() async {
//    String firstNam = await AppSharedPreferences.getFromSession('firstName');
//    String lastNam = await AppSharedPreferences.getFromSession('lastName');
//    String userGende = await AppSharedPreferences.getFromSession('userGender');
//    String userPhon = await AppSharedPreferences.getFromSession('userPhone');
//    String userEmai = await AppSharedPreferences.getFromSession('userEmail');
//    String userI = await AppSharedPreferences.getFromSession('userId');
//    setState(() {
//      firstName = firstNam;
//      lastName = lastNam;
//      userGender = userGende;
//      userPhone = userPhon;
//      userEmail = userEmai;
//      userId = userI;
//    });
//  }
//
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      body: new CustomScrollView(
//        slivers: <Widget>[
//          new SliverAppBar(
//            title: Text(
//              Translations.of(context).profile,
//              style: TextStyle(
//                  fontWeight: FontWeight.bold,
//                  fontFamily: ArabicFonts.El_Messiri,
//                  package: 'google_fonts_arabic',
//                  color: Colors.white,
//                  fontSize: EventSizedConstants.TextappBarSize,
//                  shadows: <Shadow>[
//                    new Shadow(
//                      offset: Offset(3.0, 3.0),
//                      blurRadius: 3.0,
//                      color: Color.fromARGB(255, 0, 0, 0),
//                    ),
//                    new Shadow(
//                      offset: Offset(3.0, 3.0),
//                      blurRadius: 8.0,
//                      color: Color.fromARGB(125, 0, 0, 255),
//                    ),
//                  ]),
//            ),
//            centerTitle: true,
//            pinned: true,
//            floating: false,
//            expandedHeight: 256,
//            flexibleSpace: FlexibleSpaceBar(
//              background: Stack(
//                fit: StackFit.expand,
//                children: <Widget>[
//                  FadeInImage.assetNetwork(
//                    fit: BoxFit.cover,
//                    placeholder: 'assets/logo.png',
//                    image:
//                        'https://healthitsecurity.com/images/site/article_headers/_normal/2017-11-08large-data-breach.jpg',
//                  ),
//                  const DecoratedBox(
//                    decoration: BoxDecoration(
//                      gradient: LinearGradient(
//                          colors: <Color>[Colors.black54, Color(0x00000000)],
//                          stops: [0.0, 2.0],
//                          begin: FractionalOffset.bottomCenter,
//                          end: FractionalOffset.topCenter,
//                          tileMode: TileMode.mirror),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ),
//          new SliverList(
//            delegate: SliverChildListDelegate(
//              [
//                new Padding(
//                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//                  child: new Row(
//                    mainAxisSize: MainAxisSize.max,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Text("الإسم",
//                          textAlign: TextAlign.right,
//                          style: TextStyle(
//                              fontFamily: ArabicFonts.El_Messiri,
//                              package: 'google_fonts_arabic',
//                              fontWeight: FontWeight.bold,
//                              color: Color(0xFF37505D),
//                              fontSize: 14.0)),
//                      SizedBox(
//                        width: 20.0,
//                      ),
//                      Text(
//                        "$firstName $lastName",
//                        style: TextStyle(
//                          fontFamily: ArabicFonts.El_Messiri,
//                          package: 'google_fonts_arabic',
//                        ),
//                      )
//                    ],
//                  ),
//                ),
//                new Padding(
//                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//                  child: new Row(
//                    mainAxisSize: MainAxisSize.max,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Text("رقم الهاتف",
//                          textAlign: TextAlign.right,
//                          style: TextStyle(
//                              fontFamily: ArabicFonts.El_Messiri,
//                              package: 'google_fonts_arabic',
//                              fontWeight: FontWeight.bold,
//                              color: Color(0xFF37505D),
//                              fontSize: 14.0)),
//                      SizedBox(
//                        width: 20.0,
//                      ),
//                      Text(
//                        userPhone,
//                        style: TextStyle(
//                          fontFamily: ArabicFonts.El_Messiri,
//                          package: 'google_fonts_arabic',
//                        ),
//                      )
//                    ],
//                  ),
//                ),
//                new Padding(
//                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//                  child: new Row(
//                    mainAxisSize: MainAxisSize.max,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Text("البريد الإلكتروني",
//                          textAlign: TextAlign.right,
//                          style: TextStyle(
//                              fontFamily: ArabicFonts.El_Messiri,
//                              package: 'google_fonts_arabic',
//                              fontWeight: FontWeight.bold,
//                              color: Color(0xFF37505D),
//                              fontSize: 14.0)),
//                      SizedBox(
//                        width: 20.0,
//                      ),
//                      Text(
//                        userEmail,
//                        style: TextStyle(
//                          fontFamily: ArabicFonts.El_Messiri,
//                          package: 'google_fonts_arabic',
//                        ),
//                      )
//                    ],
//                  ),
//                ),
//                new Padding(
//                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//                  child: new Row(
//                    mainAxisSize: MainAxisSize.max,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Text("النوع",
//                          textAlign: TextAlign.right,
//                          style: TextStyle(
//                              fontFamily: ArabicFonts.El_Messiri,
//                              package: 'google_fonts_arabic',
//                              fontWeight: FontWeight.bold,
//                              color: Color(0xFF37505D),
//                              fontSize: 14.0)),
//                      SizedBox(
//                        width: 20.0,
//                      ),
//                      Text(
//                        userGender,
//                        style: TextStyle(
//                          fontFamily: ArabicFonts.El_Messiri,
//                          package: 'google_fonts_arabic',
//                        ),
//                      )
//                    ],
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ],
//      ),
//      bottomNavigationBar: new Container(
//        color: Colors.white,
//        child: Row(
//          children: <Widget>[
//            Expanded(
//              child: new FlatButton(
//                onPressed: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                      builder: (context) => EditUserProfile(),
//                    ),
//                  );
//                },
//                color: Colors.brown,
//                splashColor: Colors.brown[200],
//                textColor: Colors.black,
//                //elevation: 0.2,
//                child: Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: new Text(
//                    "تعديل الصفحة الشخصية",
//                    style: TextStyle(
//                      fontFamily: ArabicFonts.El_Messiri,
//                      package: 'google_fonts_arabic',
//                      fontSize: EventSizedConstants.TextButtonFontSized,
//                      fontWeight: FontWeight.bold,
//                      color: Colors.white,
//                      shadows: <Shadow>[
//                        new Shadow(
//                          offset: Offset(3.0, 3.0),
//                          blurRadius: 3.0,
//                          color: Color.fromARGB(255, 0, 0, 0),
//                        ),
//                        new Shadow(
//                          offset: Offset(3.0, 3.0),
//                          blurRadius: 8.0,
//                          color: Color.fromARGB(125, 0, 0, 255),
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
