import 'package:bq_admin/components/common/app_bar.dart';
import 'package:bq_admin/config/colors.dart';
import 'package:bq_admin/config/text_sizes.dart';
import 'package:bq_admin/models/simple/shop.dart';
import 'package:bq_admin/views/home/shops/add_update_shop.dart';
import 'package:bq_admin/views/home/shops/shop_list_view.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopTabs extends StatefulWidget {
  const ShopTabs({Key? key}) : super(key: key);
  @override
  State<ShopTabs> createState() => _ShopTabs();
}

class _ShopTabs extends State<ShopTabs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: appBar(
            title: "Beauty Shops",
            rightIcon: GestureDetector(
              onTap: () {
                Get.to(AddUpdateShop(
                  shop: Shop(),
                ));
              },
              child: const IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: null,
              ),
            )),
        body: SafeArea(
            child: DefaultTabController(
          initialIndex: 0,
          length: 3,
          child: Column(
            children: [
              Container(
                height: screenHeight(context) * 0.07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: bgColor,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Column(
                    children: [
                      ButtonsTabBar(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 30),
                        elevation: 3,
                        labelStyle: const TextStyle(
                            fontFamily: "primary", color: Colors.white),
                        unselectedLabelStyle: const TextStyle(
                            fontFamily: "primary", color: Colors.black),
                        backgroundColor: primaryColor,
                        unselectedBackgroundColor: Colors.white,
                        tabs: const [
                          Tab(
                            text: "All",
                          ),
                          Tab(
                            text: "Active",
                          ),
                          Tab(
                            text: "Deactive",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(
                child: TabBarView(children: [
                  ShopListView(
                    type: "all",
                  ),
                  ShopListView(
                    type: "active",
                  ),
                  ShopListView(
                    type: "deactive",
                  ),
                ]),
              ),
            ],
          ),
        )));
  }
}
