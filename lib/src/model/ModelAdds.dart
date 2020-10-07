class AdsElement {
  int id;
  int subfieldId;
  String image;
  String title;
  String from;
  String to;
  String createdAt;
  String updatedAt;

  AdsElement({
    this.id,
    this.subfieldId,
    this.image,
    this.title,
    this.from,
    this.to,
    this.createdAt,
    this.updatedAt,
  });

  factory AdsElement.fromJson(Map<String, dynamic> json) => new AdsElement(
        id: json["id"] as int,
        subfieldId: json["subfield_id"] as int,
        image: json["image"] as String,
        title: json["title"] as String,
        from: json["from"] as String,
        to: json["to"] as String,
        createdAt: json["created_at"] as String,
        updatedAt: json["updated_at"] as String,
      );
}
