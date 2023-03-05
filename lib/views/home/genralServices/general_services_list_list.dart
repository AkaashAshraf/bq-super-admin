import 'package:bq_admin/components/common/app_bar.dart';
import 'package:bq_admin/config/colors.dart';
import 'package:bq_admin/controllers/general_services_controller.dart';
import 'package:bq_admin/views/home/genralServices/add_general_service.dart';
import 'package:bq_admin/views/home/genralServices/general_service_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneralServiceList extends StatefulWidget {
  const GeneralServiceList({Key? key}) : super(key: key);
  @override
  State<GeneralServiceList> createState() => _GeneralServiceList();
}

class _GeneralServiceList extends State<GeneralServiceList> {
  @override
  void initState() {
    Get.find<GeneralServicesController>().fetchGeneralServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar(
          title: "General Services",
          rightIcon: GestureDetector(
            onTap: () {
              Get.to(const AddGeneralService());
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
          child: GetX<GeneralServicesController>(builder: (controller) {
        return SizedBox(
          child: ListView.builder(
              itemCount: controller.genralServicesList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.only(top: 2.0, left: 5, right: 5),
                    child: SizedBox(
                      // height: cardHeight,
                      // width: width * 0.95,

                      child: generalServiceItem(
                        100,
                        context,
                        item: controller.genralServicesList[index],
                        onPress: (item) {},
                      ),
                    ));
              }),
        );
      })),
    );
  }
}
