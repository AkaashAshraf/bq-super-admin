import 'dart:io';

import 'package:bq_admin/components/common/text_alert.dart';
import 'package:bq_admin/config/colors.dart';
import 'package:bq_admin/config/storages.dart';
import 'package:bq_admin/config/text_sizes.dart';
import 'package:bq_admin/controllers/auth_controller.dart';
import 'package:bq_admin/main.dart';
import 'package:bq_admin/views/profile/my_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:restart_app/restart_app.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Drawer(
        child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              Image(
                  height: height * 0.125,
                  fit: BoxFit.contain,
                  // opacity: AlwaysStoppedAnimation<double>(0.4),
                  image: const AssetImage(
                    'assets/images/logo.jpeg',
                  )),
              SizedBox(
                  width: width * 0.8,
                  child: Text(
                    authController.name.value,
                    style: TextStyle(
                        color: primaryColor,
                        fontFamily: "primary",
                        fontWeight: FontWeight.w700,
                        fontSize: screenWidth(context) * 0.05),
                  )),
            ],
          ),
        ),
        // drawerItem(context,
        //     icon: const Icon(
        //       Icons.supervised_user_circle_outlined,
        //       size: 25,
        //       color: textInputIconColor,
        //     ), onPress: () {
        //   // Get.to(const Profile());
        // }, title: "Profile".tr),
        drawerItem(context,
            icon: const Icon(
              Icons.verified_user,
              size: 25,
              color: textInputIconColor,
            ), onPress: () {
          Get.to(const Profile());
        }, title: "Profile".tr),
        // drawerItem(context,
        //     icon: const Icon(
        //       Icons.notifications,
        //       size: 25,
        //       color: textInputIconColor,
        //     ), onPress: () {
        //   // Get.to(const NotificationsList());
        // }, title: "Notifications".tr),
        // if (false)
        // ListTile(
        //   leading: const Icon(
        //     Icons.password,
        //     size: 25,
        //     color: textInputIconColor,
        //   ),
        //   title: Text('ChangePassword'.tr),
        //   onTap: () {
        //     // Update the state of the app.
        //     // ...
        //   },
        // ),
        drawerItem(context,
            icon: const Icon(
              Icons.logout,
              size: 25,
              color: textInputIconColor,
            ), onPress: () {
          textAlert(context,
              title: "logout_alert".tr,
              buttons: DialogButton(
                  onPressed: (() {
                    Get.put(AuthController()).logout();
                  }),
                  child: Text(
                    "Yes".tr,
                    style: const TextStyle(color: Colors.white),
                  ))).show();
        }, title: "Logout".tr),
        // drawerItem(context,
        //     icon: const Icon(
        //       Icons.delete,
        //       size: 25,
        //       color: textInputIconColor,
        //     ), onPress: () {
        //   textAlert(context,
        //       title: "delete_alert".tr,
        //       buttons: DialogButton(
        //           onPressed: (() {}),
        //           child: Text(
        //             "Yes".tr,
        //             style: const TextStyle(color: Colors.white),
        //           ))).show();
        // }, title: "DeleteAccount".tr),

        // drawerItem(context,
        //     icon: const Icon(
        //       Icons.language,
        //       size: 25,
        //       color: textInputIconColor,
        //     ), onPress: () {
        //   textAlert(context,
        //       title: "language_alert".tr,
        //       buttons: DialogButton(
        //           onPressed: (() {
        //             MyApp().storage.write(localizationPath,
        //                 Get.locale.toString() == "en" ? "ar" : "en");
        //             if (Platform.isAndroid) {
        //               Restart.restartApp();
        //             } else {
        //               Phoenix.rebirth(context);

        //               Navigator.pop(context);
        //             }
        //             // Phoenix.rebirth(context);
        //           }),
        //           child: Text(
        //             "Yes".tr,
        //             style: const TextStyle(color: Colors.white),
        //           ))).show();
        // }, title: "ChangeLanguage".tr),
      ],
    ));
  }

  ListTile drawerItem(BuildContext context,
      {required dynamic onPress, required String title, required Widget icon}) {
    return ListTile(
        leading: icon,
        title: Text(
          title,
          style: TextStyle(
              fontFamily: "primary",
              fontWeight: FontWeight.w600,
              fontSize: Get.locale.toString() == "en"
                  ? screenWidth(context) * 0.045
                  : screenWidth(context) * 0.04),
        ),
        onTap: onPress);
  }
}
