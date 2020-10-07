import 'package:flutter/material.dart';
import 'package:wfoodalbayt/pages/widgets/Subtitle.dart';

class ListItemThree extends StatelessWidget {
  const ListItemThree({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.image,
    this.price,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String image;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          height: 50.0,
          child: Image.asset(
            image,
            height: 50.0,
          ),
        ),
        title: Container(
          height: 50.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new GroceryTitle(text: title),
              new Subtitle(text: subtitle)
            ],
          ),
        ),
      ),
    );
  }
}
