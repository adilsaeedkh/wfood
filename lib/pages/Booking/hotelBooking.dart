import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:wfoodalbayt/Account/utils/app_shared_preferences.dart';

class HotelBooking extends StatefulWidget {
  final int id;
  final int subfieldId;
  final String service;
  HotelBooking({
    this.id,
    this.subfieldId,
    this.service,
  });

  @override
  _hotelBookingState createState() => _hotelBookingState();
}

class _hotelBookingState extends State<HotelBooking> {
  var userName;
  var userId;
  static final String uploadEndPoint =
      'http://192.168.8.102:4000/api/hotels_booking';

  String status = '  ';
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
      "identity": identityController.text,
      "adult": adultController.text,
      "children": childrenController.text,
      "booking_from": bookingFromController.text,
      "booking_to": bookingToController.text,
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

  DateTime _date = new DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: new DateTime(2019),
      lastDate: new DateTime(2050),
    );
    if (picked != null && picked != _date) {
      print('Date selected: ${_date.toString()}');
      setState(() {
        _date = picked;
      });
    }
  }

  //------------------------------------------------------------------------------
  Widget _identityContainer() {
    return new Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.width / 7,
      width: MediaQuery.of(context).size.width - 50,
      child: new TextFormField(
          controller: identityController,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.person,
              color: Colors.brown,
            ),
            labelText: "إثبات شخصية",
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          keyboardType: TextInputType.text),
      margin: EdgeInsets.only(bottom: 5.0),
    );
  }

  //-----------------bookingFromController---------------------------------------------------
  Widget _bookingFromDate() {
    return GestureDetector(
      onTap: () {
        _chooseDateFrom(context, bookingFromController.text);
      },
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.width / 7,
        width: MediaQuery.of(context).size.width - 50,
        child: new TextFormField(
          decoration: new InputDecoration(
//            contentPadding: const EdgeInsets.symmetric(vertical: 1.0),
            prefixIcon: const Icon(
              Icons.calendar_today,
              color: Colors.brown,
            ),
            suffixIcon: new IconButton(
              icon: new Icon(
                Icons.date_range,
                color: Colors.brown,
              ),
              onPressed: (() {
                _chooseDateFrom(context, bookingFromController.text);
              }),
            ),
            labelText: "تاريخ الوصول",
            labelStyle: TextStyle(
              color: Colors.brown,
            ),
          ),
          controller: bookingFromController,
          keyboardType: TextInputType.datetime,
          validator: (val) => isValidDateBarth(val) ? null : 'ليس تاريخ صالح',
        ),
        margin: EdgeInsets.only(bottom: 5.0),
      ),
    );
  }

  //-----------------bookingToController-----------------------------------------------------
  Widget _bookingToDate() {
    return GestureDetector(
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.width / 7,
        child: new TextFormField(
          decoration: new InputDecoration(
            prefixIcon: const Icon(
              Icons.calendar_today,
              color: Colors.brown,
            ),
            suffixIcon: new IconButton(
              icon: new Icon(
                Icons.date_range,
                color: Colors.brown,
              ),
              onPressed: (() {
                _chooseDateTo(context, bookingToController.text);
              }),
            ),
            labelText: "تاريخ المغادرة",
            labelStyle: TextStyle(
              color: Colors.brown,
            ),
          ),
          controller: bookingToController,
          keyboardType: TextInputType.datetime,
          validator: (val) => isValidDateBarth(val) ? null : 'ليس تاريخ صالح',
        ),
        margin: EdgeInsets.only(bottom: 5.0),
      ),
    );
  }

  //check if the dateBarth is right or not
  bool isValidDateBarth(String birthDate) {
    if (birthDate.isEmpty) return true;
    var d = convertToDate(birthDate);
    return d != null && d.isBefore(new DateTime.now());
  }

//////////////////////////////////////////////////////////////////////////////////////
  Widget _formContainer() {
    return new Container(
      child: new Form(
        child: new Theme(
          data: new ThemeData(primarySwatch: Colors.brown),
          child: Container(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: new Column(
              children: <Widget>[
//------------------------------------------------------------------------------
                _identityContainer(),
//------------------------------------------------------------------------------
                _bookingFromDate(),
//------------------------------------------------------------------------------
                _bookingToDate(),
//------------------------------------------------------------------------------
                OutlineButton(
                  onPressed: startUpload,
                  child: Text('إرسال البيانات'),
                ),
//------------------------------------------------------------------------------
                Text(
                  status,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
                  ),
                ),
//------------------------------------------------------------------------------
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
      margin: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
    );
  }

  Widget _bookingForm() {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 8.0),
                child: TextFormField(
//                controller: FromController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.date_range, color: Colors.red),
                    labelText: "تاريخ الوصول",
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.date_range, color: Colors.red),
                  labelText: "تاريخ المغادرة",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 8.0),
              child: TextFormField(
                controller: identityController,
                decoration: InputDecoration(
                  icon: Icon(Icons.perm_identity, color: Colors.red),
                  labelText: "ادخل رقم الهوية",
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 8.0),
              child: TextFormField(
                controller: adultController,
                decoration: InputDecoration(
                  icon: Icon(Icons.person, color: Colors.red),
                  labelText: "عدد البالغين",
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 8.0),
              child: TextFormField(
                controller: childrenController,
                decoration: InputDecoration(
                  icon: Icon(Icons.person, color: Colors.red),
                  labelText: "عدد الاطفال",
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bookingFormWrapper() {
    return new Card(
      elevation: 6.0,
      margin: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 16),
      child: Column(
        children: <Widget>[
          _bookingForm(),
          SizedBox(
            height: MediaQuery.of(context).size.width / 12,
          ),
          Text(
            status,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
            ),
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
        child: _bookingFormWrapper(),
      ),
    );
  }
}
