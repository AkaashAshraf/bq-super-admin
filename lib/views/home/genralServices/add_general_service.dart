import 'dart:io';

import 'package:bq_admin/components/common/app_bar.dart';
import 'package:bq_admin/components/common/image_picker.dart';
import 'package:bq_admin/components/common/loading_indicator.dart';
import 'package:bq_admin/components/common/simple_button.dart';
import 'package:bq_admin/components/common/simple_text_input.dart';
import 'package:bq_admin/components/common/toasts.dart';
import 'package:bq_admin/controllers/general_services_controller.dart';
import 'package:bq_admin/controllers/helper_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddGeneralService extends StatefulWidget {
  const AddGeneralService({super.key});

  @override
  State<AddGeneralService> createState() => _AddGeneralServiceState();
}

class _AddGeneralServiceState extends State<AddGeneralService> {
  HelperController helperController = Get.put(HelperController());

  var isValidate = false;
  int productId = 0;
  String imageSelectionType = "gallery".tr;
  XFile? image1;

  String nameEn = "";
  String nameAr = "";

  bool checkValidation() {
    if (nameEn.isEmpty || nameAr.isEmpty) {
      ToastMessages.showError("Some data is missing");

      return false;
    }
    if (image1 == null) {
      ToastMessages.showError("Some data is missing");

      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appBar(title: "Add General Service"),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: GetX<GeneralServicesController>(builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width,
                    child: SimpleInputField(
                      title: "Name EN",
                      hint: "writeHere".tr,
                      initialValue: nameEn,
                      validator:
                          isValidate && nameEn.isEmpty ? "required".tr : "",
                      onTextChange: (val) {
                        setState(() {
                          nameEn = val;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width,
                    child: SimpleInputField(
                      title: "Name AR",
                      hint: "writeHere".tr,
                      initialValue: nameAr,
                      validator:
                          isValidate && nameAr.isEmpty ? "required".tr : "",
                      onTextChange: (val) {
                        setState(() {
                          nameAr = val;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              customImagePicker(
                hint: '',
                width: width,
                validator: isValidate && image1 == null && productId == 0
                    ? "imageIsRequired".tr
                    : "",
                onTap: () async {
                  // AlertText(context, 'txt').show();
                  var tempImage = (await ImagePicker().pickImage(
                      source: imageSelectionType == "gallery".tr
                          ? ImageSource.gallery
                          : ImageSource.camera));
                  // inspect(tempImage);
                  {
                    setState(() {
                      image1 = tempImage;
                    });
                  }
                },
                // keyBoardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  if (image1 != null)
                    imageViewer(image1!, () {
                      setState(() {
                        image1 = null;
                      });
                    }),
                ],
              ),
              if (controller.loading.value)
                const BQLoaing()
              else
                SizedBox(
                  width: width * 0.9,
                  height: height * 0.06,
                  child: SimpleButton(
                    title: "Create",
                    onPress: () async {
                      setState(() {
                        isValidate = true;
                      });
                      // if (image1 == null && productId == 0) {
                      //   tamweenToastMessage(
                      //           context: context,
                      //           type: "error",
                      //           descripetion: "Image is required")
                      //       .show(context);
                      // }
                      if (!checkValidation()) {
                        return;
                      }
                      var res = await Get.find<GeneralServicesController>()
                          .addGeneralService(
                        nameEn: nameEn,
                        nameAr: nameAr,
                        image: image1,
                      );
                      if (res != null) {
                        ToastMessages.showSuccess(
                            "Service has been added successfully");
                        Get.back();
                        controller.fetchGeneralServices();
                      }
                    },
                  ),
                ),
              const SizedBox(
                height: 250,
              ),
            ],
          );
        }),
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
                    'assets/images/minus.png',
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
