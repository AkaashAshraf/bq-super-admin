import 'dart:io';

import 'package:bq_admin/components/common/app_bar.dart';
import 'package:bq_admin/components/common/image_picker.dart';
import 'package:bq_admin/components/common/loading_indicator.dart';
import 'package:bq_admin/components/common/simple_button.dart';
import 'package:bq_admin/components/common/simple_text_input.dart';
import 'package:bq_admin/components/common/single_selection_drop_down.dart';
import 'package:bq_admin/components/common/toasts.dart';
import 'package:bq_admin/controllers/constants_controller.dart';
import 'package:bq_admin/controllers/gym_controller.dart';
import 'package:bq_admin/controllers/helper_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddGymPackage extends StatefulWidget {
  const AddGymPackage({super.key, required this.shopId});
  final int shopId;
  @override
  State<AddGymPackage> createState() => _AddGymPackageState();
}

class _AddGymPackageState extends State<AddGymPackage> {
  HelperController helperController = Get.put(HelperController());
  ConstantsController constantsController = Get.put(ConstantsController());

  var isValidate = false;
  String imageSelectionType = "gallery".tr;
  XFile? image1;
  String nameEn = "";
  String nameAr = "";
  String price = "";
  String duration = "";
  String descriptionEn = "";
  String descriptionAr = "";

  String notifyingStock = "";
  bool checkValidation() {
    if (nameEn.isEmpty ||
            nameAr.isEmpty ||
            duration.isEmpty ||
            descriptionAr.isEmpty ||
            descriptionEn.isEmpty ||
            price.isEmpty
        // ||
        // descriptionEn.isEmpty ||
        // descriptionAr.isEmpty
        ) {
      ToastMessages.showError("Some data is missing");

      return false;
    }
    if (image1 == null) {
      ToastMessages.showError("image is missing");

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
      appBar: appBar(title: "Add Gym Package"),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: GetX<GymController>(builder: (controller) {
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
                    width: width * 0.49,
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
                  Expanded(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * 0.49,
                    child: SimpleInputField(
                      keyBoardType: TextInputType.number,
                      title: "Duration",
                      hint: "writeHere".tr,
                      initialValue: duration,
                      validator:
                          isValidate && duration.isEmpty ? "required".tr : "",
                      onTextChange: (val) {
                        setState(() {
                          duration = val;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: SimpleInputField(
                      title: "Price",
                      hint: "writeHere".tr,
                      initialValue: price,
                      keyBoardType: TextInputType.number,
                      validator:
                          isValidate && price.isEmpty ? "required".tr : "",
                      onTextChange: (val) {
                        setState(() {
                          price = val;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SimpleInputField(
                title: "description(EN)".tr,
                hint: "writeHere".tr,
                initialValue: descriptionEn,
                validator:
                    isValidate && descriptionEn.isEmpty ? "required".tr : "",
                onTextChange: (val) {
                  setState(() {
                    descriptionEn = val;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              SimpleInputField(
                title: "description(AR)".tr,
                hint: "writeHere".tr,
                initialValue: descriptionAr,
                validator:
                    isValidate && descriptionAr.isEmpty ? "required".tr : "",
                onTextChange: (val) {
                  setState(() {
                    descriptionAr = val;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              customImagePicker(
                hint: '',
                width: width,
                validator:
                    isValidate && image1 == null ? "imageIsRequired".tr : "",
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
                      var res = await Get.find<GymController>().addGymPackage(
                        nameEn: nameEn,
                        shopId: widget.shopId,
                        duration: duration,
                        nameAr: nameAr,
                        descriptionAr: descriptionAr,
                        descriptionEn: descriptionEn,
                        price: price,
                        image: image1,
                      );
                      if (res != null) {
                        ToastMessages.showSuccess(
                            "Package has been added successfully");
                        Get.back();
                        Get.back();

                        controller.fetchGyms(type: "all");
                        controller.fetchGyms(type: "active");
                        controller.fetchGyms(type: "deactive");
                        controller.update();
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
