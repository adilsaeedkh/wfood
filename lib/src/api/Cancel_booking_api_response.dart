import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wfoodalbayt/src/model/ModelBookingHistory.dart';

class Cancel_booking_api_response {
  static const _serviceUrl = 'http://23.111.185.155:3000/api/booking';
  static final _headers = {'Content-Type': 'application/json'};

  Future<ModelBookingHistory> cancelBooking(String post) async {
    try {
      //final response = await http.get(_serviceUrl, headers: _headers, body: json);
      final response =
          await http.get(_serviceUrl + '/' + post, headers: _headers);

      print(_serviceUrl + '/' + post);

      print(response.body.toString());

      var c = _fromJson(response.body);
      return c;
    } catch (e) {
      print('Oooops! Server Exception!!!');
      print(e);
      return null;
    }
  }

  ModelBookingHistory _fromJson(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    var post = new ModelBookingHistory();
    post.id = map['centerId'];
    return post;
  }

  String _toJson(ModelBookingHistory post) {
    var mapData = new Map();
    mapData["id"] = post.id;
    String json = jsonEncode(mapData);
    return json;
  }
}
