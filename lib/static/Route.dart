import 'package:flutter/material.dart';
import 'package:wfoodalbayt/Account/AcountUIComponent/AboutApps.dart';
import 'package:wfoodalbayt/Account/AcountUIComponent/CallCenter.dart';
import 'package:wfoodalbayt/Account/AcountUIComponent/ProfileTabView.dart';
import 'package:wfoodalbayt/Account/AcountUIComponent/SettingAcount.dart';
import 'package:wfoodalbayt/Account/pages/splash_page.dart';
import 'package:wfoodalbayt/pages/Booking/BookingHistory.dart';
import 'package:wfoodalbayt/pages/home.dart';

final routes = <String, WidgetBuilder>{
  "/Home": (_) => new Home(),
  "/SplashLogin": (_) => new SplashLogin(),
  "/ProfileTabView": (_) => new ProfileTabView(),
  "/BookingHistory": (_) => new BookingHistory(),
  "/aboutApps": (_) => new aboutApps(),
  "/callCenter": (_) => new callCenter(),
  "/settingAcount": (_) => new settingAcount(),
};
