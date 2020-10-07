class Post {
  String centerId;
  String patientId;
  String comment;
  String rate;

  Post({this.centerId, this.patientId, this.comment, this.rate});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      centerId: json['centerId'],
      patientId: json['patientId'],
      comment: json['comment'],
      rate: json['rate'],
    );
  }
}
