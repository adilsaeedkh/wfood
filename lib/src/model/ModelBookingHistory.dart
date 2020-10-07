class ModelBookingHistory {
  String id;
  String service_type;
  String service_type_id;
  int subfield_id;
  int client_id;
  String client_name;
  String booking_date;

  ModelBookingHistory({
    this.id,
    this.service_type,
    this.service_type_id,
    this.subfield_id,
    this.client_id,
    this.client_name,
    this.booking_date,
  });

  factory ModelBookingHistory.fromJson(Map<String, dynamic> json) {
    return ModelBookingHistory(
      id: json['id'] as String,
      service_type: json['service_type'] as String,
      service_type_id: json['service_type_id'] as String,
      subfield_id: json['subfield_id'] as int,
      client_id: json['client_id'] as int,
      client_name: json['client_name'] as String,
      booking_date: json['booking_date'] as String,
    );
  }
}
