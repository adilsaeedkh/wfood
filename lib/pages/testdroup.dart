import 'package:flutter/material.dart';

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('DropdownButton Example')),
      body: new ListView(
        children: [
          new Column(
            children: <Widget>[
              new DropdownButton<String>(
                items: <String>['Foo', 'Bar'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
