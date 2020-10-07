import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wfoodalbayt/src/model/ModelBooking.dart';

String url = 'https://jsonplaceholder.typicode.com/Bookings';

Future<List<Booking>> getAllBookings() async {
  final response = await http.get(url);
  print(response.body);
  return allBookingsFromJson(response.body);
}

Future<Booking> getBooking() async {
  final response = await http.get('$url/1');
  return BookingFromJson(response.body);
}

Future<http.Response> createBooking(Booking Booking) async {
  final response = await http.post('$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: ''
      },
      body: BookingToJson(Booking));
  return response;
}
