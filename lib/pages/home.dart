import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:wfoodalbayt/Account/AcountUIComponent/ProfileTabView.dart';
import 'package:wfoodalbayt/pages/tabs/HomeTabView.dart';
import 'package:wfoodalbayt/pages/tabs/NotificationslistTabView.dart';
import 'package:wfoodalbayt/pages/tabs/OfferlistTabView.dart';
import 'package:wfoodalbayt/ui_widgets/SizedText.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  int _currentIndex = 0;
  List<Widget> _children = [];
  List<Widget> _appBars = [];

  @override
  void initState() {
    _children.add(HomeTabView());
    _children.add(OfferlistTabView());
    _children.add(NotificationslistTabView());
    _children.add(ProfileTabView());

    _appBars.add(_buildAppBar());
    _appBars.add(_buildAppBarOne("العروض"));
    _appBars.add(_buildAppBarOne("الإشعارات"));
    _appBars.add(_buildAppBarOne("الصفحة الشخصية"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBars[_currentIndex],
      body: _children[_currentIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text(
        "وفود البيت",
        style: TextStyle(
          fontSize: EventSizedConstants.TextappBarSize,
          fontFamily: ArabicFonts.El_Messiri,
          package: 'google_fonts_arabic',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildAppBarOne(String title) {
    return AppBar(
      centerTitle: true,
      bottom: PreferredSize(
        child: Container(
          color: Colors.grey.shade200,
          height: 1.0,
        ),
        preferredSize: Size.fromHeight(1.0),
      ),
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(
          fontSize: EventSizedConstants.TextappBarSize,
          color: Colors.white,
          fontFamily: ArabicFonts.El_Messiri,
          package: 'google_fonts_arabic',
        ),
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      onTap: _onTabTapped,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(
            "الرئيسية",
            style: TextStyle(
              fontFamily: ArabicFonts.El_Messiri,
              package: 'google_fonts_arabic',
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_offer),
          title: Text(
            "العروض",
            style: TextStyle(
              fontFamily: ArabicFonts.El_Messiri,
              package: 'google_fonts_arabic',
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          title: Text(
            "الإشعارات",
            style: TextStyle(
              fontFamily: ArabicFonts.El_Messiri,
              package: 'google_fonts_arabic',
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          title: Text(
            "الصفحة الشخصية",
            style: TextStyle(
              fontFamily: ArabicFonts.El_Messiri,
              package: 'google_fonts_arabic',
            ),
          ),
        ),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
    );
  }

  _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
