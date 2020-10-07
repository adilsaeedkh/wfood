class ModelRating {
  int id;
  String subfieldId;
  String clientId;
  String review;
  String rate;
  String createAt;

  ModelRating(
      {this.id,
      this.subfieldId,
      this.clientId,
      this.review,
      this.rate,
      this.createAt});

  factory ModelRating.fromJson(Map<String, dynamic> json) {
    return ModelRating(
      id: json['_id'] as int,
      subfieldId: json['subfield_id'] as String,
      clientId: json['client_id'] as String,
      review: json['review'] as String,
      rate: json['rate'] as String,
      createAt: json['create_at'] as String,
    );
  }
}
