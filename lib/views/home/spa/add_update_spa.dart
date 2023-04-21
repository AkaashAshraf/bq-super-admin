import 'dart:io';

import 'package:bq_admin/components/common/app_bar.dart';
import 'package:bq_admin/components/common/image_picker.dart';
import 'package:bq_admin/components/common/loading_indicator.dart';
import 'package:bq_admin/components/common/simple_button.dart';
import 'package:bq_admin/components/common/simple_text_input.dart';
import 'package:bq_admin/components/common/single_selection_drop_down.dart';
import 'package:bq_admin/components/common/toasts.dart';
import 'package:bq_admin/controllers/constants_controller.dart';
import 'package:bq_admin/controllers/helper_controller.dart';
import 'package:bq_admin/controllers/spa_controller.dart';
import 'package:bq_admin/models/simple/saloon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddUpdateSpa extends StatefulWidget {
  const AddUpdateSpa({super.key, required this.item});
  final Saloon item;
  @override
  State<AddUpdateSpa> createState() => _AddUpdateSpaState();
}

class _AddUpdateSpaState extends State<AddUpdateSpa> {
  HelperController helperController = Get.put(HelperController());
  ConstantsController constantsController = Get.put(ConstantsController());

  var isValidate = false;
  int id = 0;
  String imageSelectionType = "gallery".tr;
  XFile? image1;
  int city = 0;
  String nameEn = "";
  String nameAr = "";
  String longitude = "";
  String latitude = "";
  String contact = "";

  String descriptionEn = "";
  String descriptionAr = "";

  String notifyingStock = "";
  bool checkValidation() {
    if (nameEn.isEmpty ||
        city == 0 ||
        nameAr.isEmpty ||
        latitude.isEmpty ||
        longitude.isEmpty ||
        contact.length < 8 ||
        descriptionEn.isEmpty ||
        descriptionAr.isEmpty) {
      ToastMessages.showError("Some data is missing");

      return false;
    }
    if (id == 0 && image1 == null) {
      ToastMessages.showError("Some data is missing");

      return false;
    }
    return true;
  }

  @override
  void initState() {
    if (widget.item.id != 0) {
      setState(() {
        id = widget.item.id ?? 0;
        nameAr = widget.item.nameAr;
        nameEn = widget.item.nameEn;
        descriptionAr = widget.item.descriptionAr ?? "";
        descriptionEn = widget.item.descriptionEn ?? "";
        contact = widget.item.contact ?? "";
        city = widget.item.city?.id ?? 0;
        latitude = widget.item.latitude ?? "";
        longitude = widget.item.longitude ?? "";
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appBar(title: id > 0 ? "Update Spa" : "Add Spa"),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: GetX<SpaController>(builder: (controller) {
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
                      title: "Latitude",
                      hint: "writeHere".tr,
                      initialValue: latitude,
                      validator:
                          isValidate && latitude.isEmpty ? "required".tr : "",
                      onTextChange: (val) {
                        setState(() {
                          latitude = val;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: SimpleInputField(
                      title: "Longitude",
                      hint: "writeHere".tr,
                      initialValue: longitude,
                      validator:
                          isValidate && longitude.isEmpty ? "required".tr : "",
                      onTextChange: (val) {
                        setState(() {
                          longitude = val;
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
                    width: width * 0.95,
                    child: SingleSelectionSimpleDropDown(
                      title: "City",
                      selected: city,
                      items: constantsController.cities
                          .map((element) => DropDown(
                              title: element.nameEn ?? "",
                              value: element.id ?? 0))
                          .toList(),
                      validator: isValidate && city == 0 ? "required".tr : "",
                      onChange: (DropDown val) {
                        setState(() {
                          city = val.value;
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
              SimpleInputField(
                title: "Contact",
                hint: "writeHere".tr,
                initialValue: contact,
                validator: isValidate && contact.isEmpty
                    ? "required".tr
                    : isValidate && contact.length < 8
                        ? "invalid contact"
                        : "",
                onTextChange: (val) {
                  setState(() {
                    contact = val;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              customImagePicker(
                hint: '',
                width: width,
                validator: isValidate && image1 == null && id == 0
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
                      var res = await Get.find<SpaController>().addUpdateSpa(
                        id: id,
                        nameEn: nameEn,
                        nameAr: nameAr,
                        contact: contact,
                        latitude: latitude,
                        longitude: longitude,
                        city: city,
                        descriptionEn: descriptionEn,
                        descriptionAr: descriptionAr,
                        image: image1,
                      );
                      if (res != null) {
                        ToastMessages.showSuccess(id > 0
                            ? "Spa has been updated successfully"
                            : "Spa has been added successfully");
                        Get.back();
                        if (id > 0) {
                          Get.back();
                        }
                        controller.fetchSpa(type: "all");
                        controller.fetchSpa(type: "active");
                        controller.fetchSpa(type: "deactive");
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
