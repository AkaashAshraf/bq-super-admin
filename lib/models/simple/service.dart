import 'package:bq_admin/models/simple/general_service.dart';

class Service {
  Service({
    this.id = 0,
    this.companyId = 0,
    this.serviceId = 0,
    this.charges = "",
    this.discount = 0,
    this.time = 0,
    this.chargesAfterDiscount = 0,
    this.discountTime = "",
    this.estimatedTime = "",
    this.descriptionEn = "",
    this.descriptionAr = "",
    this.image = "",
    this.generalService,
  });

  int? id;
  int? companyId;
  int? serviceId;
  String? charges;
  int? discount;
  int? time;
  dynamic chargesAfterDiscount;
  String? discountTime;
  dynamic estimatedTime;
  String? descriptionEn;
  String? descriptionAr;
  String? image;
  GeneralService? generalService;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"] ?? 0,
        companyId: json["company_id"] ?? 0,
        serviceId: json["service_id"] ?? 0,
        charges: json["charges"] ?? "",
        discount: json["discount"] ?? 0,
        time: json["time"] ?? 0,
        chargesAfterDiscount: json["charges_after_discount"] ?? 0,
        discountTime: json["discount_time"] ?? "",
        estimatedTime: json["estimated_time"] ?? "",
        descriptionEn: json["description_en"] ?? "",
        descriptionAr: json["description_ar"] ?? "",
        image: json["image"] ?? "",
        generalService: json["general_service"] != null
            ? GeneralService.fromJson(json["general_service"])
            : GeneralService(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "service_id": serviceId,
        "charges": charges,
        "discount": discount,
        "time": time,
        "charges_after_discount": chargesAfterDiscount,
        "discount_time": discountTime,
        "estimated_time": estimatedTime,
        "description_en": descriptionEn,
        "description_ar": descriptionAr,
        "image": image,
        "general_service": generalService,
      };
}
