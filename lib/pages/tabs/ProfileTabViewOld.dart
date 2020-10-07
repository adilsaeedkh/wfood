import 'package:flutter/material.dart';
import 'package:wfoodalbayt/Account/utils/app_shared_preferences.dart';
import 'package:wfoodalbayt/pages/widgets/Subtitle.dart';

class ProfileTabViewOld extends StatefulWidget {
  @override
  _ProfileTabViewState createState() => _ProfileTabViewState();
}

class _ProfileTabViewState extends State<ProfileTabViewOld> {
  final globalKey = new GlobalKey<ScaffoldState>();

  var userName;
  var userEamil;
  var userPhone;
  bool isLogIn = false;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (userName == null || userEamil == null) {
      await initUserProfile();
    }
  }

  Future<void> initUserProfile() async {
    try {
      String name = await AppSharedPreferences.getFromSession('userName');
      String email = await AppSharedPreferences.getFromSession('userEmail');
      String phone = await AppSharedPreferences.getFromSession('userPhone');

      setState(() {
        _handleLogInLogOut();
        userName = name;
        userEamil = email;
        userPhone = phone;
      });
    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          ListTile(
            onTap: _handleTapEventProfile,
            leading: Icon(Icons.person_pin),
            title: GroceryTitle(text: "الصفحة الشخصية"),
          ),
          ListTile(
            onTap: handleTapEventBookingHistory,
            leading: Icon(Icons.history),
            title: GroceryTitle(text: "الحجوزات"),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/UserProfile');
            },
            leading: Icon(Icons.history),
            title: GroceryTitle(text: "الصفحة الشخصية"),
          ),
          _LogInOut(context),
        ],
      ),
    );
  }

  Widget _LogInOut(BuildContext context) {
    Widget holder;
    if (isLogIn) {
      holder = new ListTile(
        onTap: () {
          AppSharedPreferences.clear();
          Navigator.popAndPushNamed(context, '/Home');
        },
        leading: Icon(Icons.exit_to_app),
        title: GroceryTitle(
          text: "تسجيل خروج",
        ),
      );
    } else {
      holder = new ListTile(
        onTap: () {
          Navigator.pushNamed(context, '/SplashLogin');
        },
        leading: Icon(Icons.exit_to_app),
        title: GroceryTitle(
          text: "تسجيل دخول",
        ),
      );
    }
    return holder;
  }

  void handleTapEventBookingHistory() async {
    bool isLoggedIn = await AppSharedPreferences.isUserLoggedIn();
    if (this.mounted) {
      setState(() {
        if (isLoggedIn != null && isLoggedIn) {
          Navigator.pushNamed(context, '/BookingHistory');
        } else {
          Navigator.pushNamed(context, '/SplashLogin');
        }
      });
    }
  }

  void _handleLogInLogOut() async {
    bool isLoggedIn = await AppSharedPreferences.isUserLoggedIn();
    if (this.mounted) {
      setState(() {
        if (isLoggedIn != null && isLoggedIn) {
          isLogIn = isLoggedIn;
        } else {
          isLogIn = false;
        }
      });
    }
  }

  void _handleTapEventProfile() async {
    bool isLoggedIn = await AppSharedPreferences.isUserLoggedIn();
    if (this.mounted) {
      setState(() {
        if (isLoggedIn != null && isLoggedIn) {
          Navigator.popAndPushNamed(context, '/UserProfile');
        } else {
          Navigator.pushNamed(context, '/SplashLogin');
        }
      });
    }
  }
}
