import 'dart:io';

import 'package:bq_admin/components/common/app_bar.dart';
import 'package:bq_admin/components/common/buttons.dart';
import 'package:bq_admin/components/common/loading_indicator.dart';
import 'package:bq_admin/components/common/textInputs/text_input.dart';
import 'package:bq_admin/components/common/toasts.dart';
import 'package:bq_admin/config/colors.dart';
import 'package:bq_admin/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  AuthController authController = Get.find<AuthController>();
  bool isValidate = false;
  String contact = "";
  String name = "";
  String password = "";
  String confirmPassword = "";

  @override
  void initState() {
    setState(() {
      contact = authController.userInfo.value.contact;
      name = authController.userInfo.value.name;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar(title: "Profile".tr, showCart: false),
      body: SafeArea(
        child: Container(
          height: height,
          color: Colors.white,
          child: GetX<AuthController>(builder: (controller) {
            return SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      textInputCustom(
                          label: "Name",
                          initialValue: name,
                          preIcon: const Icon(
                            Icons.verified_user,
                            size: 20,
                            color: textInputIconColor,
                          ),
                          onTextChange: (val) {
                            setState(() {
                              name = val;
                            });
                          }),
                      const SizedBox(
                        height: 30,
                      ),
                      textInputCustom(
                          label: "Password",
                          initialValue: password,
                          obscureText: true,
                          preIcon: const Icon(
                            Icons.password,
                            size: 20,
                            color: textInputIconColor,
                          ),
                          onTextChange: (val) {
                            setState(() {
                              password = val;
                            });
                          }),
                      const SizedBox(
                        height: 30,
                      ),
                      textInputCustom(
                          label: "Confirm Password",
                          initialValue: confirmPassword,
                          obscureText: true,
                          preIcon: const Icon(
                            Icons.password,
                            size: 20,
                            color: textInputIconColor,
                          ),
                          onTextChange: (val) {
                            setState(() {
                              confirmPassword = val;
                            });
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(height: 10),
                      controller.loading.value
                          ? const BQLoaing(
                              height: 25,
                              width: 25,
                            )
                          : iconButton(
                              onClick: () {
                                if (name.isEmpty) {
                                  Get.back();
                                }
                                if (password.isNotEmpty &&
                                    password != confirmPassword) {
                                  ToastMessages.showError("Password mismatch");
                                  return;
                                }
                                var res = controller.updateProfile(
                                    name: name, password: password);
                                if (res) {
                                  // ToastMessages.showSuccess("Profile Updated");
                                  Get.back();
                                }
                                // Navigator.pop(context);
                              },
                              text: "Update".tr,
                            ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget imageViewer(XFile image, dynamic onTap) {
    return SizedBox(
        height: 150,
        width: 90,
        child: Row(
          children: [
            SizedBox(
              height: 150,
              width: 25,
              child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    onTap();
                  },
                  child: Image.asset(
                    'assets/images/cross.png',
                    height: 17,
                    width: 17,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Image.file(
                File(image.path),
                fit: BoxFit.contain,
              ),
            ),
          ],
        ));
  }
}
