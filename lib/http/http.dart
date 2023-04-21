import 'dart:developer';

import 'package:bq_admin/config/constants.dart';
import 'package:bq_admin/config/storages.dart';
import 'package:bq_admin/controllers/auth_controller.dart';
import 'package:bq_admin/main.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<dynamic> post(String url, dynamic body) async {
  try {
    var token = MyApp().storage.read(tokenPath) ?? "";
    var userID = MyApp().storage.read(userIDPath) ?? "";
    var response = await http.post(Uri.parse(baseUrl + url), body: {
      ...body,
      "user_id": userID.toString(),
      "token": token
    }, headers: {
      "Accept": "application/json",
      // "Authorization": "Bearer $token"
    });
    inspect(response);
    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 401) {
      Get.find<AuthController>().logout();
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<dynamic> get(String url) async {
  try {
    var response = await http.get(Uri.parse(baseUrl + url), headers: {
      "Accept": "application/json",
      // "Authorization": "Bearer $token"
    });
    // print(response.body);
    // return response.statusCode;
    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 401) {
      return null;
    } else {
      return null;
    }
  } catch (e) {
    return e;
  }
}

Future<dynamic> multirequestPost(dynamic request) async {
  var token = MyApp().storage.read(tokenPath) ?? "";
  var userID = MyApp().storage.read(userIDPath) ?? "";
  try {
    request.headers['Accept'] = 'application/json';
    request.headers['Authorization'] = "Bearer $token";
    request.fields['token'] = token;
    request.fields['user_id'] = userID;

    var res = await request.send();
    return res;
  } catch (e) {
    return null;
  }
}
