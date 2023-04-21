import 'package:bq_admin/components/common/loading_indicator.dart';
import 'package:bq_admin/components/common/no_data_widget.dart';
import 'package:bq_admin/controllers/shops_controller.dart';
import 'package:bq_admin/controllers/spa_controller.dart';
import 'package:bq_admin/models/simple/shop.dart';
import 'package:bq_admin/views/home/shops/shop_details_view.dart';
import 'package:bq_admin/views/home/shops/shop_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ShopListView extends StatefulWidget {
  const ShopListView({Key? key, required this.type}) : super(key: key);
  final String type;
  @override
  State<ShopListView> createState() => _ShopListView();
}

class _ShopListView extends State<ShopListView> {
  SpaController controller = Get.find<SpaController>();
  @override
  void initState() {
    super.initState();
  }

  Shop getListIndex(ShopsController controller, int index) {
    Shop saloon = Shop();
    switch (widget.type) {
      case "all":
        saloon = controller.allList[index];
        break;
      case "active":
        saloon = controller.activeList[index];
        break;
      case "deactive":
        saloon = controller.deactiveList[index];
        break;
      default:
        saloon = controller.allList[index];
    }
    return saloon;
  }

  int getListLength(ShopsController controller) {
    int length = 0;
    switch (widget.type) {
      case "all":
        length = controller.allList.length;
        break;
      case "active":
        length = controller.activeList.length;
        break;
      case "deactive":
        length = controller.deactiveList.length;
        break;
      default:
        length = controller.allList.length;
    }
    return length;
  }

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: GetX<ShopsController>(builder: (controller) {
      return SizedBox(
        child: getListLength(controller) == 0 && controller.loading.value
            ? const Center(child: BQLoaing())
            : getListLength(controller) == 0 && !controller.loading.value
                ? const NoDataWidget(text: "No Shop Available")
                : SmartRefresher(
                    controller: refreshController,
                    enablePullDown: true,
                    enablePullUp: false,
                    onRefresh: () async {
                      await controller.fetchShops(type: widget.type);

                      refreshController.refreshCompleted();
                    },
                    header: const WaterDropHeader(),
                    child: ListView.builder(
                        itemCount: getListLength(controller),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: const EdgeInsets.only(
                                  top: 2.0, left: 5, right: 5),
                              child: SizedBox(
                                child: shopItem(
                                  100,
                                  context,
                                  item: getListIndex(controller, index),
                                  onPress: (item) {
                                    Get.to(ShopDetailView(item: item));
                                  },
                                ),
                              ));
                        }),
                  ),
      );
    }));
  }
}
