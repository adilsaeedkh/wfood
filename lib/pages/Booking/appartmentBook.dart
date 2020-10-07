import 'package:flutter/material.dart';

class appartmentBook extends StatefulWidget {
  final int subfieldId;
  final String service;

  appartmentBook({
    this.subfieldId,
    this.service,
  });

  @override
  _appartmentBookState createState() => _appartmentBookState();
}

class _appartmentBookState extends State<appartmentBook> {
  final List<String> items = List<String>.generate(10000, (i) => "Item $i");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        elevation: 0.0,
        centerTitle: true,
        title: Text(widget.service),
      ),
      body: Container(
        color: Colors.brown,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 6.0,
              margin: const EdgeInsets.only(left: 14, right: 14, top: 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Icon(Icons.directions_car, size: 36.0),
                  Text('${items[index]}'),
                  Column(
                    children: <Widget>[
                      Text(
                        'جاري ارسال البيانات',
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0, top: 6.0),
                    child: FloatingActionButton(
                      backgroundColor: Colors.green,
//            onPressed: () => setState(() => showInput = false),
                      child: Icon(Icons.send, size: 36.0),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
