import 'package:bq_admin/models/simple/city.dart';
import 'package:bq_admin/models/simple/gym_package.dart';
import 'package:bq_admin/models/simple/product.dart';

class Shop {
  Shop({
    this.id = 0,
    this.nameEn = "",
    this.nameAr = "",
    this.city,
    this.image1 = "",
    this.image2 = 0,
    this.image3 = "",
    this.contact = "",
    this.type = 0,
    this.status = 0,
    this.createdBy = 0,
    this.b1 = "",
    this.b2 = "",
    this.b3 = "",
    this.b4 = "",
    this.b5 = "",
    this.b6 = "",
    this.b7 = "",
    this.b8 = "",
    this.b9 = "",
    this.b10 = "",
    this.createdAt = "",
    this.updatedAt = "",
    this.cityEn = "",
    this.cityAr = "",
    this.latitude,
    this.longitude,
    this.description,
    this.products,
    this.gymPackages,
  });

  int? id;
  String? nameEn;
  String? nameAr;
  City? city;
  String? image1;
  int? image2;
  dynamic image3;
  String? contact;
  int? type;
  int? status;
  int? createdBy;
  String? b1;
  String? b2;
  String? b3;
  String? b4;
  String? b5;
  String? b6;
  String? b7;
  String? b8;
  String? b9;
  String? b10;
  String? description;

  String? createdAt;
  String? updatedAt;
  String? cityEn;
  String? cityAr;

  dynamic latitude;
  dynamic longitude;
  List<Product>? products;
  List<GymPackage>? gymPackages;

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"] ?? 0,
        nameEn: json["name_en"] ?? "",
        nameAr: json["name_ar"] ?? "",
        city: json["city"] == null ? null : City.fromJson(json["city"]),
        image1: json["image_1"] ?? "",
        image2: json["image_2"] ?? 0,
        image3: json["image_3"] ?? "",
        contact: json["contact"] ?? "",
        type: json["type"] ?? 0,
        status: json["status"] ?? 0,
        createdBy: json["created_by"] ?? 0,
        b1: json["b1"] ?? "",
        b2: json["b2"] ?? "",
        b3: json["b3"] ?? "",
        b4: json["b4"] ?? "",
        b5: json["b5"] ?? "",
        b6: json["b6"] ?? "",
        b7: json["b7"] ?? "",
        b8: json["b8"] ?? "",
        b9: json["b9"] ?? "",
        description: json["description"] ?? "",
        b10: json["b10"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        cityEn: json["city_en"] ?? "",
        cityAr: json["city_ar"] ?? "",
        latitude: json["latitude"],
        longitude: json["longitude"],
        products: json["products"] == null
            ? []
            : json["products"] == null
                ? []
                : List<Product>.from(
                    json["products"]!.map((x) => Product.fromJson(x))),
        gymPackages: json["gym_packages"] == null
            ? []
            : json["gym_packages"] == null
                ? []
                : List<GymPackage>.from(
                    json["gym_packages"]!.map((x) => GymPackage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_en": nameEn,
        "name_ar": nameAr,
        "city": city?.toJson(),
        "image_1": image1,
        "image_2": image2,
        "image_3": image3,
        "contact": contact,
        "type": type,
        "status": status,
        "created_by": createdBy,
        "b1": b1,
        "b2": b2,
        "b3": b3,
        "b4": b4,
        "b5": b5,
        "b6": b6,
        "b7": b7,
        "b8": b8,
        "b9": b9,
        "b10": b10,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "city_en": cityEn,
        "city_ar": cityAr,
        "latitude": latitude,
        "longitude": longitude,
        "products": products == null
            ? []
            : products == null
                ? []
                : List<dynamic>.from(products!.map((x) => x.toJson())),
        "gym_packages": gymPackages == null
            ? []
            : gymPackages == null
                ? []
                : List<dynamic>.from(gymPackages!.map((x) => x.toJson())),
      };
}
