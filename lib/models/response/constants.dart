// To parse this JSON data, do
//
//     final constants = constantsFromJson(jsonString);

import 'dart:convert';

import 'package:bq_admin/models/simple/city.dart';

Constants constantsFromJson(String str) => Constants.fromJson(json.decode(str));

String constantsToJson(Constants data) => json.encode(data.toJson());

class Constants {
  Constants({
    this.cities,
  });

  List<City>? cities;

  factory Constants.fromJson(Map<String, dynamic> json) => Constants(
        cities: json["cities"] == null
            ? []
            : List<City>.from(json["cities"]!.map((x) => City.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cities": cities == null
            ? []
            : List<dynamic>.from(cities!.map((x) => x.toJson())),
      };
}
