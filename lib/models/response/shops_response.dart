// To parse this JSON data, do
//
//     final shopsResponse = shopsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:bq_admin/models/simple/shop.dart';

ShopsResponse shopsResponseFromJson(String str) =>
    ShopsResponse.fromJson(json.decode(str));

String shopsResponseToJson(ShopsResponse data) => json.encode(data.toJson());

class ShopsResponse {
  ShopsResponse({
    this.status,
    this.message,
    this.total,
    this.data,
  });

  int? status;
  String? message;
  int? total;
  List<Shop>? data;

  factory ShopsResponse.fromJson(Map<String, dynamic> json) => ShopsResponse(
        status: json["status"],
        message: json["message"],
        total: json["total"],
        data: json["data"] == null
            ? []
            : List<Shop>.from(json["data"]!.map((x) => Shop.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "total": total,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
