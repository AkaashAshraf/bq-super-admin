// To parse this JSON data, do
//
//     final employeesResponse = employeesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:bq_admin/models/simple/employee.dart';

EmployeesResponse employeesResponseFromJson(String str) =>
    EmployeesResponse.fromJson(json.decode(str));

String employeesResponseToJson(EmployeesResponse data) =>
    json.encode(data.toJson());

class EmployeesResponse {
  EmployeesResponse({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  List<Employee>? data;

  factory EmployeesResponse.fromJson(Map<String, dynamic> json) =>
      EmployeesResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Employee>.from(
                json["data"]!.map((x) => Employee.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
