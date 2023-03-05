// To parse this JSON data, do
//
//     final genralServices = genralServicesFromJson(jsonString);

import 'dart:convert';

import 'package:bq_admin/models/simple/general_service.dart';

GenralServices genralServicesFromJson(String str) =>
    GenralServices.fromJson(json.decode(str));

String genralServicesToJson(GenralServices data) => json.encode(data.toJson());

class GenralServices {
  GenralServices({
    this.status = 0,
    this.message = "",
    this.total = 0,
    this.data,
  });

  int status;
  String message;
  int total;
  List<GeneralService>? data;

  factory GenralServices.fromJson(Map<String, dynamic> json) => GenralServices(
        status: json["status"] ?? 0,
        message: json["message"] ?? "",
        total: json["total"] ?? 0,
        data: json["data"] == null
            ? []
            : List<GeneralService>.from(
                json["data"]!.map((x) => GeneralService.fromJson(x))),
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
