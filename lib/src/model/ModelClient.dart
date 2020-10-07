import 'dart:convert';

class ModelClient {
  String firstName;
  String lastName;
  String gender;
  String email;
  String phone;

  ModelClient({
    this.firstName,
    this.lastName,
    this.gender,
    this.email,
    this.phone,
  });

  factory ModelClient.fromJson(Map<String, dynamic> json) {
    return ModelClient(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      gender: json['gender'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
    );
  }

  ModelClient _fromJson(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    var modelClients = new ModelClient();
    modelClients.firstName = map['first_name'];
    modelClients.lastName = map['last_name'];
    modelClients.gender = map['gender'];
    modelClients.email = map['email'];
    modelClients.phone = map['phone'];
    return modelClients;
  }

  String _toJson(ModelClient modelClients) {
    var mapData = new Map();
    mapData["first_name"] = modelClients.firstName;
    mapData["last_name"] = modelClients.lastName;
    mapData["gender"] = modelClients.gender;
    mapData["email"] = modelClients.email;
    mapData["phone"] = modelClients.phone;
    String json = jsonEncode(mapData);
    return json;
  }
}
