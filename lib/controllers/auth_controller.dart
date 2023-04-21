import 'dart:developer';

import 'package:bq_admin/components/common/toasts.dart';
import 'package:bq_admin/config/storages.dart';
import 'package:bq_admin/config/sub_urls.dart';
import 'package:bq_admin/http/http.dart';
import 'package:bq_admin/main.dart';
import 'package:bq_admin/models/response/login.dart';
import 'package:bq_admin/models/user.dart';
import 'package:bq_admin/views/auth/log_in.dart';
import 'package:bq_admin/views/home/dashboard.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool loading = false.obs;
  RxBool checkValidation = false.obs;
  RxString contact = "".obs;
  RxString password = "".obs;
  RxString name = "".obs;

  Rx<User> userInfo = User().obs;

  @override
  void onInit() {
    try {
      getUserInfoFromCache();
    } catch (e) {
      print(e.toString());
    }
    super.onInit();
  }

  logout() {
    MyApp().storage.remove(tokenPath);
    MyApp().storage.remove(userIDPath);
    MyApp().storage.remove(userNamePath);
    MyApp().storage.remove(userDataPath);
    name.value = "";
    contact.value = "";
    password.value = "";
    userInfo.value = User();

    Get.offAll(const SignIn());
  }

  getUserInfoFromCache() {
    final userName = MyApp().storage.read(userNamePath);
    name(userName);
    final rawData = MyApp().storage.read(userDataPath);
    if (rawData == "" || rawData == null) return;
    final loginResponse = loginFromJson(rawData);
    userInfo.value = loginResponse.user!;
  }

  login() async {
    try {
      if (contact.value.length < 8) {
        ToastMessages.showError("valid_number_alert".tr);
        return;
      }
      if (password.value.isEmpty) {
        ToastMessages.showError("valid_password_alert".tr);
        return;
      }
      loading(true);
      var response = await post(
          loginUrl, {"user_name": contact.value, "password": password.value});
      // inspect(response);
      if (response.statusCode == 200) {
        var jsonData = loginFromJson(response.body);
        MyApp().storage.write(tokenPath, jsonData.token);
        MyApp().storage.write(userIDPath, jsonData.user?.id.toString());
        MyApp().storage.write(userNamePath, jsonData.user?.name);
        MyApp().storage.write(userDataPath, loginToJson(jsonData));
        ToastMessages.showSuccess("LoggedInSuccessfully".tr);
        getUserInfoFromCache();

        Get.offAll(const DashboardView());
        // Get.toEnd(() => const DashboardView(title: ""));
      } else {
        ToastMessages.showError("In valid Password".tr);
      }
    } catch (e) {
      print(e.toString());
      ToastMessages.showError("Invalid password");
    } finally {
      loading(false);
    }
  }

  updateProfile({
    required String name,
    required String password,
  }) async {
    try {
      loading(true);

      var response =
          await post(updateProfileUrl, {"name": name, "password": password});
      // inspect(response);
      if (response.statusCode == 200) {
        var jsonData = loginFromJson(response.body);
        MyApp().storage.write(tokenPath, jsonData.token);
        MyApp().storage.write(userIDPath, jsonData.user?.id.toString());
        MyApp().storage.write(userNamePath, jsonData.user?.name);
        MyApp().storage.write(userDataPath, loginToJson(jsonData));
        ToastMessages.showSuccess("LoggedInSuccessfully".tr);
        getUserInfoFromCache();

        Get.offAll(const DashboardView());
        return true;
        // Get.toEnd(() => const DashboardView(title: ""));
      } else {
        ToastMessages.showError("Something went wrong");
        return false;
      }
    } catch (err) {
      return false;
    } finally {
      loading(false);
    }
  }
}
