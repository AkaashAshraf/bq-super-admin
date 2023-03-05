class User {
  User({
    this.id = 0,
    this.name = "",
    this.contact = "",
  });

  int id;
  String name;
  String contact;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        contact: json["contact"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "contact": contact,
      };
}
