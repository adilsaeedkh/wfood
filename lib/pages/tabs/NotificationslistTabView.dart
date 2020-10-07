import 'package:flutter/material.dart';
import 'package:wfoodalbayt/pages/widgets/ListItemThree.dart';

class NotificationslistTabView extends StatefulWidget {
  @override
  _NotificationslistTabViewState createState() =>
      _NotificationslistTabViewState();
}

class _NotificationslistTabViewState extends State<NotificationslistTabView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(8.0),
            children: <Widget>[
              ListItemThree(
                image: "assets/logo.png",
                subtitle: "الأن قم باسفر لاجمل المناظق السياحية",
                title: "من اجمل المناطق الاثريه ",
              ),
              ListItemThree(
                image: "assets/logo.png",
                subtitle: "هنالك تخفيضات على رحلات السفاري",
                title: "تفاصيل اخرى تخص البيانات",
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
//        _buildTotals()
      ],
    );
  }
}
