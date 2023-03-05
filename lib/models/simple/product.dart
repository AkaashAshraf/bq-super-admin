import 'package:bq_admin/models/simple/brand.dart';

class Product {
  Product({
    this.id = 0,
    this.shopId = 0,
    this.brandId = 0,
    this.image1 = '',
    this.image2 = "",
    this.image3 = "",
    this.price = 0,
    this.status = 0,
    this.nameEn = "",
    this.nameAr = "",
    this.createdAt = "",
    this.updatedAt = "",
    this.brand,
  });

  int? id;
  int? shopId;
  int? brandId;
  String? image1;
  String? image2;
  String? image3;
  double? price;
  int? status;
  String? nameEn;
  String? nameAr;
  String? createdAt;
  String? updatedAt;
  Brand? brand;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] ?? 0,
        shopId: json["shop_id"] ?? 0,
        brandId: json["brand_id"] ?? 0,
        image1: json["image_1"] ?? "",
        image2: json["image_2"] ?? "",
        image3: json["image_3"] ?? "",
        price: double.tryParse(json["price"].toString()),
        status: json["status"] ?? 0,
        nameEn: json["name_en"] ?? "",
        nameAr: json["name_ar"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        brand: json["brand"] != null ? Brand.fromJson(json["brand"]) : Brand(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
        "brand_id": brandId,
        "image_1": image1,
        "image_2": image2,
        "image_3": image3,
        "price": price,
        "status": status,
        "name_en": nameEn,
        "name_ar": nameAr,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "brand": brand,
      };
}
