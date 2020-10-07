import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:wfoodalbayt/Account/utils/app_shared_preferences.dart';

class TripsBooking extends StatefulWidget {
  final int subfieldId;
  final String service;

  TripsBooking({
    this.subfieldId,
    this.service,
  });

  @override
  _TripsBookingState createState() => _TripsBookingState();
}

class _TripsBookingState extends State<TripsBooking> {
  var userId;
  static final String uploadEndPoint =
      'http://192.168.8.102:4000/api/hotels_booking';

  String status = '';
  String errMessage = 'حدثة مشكلة في ارسال البيانات';

  TextEditingController bookingDateController =
      new TextEditingController(text: "");
  TextEditingController identityController =
      new TextEditingController(text: "");
  TextEditingController personController = new TextEditingController(text: "");
  TextEditingController noteMsgController = new TextEditingController(text: "");

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() {
    setStatus('جاري ارسال البيانات');
    upload();
  }

  upload() {
    http.post(uploadEndPoint, body: {
      "subfield_id": '1', //widget.subfieldId,
      "client_id": '1', //userId,
      "identity": identityController.text,
      "person": personController.text,
      "note": noteMsgController.text,
      "trip_date": bookingDateController.text,
    }).then((result) {
      print("statusCode " + result.statusCode.toString());
      print("statusCode " + result.body.toString());
      if (result.statusCode == 200) {
        var jsonstr = json.decode(result.body.toString());
        if (jsonstr["code"] == '1') {
          if (result.statusCode == 200) {
            print(result.body[0].toString());
          }
        } else {
          setStatus('no No No');
        }
      } else {
        setStatus('عفوا لا يوجد رد من السيرفر');
      }
    }).catchError((error) {
      setStatus('this is the error :' + error);
    });
  }

  Future _chooseDate(BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var initialDate = convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now)
        ? initialDate
        : now);
    var result = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: new DateTime(1900),
      lastDate: new DateTime(2025),
    );
    if (result == null) return;
    setState(() {
      bookingDateController.text = new DateFormat.yMd().format(result);
    });
  }

  DateTime convertToDate(String input) {
    try {
      var d = new DateFormat.yMd().parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (userId == null) {
      await initUserProfile();
    }
  }

  Future<void> initUserProfile() async {
    String userId = await AppSharedPreferences.getFromSession('userId');

    setState(() {
      userId = userId;
    });
  }

  Widget _bookingForm() {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 8.0),
              child: TextFormField(
                controller: personController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  icon: Icon(Icons.person, color: Colors.red),
                  labelText: "اسم المستفد ",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 8.0),
              child: TextFormField(
                controller: identityController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  icon: Icon(Icons.perm_identity, color: Colors.red),
                  labelText: "الهوية",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 8.0),
              child: TextFormField(
                controller: noteMsgController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  icon: Icon(Icons.message, color: Colors.red),
                  labelText: "اي ملاحظة او رسالة ...",
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
                  child: GestureDetector(
                    onTap: () {
                      _chooseDate(context, bookingDateController.text);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: TextFormField(
                        controller: bookingDateController,
                        keyboardType: TextInputType.text,
                        decoration:
                            InputDecoration(labelText: "تاريخ طلب الخدمة"),
                      ),
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
    return new Card(
      elevation: 6.0,
      margin: const EdgeInsets.only(left: 14, right: 14, top: 8, bottom: 16),
      child: Column(
        children: <Widget>[
          _bookingForm(),
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
