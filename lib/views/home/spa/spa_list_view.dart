import 'package:bq_admin/components/common/loading_indicator.dart';
import 'package:bq_admin/components/common/no_data_widget.dart';
import 'package:bq_admin/controllers/spa_controller.dart';
import 'package:bq_admin/models/simple/saloon.dart';
import 'package:bq_admin/views/home/spa/spa_item.dart';
import 'package:bq_admin/views/home/spa/spa_details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpaListView extends StatefulWidget {
  const SpaListView({Key? key, required this.type}) : super(key: key);
  final String type;
  @override
  State<SpaListView> createState() => _SpaListView();
}

class _SpaListView extends State<SpaListView> {
  SpaController controller = Get.find<SpaController>();
  @override
  void initState() {
    super.initState();
  }

  Saloon getListIndex(SpaController controller, int index) {
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

  int getListLength(SpaController controller) {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: GetX<SpaController>(builder: (controller) {
      return SizedBox(
        child: getListLength(controller) == 0 && controller.loading.value
            ? const BQLoaing()
            : getListLength(controller) == 0 && !controller.loading.value
                ? const NoDataWidget(text: "No Spa Available")
                : ListView.builder(
                    itemCount: getListLength(controller),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.only(
                              top: 2.0, left: 5, right: 5),
                          child: SizedBox(
                            child: spaItem(
                              100,
                              context,
                              item: getListIndex(controller, index),
                              onPress: (item) {
                                Get.to(SpaDetailView(item: item));
                              },
                            ),
                          ));
                    }),
      );
    }));
  }
}
