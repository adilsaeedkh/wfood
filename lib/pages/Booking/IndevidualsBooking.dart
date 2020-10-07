import 'package:flutter/material.dart';

class IndevidualsBooking extends StatefulWidget {
  final int subfieldId;
  final String service;

  IndevidualsBooking({
    this.subfieldId,
    this.service,
  });

  @override
  _IndevidualsBookingState createState() => _IndevidualsBookingState();
}

class _IndevidualsBookingState extends State<IndevidualsBooking> {
  var userId;
  static final String uploadEndPoint =
      'http://192.168.8.102:4000/api/hotels_booking';

  Widget _bookingForm() {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.flight_takeoff, color: Colors.red),
                  labelText: "من",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.flight_land, color: Colors.red),
                  labelText: "إلى",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.person, color: Colors.red),
                  labelText: "عدد البالغين",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.person, color: Colors.red),
                  labelText: "عدد الاطفال",
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(Icons.date_range, color: Colors.red),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "المغادرة"),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(Icons.date_range, color: Colors.red),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "الوصول"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _bookingFormWrapper() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return new Card(
          elevation: 6.0,
          margin: const EdgeInsets.only(left: 14, right: 14, top: 8),
          child: Row(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.width / 12,
              ),
              Text(
                'جاري ارسال البيانات',
                style: TextStyle(color: Colors.green),
              ),
              Expanded(
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
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
      itemCount: 3,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(widget.service),
      ),
      body: Container(
        color: Colors.brown,
        child: _bookingFormWrapper(),
      ),
    );
  }
}
