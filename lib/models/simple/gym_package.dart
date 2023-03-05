class GymPackage {
  GymPackage({
    this.id = 0,
    this.shopId = 0,
    this.nameEn = "",
    this.nameAr = "",
    this.image = "",
    this.price = 0,
    this.duration = "",
    this.description = "",
    this.descriptionAr = "",
    this.createdAt = "",
    this.updatedAt = "",
  });

  int? id;
  int? shopId;
  String? nameEn;
  String? nameAr;
  String? image;
  double? price;
  String? duration;
  String? description;
  String? descriptionAr;

  String? createdAt;
  String? updatedAt;

  factory GymPackage.fromJson(Map<String, dynamic> json) => GymPackage(
        id: json["id"] ?? 0,
        shopId: json["shop_id"] ?? 0,
        nameEn: json["name_en"] ?? "",
        nameAr: json["name_ar"] ?? "",
        image: json["image"] ?? "",
        price: double.tryParse(json["price"].toString()),
        duration: json["duration"] ?? "",
        description: json["description"] ?? "",
        descriptionAr: json["description_ar"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
        "name_en": nameEn,
        "name_ar": nameAr,
        "image": image,
        "price": price,
        "duration": duration,
        "description": description,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
