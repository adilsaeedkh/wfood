import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:wfoodalbayt/Account/utils/app_shared_preferences.dart';

class flightSeaBooking extends StatefulWidget {
  final int subfieldId;
  final String service;
  final int serviceId;

  flightSeaBooking({
    this.subfieldId,
    this.service,
    this.serviceId,
  });

  @override
  _hotelBookingState createState() => _hotelBookingState();
}

class _hotelBookingState extends State<flightSeaBooking> {
  var userName;
  var userId;
  static final String uploadEndPoint =
      'http://192.168.8.102:4000/api/hotels_booking';

  String status = '';
  String errMessage = 'حدثة مشكلة في ارسال البيانات';

  final globalKey = new GlobalKey<ScaffoldState>();

  TextEditingController bookingFromController =
      new TextEditingController(text: "");

  TextEditingController bookingToController =
      new TextEditingController(text: "");

  TextEditingController identityController =
      new TextEditingController(text: "");
  TextEditingController adultController = new TextEditingController(text: "");
  TextEditingController childrenController =
      new TextEditingController(text: "");

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
      "service_id": '1', //userId,
      "round": '1', //userId,
      "adult": adultController.text,
      "children": childrenController.text,
      "from_address": bookingFromController.text,
      "to_address": bookingToController.text,
      "departure_date": identityController.text,
      "return_date": identityController.text,
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

  //show date time pick up
  Future _chooseDateFrom(BuildContext context, String initialDateString) async {
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
      bookingFromController.text = new DateFormat.yMd().format(result);
    });
  }

  Future _chooseDateTo(BuildContext context, String initialDateString) async {
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
      bookingToController.text = new DateFormat.yMd().format(result);
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
    if (userName == null || userId == null) {
      await initUserProfile();
    }
  }

  Future<void> initUserProfile() async {
    String name = await AppSharedPreferences.getFromSession('userName');
    String userId = await AppSharedPreferences.getFromSession('userId');

    setState(() {
      userName = name;
      userId = userId;
    });
  }

  String roundTitle = 'ذهاب';
  //check if the dateBarth is right or not
  bool isValidDate(String givenDate) {
    if (givenDate.isEmpty) return true;
    var d = convertToDate(givenDate);
    return d != null && d.isBefore(new DateTime.now());
  }

  /// DropDown Center Container
  Widget _dropDownroundTitleContainer() {
    return DropdownButton<String>(
      value: roundTitle,
      icon: Icon(
        roundTitle == 'ذهاب' ? Icons.arrow_forward : Icons.compare_arrows,
        color: Colors.red,
        size: 20,
      ),
      iconSize: 24,
      elevation: 16,
      isExpanded: true,
      style: TextStyle(color: Colors.black),
//      underline: Container(
//        height: .5,
//        color: Colors.black,
//      ),
      onChanged: (String newValue) {
        setState(() {
          roundTitle = newValue;
        });
      },
      items: <String>['ذهاب', 'ذهاب واياب']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  TextEditingController FromController = new TextEditingController(text: "");

  Widget _bookingForm() {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    right: 16.0,
                    top: 8,
                  ),
                  child: Icon(
                    roundTitle == 'ذهاب'
                        ? Icons.arrow_forward
                        : Icons.compare_arrows,
                    color: Colors.red,
                    size: 30.0,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 16.0,
                      top: 8,
                    ),
                    child: DropdownButton<String>(
                      value: roundTitle,
                      elevation: 4,
                      isExpanded: true,
                      style: TextStyle(color: Colors.black),
                      onChanged: (String newValue) {
                        setState(() {
                          roundTitle = newValue;
                        });
                      },
                      items: <String>['ذهاب', 'ذهاب واياب']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 6.0),
              child: TextFormField(
                controller: FromController,
                decoration: InputDecoration(
                  icon: Icon(
                      widget.serviceId == 1
                          ? Icons.flight_takeoff
                          : Icons.directions_boat,
                      color: Colors.red),
                  labelText: "من",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 6.0),
              child: TextFormField(
                decoration: InputDecoration(
                  icon: Icon(
                      widget.serviceId == 1
                          ? Icons.flight_land
                          : Icons.directions_boat,
                      color: Colors.red),
                  labelText: "إلى",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 6.0),
              child: TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.person, color: Colors.red),
                  labelText: "عدد البالغين",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 6.0),
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
                  child: Icon(Icons.calendar_today, color: Colors.red),
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

  Widget _bookingFormWrapper(BuildContext context) {
    return new Card(
      elevation: 4.0,
      margin: const EdgeInsets.only(left: 14, right: 14, top: 8, bottom: 16),
      child: Column(
        children: <Widget>[
          _bookingForm(),
          SizedBox(
            height: MediaQuery.of(context).size.width / 22,
          ),
          Text(
            '',
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
      key: globalKey,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(widget.service),
      ),
      body: Container(
        color: Colors.brown,
        child: _bookingFormWrapper(context),
//        child: _formContainer(),
      ),
    );
  }
}
