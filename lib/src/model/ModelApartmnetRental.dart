class RentalApartmentElement {
  int id;
  int fieldId;
  String field;
  int cityId;
  String cityName;
  String name;
  String description;
  String addressText;
  String latitude;
  String longitude;
  List<dynamic> service;
  List<dynamic> review;
  double rating;
  String profileImg;
  int isActive;

  RentalApartmentElement({
    this.id,
    this.fieldId,
    this.field,
    this.cityId,
    this.cityName,
    this.name,
    this.description,
    this.addressText,
    this.latitude,
    this.longitude,
    this.service,
    this.review,
    this.rating,
    this.profileImg,
    this.isActive,
  });

  factory RentalApartmentElement.fromJson(Map<String, dynamic> json) =>
      new RentalApartmentElement(
        id: json["id"] as int,
        fieldId: json["field_id"] as int,
        field: json["field"] as String,
        cityId: json["city_id"] as int,
        cityName: json["city_name"] as String,
        name: json["name"],
        description: json["description"] as String,
        addressText: json["address_text"] as String,
        latitude: json["latitude"] as String,
        longitude: json["longitude"] as String,
        service: _service(json['service']),
        review: _review(json['review']),
        rating: json['rating'] as double,
        profileImg: json["profile_img"] as String,
        isActive: json["is_active"] as int,
      );

  static List<dynamic> _service(service) {
    List<dynamic> _service = new List<dynamic>.from(service);
    return _service;
  }

  static List<dynamic> _review(review) {
    List<dynamic> _review = new List<dynamic>.from(review);
    return _review;
  }
}
