// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

import 'package:bq_admin/models/user.dart';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    this.status = 0,
    this.message = "",
    this.user,
    this.token = "",
  });

  int status;
  String message;
  User? user;
  String token;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        status: json["status"] ?? 0,
        message: json["message"] ?? "",
        user: json["data"] == null ? null : User.fromJson(json["data"]),
        token: json["token"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": user?.toJson(),
        "token": token,
      };
}
