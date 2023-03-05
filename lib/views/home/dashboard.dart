import 'package:bq_admin/components/common/app_bar.dart';
import 'package:bq_admin/components/common/buttons.dart';
import 'package:bq_admin/components/common/drawer.dart';
import 'package:bq_admin/components/common/generic_popup.dart';
import 'package:bq_admin/components/items.dart/dashboard_item.dart';
import 'package:bq_admin/config/colors.dart';
import 'package:bq_admin/config/constants.dart';
import 'package:bq_admin/controllers/constants_controller.dart';
import 'package:bq_admin/controllers/general_services_controller.dart';
import 'package:bq_admin/controllers/gym_controller.dart';
import 'package:bq_admin/controllers/helper_controller.dart';
import 'package:bq_admin/controllers/saloons_controller.dart';
import 'package:bq_admin/controllers/shops_controller.dart';
import 'package:bq_admin/controllers/spa_controller.dart';
import 'package:bq_admin/views/home/genralServices/general_services_list_list.dart';
import 'package:bq_admin/views/home/gyms/gym_tabs.dart';
import 'package:bq_admin/views/home/saloons/saloon_tabs.dart';
import 'package:bq_admin/views/home/shops/shop_tabs.dart';
import 'package:bq_admin/views/home/spa/spa_tabs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardView();
}

class _DashboardView extends State<DashboardView> {
  GeneralServicesController generalServicesController =
      Get.put(GeneralServicesController());
  SaloonsController saloonsController = Get.put(SaloonsController());
  SpaController spaController = Get.put(SpaController());

  ConstantsController constantsController = Get.put(ConstantsController());
  ShopsController shopsController = Get.put(ShopsController());
  GymController gymController = Get.put(GymController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Dashboard"),
      // ),
      drawer: const MenuDrawer(),
      appBar: noAppBar(showCart: false),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [primaryColor, secandaryColor],
          )),
          height: height,
          width: width,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 0.0, bottom: 10, left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Beauty Queens".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: dashbboardTitleColor,
                            fontFamily: "primary",
                            fontSize: width * 0.07),
                      ).animate().scale(delay: 200.ms, duration: 400.ms),
                      SizedBox(
                        height: height * 0.1,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              dashboardItem(height, width,
                                  imgName: "services.png",
                                  title: "General Services", onTap: () {
                                Get.to(const GeneralServiceList());
                              }),
                              dashboardItem(height, width,
                                  imgName: "new_salons.jpeg",
                                  title: "Saloons".tr, onTap: () {
                                Get.to(const SaloonsTabs());
                              }),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              dashboardItem(height, width,
                                  imgName: "spa.jpeg",
                                  title: "SPA".tr, onTap: () {
                                // Get.put(ShopsController()).fetchShopsList();

                                Get.to(const SpaTabs());
                              }),
                              dashboardItem(height, width,
                                  imgName: "ladies_gym.jpeg",
                                  title: "Gym".tr, onTap: () {
                                Get.to(const GymTabs());
                              }),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              dashboardItem(height, width,
                                  imgName: "shops.jpeg",
                                  title: "Beauty Shops".tr, onTap: () {
                                // Get.put(ShopsController()).fetchShopsList();

                                Get.to(const ShopTabs());
                              }),
                              dashboardItem(height, width,
                                  imgName: "offerss.jpeg",
                                  title: "Offers".tr, onTap: () {
                                // Get.to(const OffersView());
                              }),
                              if (false)
                                dashboardItem(height, width,
                                    imgName: "spa.jpeg",
                                    title: "SPA".tr, onTap: () {
                                  genericPopup(context,
                                      title: "JoinUs".tr,
                                      children: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            width: width * 0.5,
                                            child: iconButton(
                                              onClick: () {
                                                Get.put(HelperController()).openUrl(
                                                    url:
                                                        "tel:$contactSuppportCallNumber");
                                                Navigator.pop(context);
                                              },
                                              text: "Call".tr,
                                              icon: const Icon(
                                                Icons.phone,
                                                size: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: width * 0.5,
                                            child: iconButton(
                                              onClick: () {
                                                Get.put(HelperController()).openUrl(
                                                    url:
                                                        "whatsapp://send?phone=$contactSuppportWhatsAppNumber&text=");
                                                Navigator.pop(context);
                                              },
                                              text: "Whatsapp".tr,
                                              icon: const Icon(
                                                Icons.whatsapp,
                                                size: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: width * 0.5,
                                            child: iconButton(
                                              onClick: () {
                                                Get.put(HelperController()).openUrl(
                                                    url:
                                                        "mailto:$contactSuppportEmail");
                                                Navigator.pop(context);
                                              },
                                              text: "Email".tr,
                                              icon: const Icon(
                                                Icons.email,
                                                size: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )).show();
                                }),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
