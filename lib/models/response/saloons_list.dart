// To parse this JSON data, do
//
//     final saloons = saloonsFromJson(jsonString);

import 'dart:convert';

import 'package:bq_admin/models/simple/saloon.dart';

Saloons saloonsFromJson(String str) => Saloons.fromJson(json.decode(str));

String saloonsToJson(Saloons data) => json.encode(data.toJson());

class Saloons {
  Saloons({
    this.status,
    this.message,
    this.total,
    this.data,
  });

  int? status;
  String? message;
  int? total;
  List<Saloon>? data;

  factory Saloons.fromJson(Map<String, dynamic> json) => Saloons(
        status: json["status"],
        message: json["message"],
        total: json["total"],
        data: json["data"] == null
            ? []
            : List<Saloon>.from(json["data"]!.map((x) => Saloon.fromJson(x))),
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
