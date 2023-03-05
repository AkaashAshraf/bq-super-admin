class GeneralService {
  GeneralService({
    this.id = 0,
    this.nameEn = "",
    this.isDeleted = 0,
    this.isActive = 1,
    this.createdAt = "",
    this.updatedAt = "",
    this.nameAr = "",
    this.image = "",
  });

  int id;
  String nameEn;
  int isDeleted;
  int isActive;
  String createdAt;
  String updatedAt;
  String nameAr;
  String image;

  factory GeneralService.fromJson(Map<String, dynamic> json) => GeneralService(
        id: json["id"],
        nameEn: json["name_en"],
        isDeleted: json["isDeleted"],
        isActive: json["isActive"],
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        nameAr: json["name_ar"] ?? "",
        image: json["image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_en": nameEn,
        "isDeleted": isDeleted,
        "isActive": isActive,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "name_ar": nameAr,
        "image": image,
      };
}
