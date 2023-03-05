import 'package:bq_admin/components/common/loading_indicator.dart';
import 'package:bq_admin/components/common/no_data_widget.dart';
import 'package:bq_admin/controllers/saloons_controller.dart';
import 'package:bq_admin/models/simple/saloon.dart';
import 'package:bq_admin/views/home/saloons/saloon_details_view.dart';
import 'package:bq_admin/views/home/saloons/saloon_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaloonListView extends StatefulWidget {
  const SaloonListView({Key? key, required this.type}) : super(key: key);
  final String type;
  @override
  State<SaloonListView> createState() => _SaloonListView();
}

class _SaloonListView extends State<SaloonListView> {
  SaloonsController saloonsController = Get.find<SaloonsController>();
  @override
  void initState() {
    super.initState();
  }

  Saloon getListIndex(SaloonsController controller, int index) {
    Saloon saloon = Saloon();
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

  int getListLength(SaloonsController controller) {
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
        length = saloonsController.allList.length;
    }
    return length;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: GetX<SaloonsController>(builder: (controller) {
      return SizedBox(
        child: getListLength(controller) == 0 && controller.loading.value
            ? const BQLoaing()
            : getListLength(controller) == 0 && !controller.loading.value
                ? const NoDataWidget(text: "No Saloon Available")
                : ListView.builder(
                    itemCount: getListLength(controller),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.only(
                              top: 2.0, left: 5, right: 5),
                          child: SizedBox(
                            child: saloonItem(
                              100,
                              context,
                              item: getListIndex(controller, index),
                              onPress: (item) {
                                Get.to(SaloonDetailView(item: item));
                              },
                            ),
                          ));
                    }),
      );
    }));
  }
}
