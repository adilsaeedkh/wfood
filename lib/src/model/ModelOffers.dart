class OffersElement {
  final int id;
  final int subfieldId;
  final String image;
  final String title;
  final int discount;
  final int afterDiscount;
  final String from;
  final String to;
  final String createdAt;
  final String updatedAt;

  OffersElement({
    this.id,
    this.subfieldId,
    this.image,
    this.title,
    this.discount,
    this.afterDiscount,
    this.from,
    this.to,
    this.createdAt,
    this.updatedAt,
  });

  factory OffersElement.fromJson(Map<String, dynamic> json) => OffersElement(
        id: json['id'] as int,
        subfieldId: json['subfield_id'] as int,
        image: json['image'] as String,
        title: json['title'] as String,
        discount: json['discount'] as int,
        afterDiscount: json['after_discount'] as int,
        from: json['from'] as String,
        to: json['to'] as String,
        createdAt: json['created_at'] as String,
        updatedAt: json['updated_at'] as String,
      );
}
