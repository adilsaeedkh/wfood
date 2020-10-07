import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wfoodalbayt/static/APIConstants.dart';

import '../models/EventObject.dart';
import 'constants.dart';

Future<EventObject> loginUser(
  String emailId,
  String password,
) async {
  try {
    final String jsonData = _toParseToJson(emailId, password);
    final response = await http.post(
      APIOP.CLIENT_LOGIN,
      headers: {'Content-Type': 'application/json'},
      body: jsonData,
    );
    if (response != null) {
      if (response.statusCode == APIResponseCode.SC_OK &&
          response.body != null) {
        Map<String, dynamic> responseJson = json.decode(response.body);
        if (responseJson['code'] == 1) {
          return new EventObject(
            id: EventConstants.LOGIN_USER_SUCCESSFUL,
            object: responseJson['details'],
            message: 'تمت عمليه الدخول بنجاح',
          );
        } else {
          return new EventObject(
            id: EventConstants.LOGIN_USER_UN_SUCCESSFUL,
            message: 'عفواً خطأ في كلمة المرور او إسم المستخدم!',
          );
        }
      } else {
        return new EventObject(
          id: EventConstants.LOGIN_USER_UN_SUCCESSFUL,
          message: 'عفواً خطأ في كلمة المرور او إسم المستخدم!',
        );
      }
    } else {
      return new EventObject();
    }
  } catch (Exception) {
    return EventObject(
      id: 0,
      message: 'عفواً توجد مشكلة في الشبكة',
    );
  }
}

String _toParseToJson(String emailId, String password) {
  var mapData = new Map();
  mapData["user_name"] = emailId;
  mapData["password"] = password;
  String json = jsonEncode(mapData);

  return json;
}

String _toJson(String firstName, String lastName, String gender, String phone,
    String email, String password) {
  var mapData = new Map();
  mapData["first_name"] = firstName;
  mapData["last_name"] = lastName;
  mapData["gender"] = gender;
  mapData["email"] = email;
  mapData["phone"] = phone;
  String json = jsonEncode(mapData);

  return json;
}

String _bookingToJson(String centerId, String departmentId, String patientId,
    String insuranceId, String bookingDateTime) {
  var mapData = new Map();
  mapData["department"] = departmentId;
  mapData["hospital"] = centerId;
  mapData["committee"] = insuranceId;
  mapData["patient"] = patientId;
  mapData["publishedDate"] = bookingDateTime;

  String json = jsonEncode(mapData);

  return json;
}

Future<EventObject> registerUser(
    String firstName,
    String lastName,
    String gender,
    String phone,
    String email,
    String password,
    String birthDate) async {
  const _serviceUrl = 'http://23.111.185.155:3000/api/client/register';

  final _headers = {'Content-Type': 'application/json'};

  try {
    final response = await http.post(_serviceUrl,
        headers: _headers,
        body: _toJson(
          firstName,
          lastName,
          gender,
          phone,
          email,
          password,
        ));

    if (response != null) {
      if (response.statusCode == APIResponseCode.SC_OK &&
          response.body != null) {
        Map<String, dynamic> responseJson = json.decode(response.body);

        if (responseJson['code'] == 1) {
          return new EventObject(
              id: EventConstants.LOGIN_USER_SUCCESSFUL,
              object: responseJson,
              message: 'تمت عمليه التسجيل بنجاح');
        } else {
          return new EventObject(
              id: EventConstants.LOGIN_USER_UN_SUCCESSFUL,
              message: 'عفواً خطأ في كلمة المدخلات');
        }
      } else {
        return new EventObject(
            id: EventConstants.LOGIN_USER_UN_SUCCESSFUL,
            message: 'عفواً خطأ في المدخلات ');
      }
    } else {
      return new EventObject();
    }
  } catch (Exception) {
    return EventObject(id: 0);
  }
}

Future<EventObject> changePassword(
    String emailId, String oldPassword, String newPassword) async {
  try {
    final encoding = APIConstants.OCTET_STREAM_ENCODING;
    final response = await http.post(
        'http://23.111.185.155:3000/api/auth/reset_password',
        body: _changePasswordToJson(emailId, oldPassword, newPassword),
        encoding: Encoding.getByName(encoding));

    if (response != null) {
      if (response.statusCode == APIResponseCode.SC_OK &&
          response.body != null) {
        Map<String, dynamic> responseJson = json.decode(response.body);

        if (responseJson['code'] == 1) {
          return new EventObject(
              id: EventConstants.LOGIN_USER_SUCCESSFUL,
              object: responseJson,
              message: 'تمت عمليه الدخول بنجاح');
        } else if (responseJson['code'] == 2) {
          return new EventObject(
              id: 2,
              message: 'عفواً خطأ في كلمة المرور او إسم المستخدم!',
              object: responseJson);
        } else {
          return new EventObject(
              id: 3, message: 'عفواً خطأ جانب المخدم!', object: responseJson);
        }
      } else {
        return new EventObject(
            id: EventConstants.LOGIN_USER_UN_SUCCESSFUL,
            message: 'عفواً خطأ في كلمة المرور او إسم المستخدم!');
      }
    } else {
      return new EventObject();
    }
  } catch (Exception) {
    return EventObject();
  }
}

String _changePasswordToJson(
    String emailId, String oldPassword, String newPassword) {
  var mapData = new Map();

  mapData["email"] = emailId;
  mapData["password"] = oldPassword;
  mapData["newPassword"] = newPassword;

  String json = jsonEncode(mapData);

  return json;
}

String _upDateToJson(
    String firstName, String lastName, String phone, String email) {
  var mapData = new Map();

  mapData["name.first"] = firstName;
  mapData["name.last"] = lastName;
  mapData["phone"] = phone;
  mapData["email"] = email;

  String json = jsonEncode(mapData);

  return json;
}

Future<EventObject> patientAppointment(String centerId, String departmentId,
    String patientId, String insuranceId, String bookingDateTime) async {
  const _serviceUrl = 'http://23.111.185.155:3000/api/booking';

  final _headers = {'Content-Type': 'application/json'};

  try {
    final response = await http.post(_serviceUrl,
        headers: _headers,
        body: _bookingToJson(
            centerId, departmentId, patientId, insuranceId, bookingDateTime));

    if (response != null) {
      if (response.statusCode == APIResponseCode.SC_OK &&
          response.body != null) {
        Map<String, dynamic> responseJson = json.decode(response.body);

        if (responseJson['code'] == 1) {
          return new EventObject(
              id: EventConstants.LOGIN_USER_SUCCESSFUL,
              object: responseJson,
              message: 'تمت عمليه الحجز بنجاح');
        } else {
          return new EventObject(
              id: EventConstants.LOGIN_USER_UN_SUCCESSFUL,
              message: 'عفواً خطأ في كلمة المدخلات');
        }
      } else {
        return new EventObject(
            id: EventConstants.LOGIN_USER_UN_SUCCESSFUL,
            message: 'عفواً خطأ في المدخلات ');
      }
    } else {
      return new EventObject();
    }
  } catch (Exception) {
    return EventObject(id: 0);
  }
}

Future<EventObject> updateUserInfo(String firstName, String lastName,
    String phone, String email, String userId) async {
  String id = '';
  if (userId != null) {
    id = userId;
  }

  final _headers = {'Content-Type': 'application/json'};

  try {
    final response = await http.put(
        'http://23.111.185.155:3000/api/client/' + id + '/update',
        headers: _headers,
        body: _upDateToJson(firstName, lastName, phone, email));
    print(response.body.toString());

    if (response != null) {
      if (response.statusCode == APIResponseCode.SC_OK &&
          response.body != null) {
        Map<String, dynamic> responseJson = json.decode(response.body);

        if (responseJson['code'] == 1) {
          return new EventObject(
              id: EventConstants.LOGIN_USER_SUCCESSFUL,
              object: responseJson,
              message: 'تمت عمليه التسجيل بنجاح');
        } else {
          return new EventObject(
              id: EventConstants.LOGIN_USER_UN_SUCCESSFUL,
              message: 'عفواً خطأ في كلمة المدخلات');
        }
      } else {
        return new EventObject(
            id: EventConstants.LOGIN_USER_UN_SUCCESSFUL,
            message: 'عفواً خطأ في المدخلات ');
      }
    } else {
      return new EventObject();
    }
  } catch (Exception) {
    return EventObject(id: 0);
  }
}
