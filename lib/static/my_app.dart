import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wfoodalbayt/pages/home.dart';
import 'package:wfoodalbayt/static/Route.dart';
import 'package:wfoodalbayt/static/splash.dart';
import 'package:wfoodalbayt/static/style.dart';
import 'package:wfoodalbayt/translation/scope_model_wrapper.dart';
import 'package:wfoodalbayt/translation/translation.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => new MaterialApp(
        locale: model.appLocal,
        localizationsDelegates: [
          const TranslationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('ar', ''), // Arabic
          const Locale('en', ''), // English
        ],
        debugShowCheckedModeBanner: false,
        theme: hrTheme,
        title: "وفود البيت",
        home: new SplashPage(),
        routes: routes,
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (_) => Home(),
          );
        },
      ),
    );
  }
}
