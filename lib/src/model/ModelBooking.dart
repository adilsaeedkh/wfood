// Created using https://app.quicktype.io/

// To parse this JSON data, do
//
//     final Booking = BookingFromJson(jsonString);

import 'dart:convert';

Booking BookingFromJson(String str) {
  final jsonData = json.decode(str);
  return Booking.fromJson(jsonData);
}

String BookingToJson(Booking data) {
  final gson = data.toJson();
  return json.encode(gson);
}

List<Booking> allBookingsFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Booking>.from(jsonData.map((x) => Booking.fromJson(x)));
}

String allBookingsToJson(List<Booking> data) {
  final gson = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(gson);
}

class Booking {
  int patienId;
  int centerId;
  String departmetId;
  String date;
  String time;

  Booking({
    this.patienId,
    this.centerId,
    this.departmetId,
    this.date,
    this.time,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => new Booking(
        patienId: json["patienId"],
        centerId: json["centerId"],
        departmetId: json["departmetId"],
        date: json["date"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "patienId": patienId,
        "centerId": centerId,
        "departmetId": departmetId,
        "date": date,
        "time": time,
      };
}
