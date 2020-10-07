//import 'dart:async';
//import 'dart:convert';
//
//import 'package:http/http.dart' as http;
//import 'package:wfoodalbayt/src/model/ModelRating.dart';
//
//class APICreateRatting {
//  Future<ModelRating> createRatting(ModelRating modelRateings) async {
//    try {
//      String json = _toJson(modelRateings);
//      final response = await http
//          .post(
//        'http://192.168.8.102:4000/api//1/reviews',
//        headers: {'Content-Type': 'application/json'},
//        body: json,
//      )
//          .then(
//        (response) {
//          print("Response status: ${response.statusCode}");
//          print("Response body: ${response.body}");
//        },
//      );
//      var c = _fromJson(response.body);
//      return c;
//    } catch (e) {
//      print('Server Exception!!!');
//      print(e);
//      return null;
//    }
//  }
//
//  ModelRating _fromJson(String json) {
//    Map<String, dynamic> map = jsonDecode(json);
//    var modelRateings = new ModelRating();
//    modelRateings.id = map['id'];
//    modelRateings.subfieldId = map['subfield_id'];
//    modelRateings.clientId = map['client_id'];
//    modelRateings.review = map['review'];
//    modelRateings.rate = map['rate'];
//    return modelRateings;
//  }
//
//  String _toJson(ModelRating modelRateings) {
//    var mapData = new Map();
//    mapData["_id"] = modelRateings.id;
//    mapData["subfield_id"] = modelRateings.subfieldId;
//    mapData["client_id"] = modelRateings.clientId;
//    mapData["review"] = modelRateings.review;
//    mapData["rate"] = modelRateings.rate;
//    String json = jsonEncode(mapData);
//    return json;
//  }
//}

//class APILoginUser {
//  Future<ModelClient> loginUser(ModelClient modelClient) async {
//    try {
//      String json = _toJson(modelClient);
//      final response = await http.post(
//        APIOP.CLIENT_LOGIN,
//        headers: {'Content-Type': 'application/json'},
//        body: _fromJson,
//      );
//      if (response != null) {
//        if (response.statusCode == APIResponseCode.SC_OK &&
//            response.body != null) {
//          Map<String, dynamic> responseJson = json.decode(response.body);
//          if (responseJson['code'] == 1) {
//            return new EventObject(
//              id: EventConstants.LOGIN_USER_SUCCESSFUL,
//              object: responseJson['details'],
//              message: 'تمت عمليه الدخول بنجاح',
//            );
//          } else {
//            return new EventObject(
//              id: EventConstants.LOGIN_USER_UN_SUCCESSFUL,
//              message: 'عفواً خطأ في كلمة المرور او إسم المستخدم!',
//            );
//          }
//        } else {
//          return new EventObject(
//            id: EventConstants.LOGIN_USER_UN_SUCCESSFUL,
//            message: 'عفواً خطأ في كلمة المرور او إسم المستخدم!',
//          );
//        }
//      } else {
//        return new EventObject();
//      }
//    } catch (Exception) {
//      return EventObject(
//        id: 0,
//        message: 'عفواً توجد مشكلة في الشبكة',
//      );
//    }
//  }
//
//  ModelClient _fromJson(String json) {
//    Map<String, dynamic> map = jsonDecode(json);
//    var modelClient = new ModelClient();
//    modelClient.firstName = map['first_name'];
//    modelClient.lastName = map['last_name'];
//    modelClient.gender = map['gender'];
//    modelClient.email = map['email'];
//    modelClient.phone = map['phone'];
//    return modelClient;
//  }
//
//  String _toJson(ModelClient modelClient) {
//    var mapData = new Map();
//    mapData["first_name"] = modelClient.firstName;
//    mapData["last_name"] = modelClient.lastName;
//    mapData["gender"] = modelClient.gender;
//    mapData["email"] = modelClient.email;
//    mapData["phone"] = modelClient.phone;
//    String json = jsonEncode(mapData);
//    return json;
//  }
//}
