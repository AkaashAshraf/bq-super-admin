import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bq_admin/components/common/app_bar.dart';
import 'package:bq_admin/components/common/buttons.dart';
import 'package:bq_admin/components/common/dotted_line.dart';
import 'package:bq_admin/components/common/generic_popup.dart';
import 'package:bq_admin/components/common/loading_indicator.dart';
import 'package:bq_admin/components/common/toasts.dart';
import 'package:bq_admin/config/colors.dart';
import 'package:bq_admin/config/constants.dart';
import 'package:bq_admin/controllers/helper_controller.dart';
import 'package:bq_admin/controllers/saloons_controller.dart';
import 'package:bq_admin/controllers/spa_controller.dart';
import 'package:bq_admin/models/simple/saloon.dart';
import 'package:bq_admin/views/home/saloons/saloon_service_item.dart';
import 'package:bq_admin/views/home/spa/add_update_spa.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class SpaDetailView extends StatefulWidget {
  SpaDetailView({Key? key, required this.item}) : super(key: key);
  final Saloon item;
  final controller = Get.put(SaloonsController());

  @override
  State<SpaDetailView> createState() => _SpaDetailView();
}

class _SpaDetailView extends State<SpaDetailView> {
  // var employees;
  // var services;
  // Employee? employees;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final cardHeight = MediaQuery.of(context).size.height * 0.1;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar(
          title: Get.locale.toString() == "en"
              ? widget.item.nameEn
              : widget.item.nameAr,
          showCart: false),
      body: SafeArea(child: SingleChildScrollView(
          child: GetX<SpaController>(builder: (controller) {
        return Column(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      child: CarouselSlider(
                          items: [
                            if (widget.item.imagePath != "")
                              Image.network(
                                "$imageBaseUrl/${widget.item.imagePath}",
                                fit: BoxFit.cover,
                                height: height * 0.28,
                                width: width,
                              ),
                          ],
                          options: CarouselOptions(
                            // height: 400,
                            aspectRatio: 14 / 9,
                            viewportFraction: 1,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: false,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            // onPageChanged: callbackFunction,
                            scrollDirection: Axis.horizontal,
                          ))
                      // Image.network(
                      //   "$imageBaseUrl/${widget.item.image1}",
                      //   fit: BoxFit.cover,
                      //   height: height * 0.28,
                      //   width: width,
                      // ),
                      ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Get.locale.toString() == "en"
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              ColorizeAnimatedText(
                                "${widget.item.nameEn} - ${widget.item.nameAr}",
                                textStyle: TextStyle(
                                    fontFamily: "primary",
                                    fontSize: width * 0.05,
                                    fontWeight: FontWeight.w600,
                                    color: titleColor),
                                colors: [
                                  primaryColor,
                                  dashbboardTitleColor,
                                  primaryColor
                                ],
                              ),
                            ],
                            isRepeatingAnimation: true,
                          ),
                        ),
                        //   Text(
                        //     widget.item.nameEn!,
                        //     style: TextStyle(
                        //         fontSize: width * 0.045,
                        //         fontWeight: FontWeight.w500,
                        //         color: titleColor),
                        //   ),
                        // ),
                        const SizedBox(height: 5),
                        Row(
                          textDirection: Get.locale.toString() == "en"
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          children: [
                            Text(
                              Get.locale.toString() == "en"
                                  ? widget.item.city?.nameEn ?? ""
                                  : widget.item.city?.nameAr ?? "",
                              style: const TextStyle(
                                color: secondaryTextColor,
                                fontFamily: "primary",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "08:00 AM - 11:00 PM",
                              style: TextStyle(
                                color: secondaryTextColor,
                                fontFamily: "primary",
                              ),
                            ),

                            Text(
                              "OpenNow".tr,
                              style: const TextStyle(
                                color: secondaryTextColor,
                                fontFamily: "primary",
                              ),
                            ),
                            // DefaultTextStyle(
                            //   style: TextStyle(
                            //       // fontSize: 15.0,

                            //       fontWeight: FontWeight.bold,
                            //       color: primaryColor),
                            //   child: AnimatedTextKit(
                            //     repeatForever: true,
                            //     animatedTexts: [
                            //       FadeAnimatedText('Opened'),
                            //     ],
                            //     onTap: () {
                            //       print("Tap Event");
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (() {
                                // Get.to(const EmployeesListView());
                              }),
                              child: const Text(
                                "",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontFamily: "primary",
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RatingBar.builder(
                                  ignoreGestures: true,
                                  initialRating: 4.5,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 20.0,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    size: 10,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {},
                                ),
                                const Text(
                                  "4.5 / 26",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: "primary",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width * 0.7,
                                child: Text(
                                  "${widget.item.descriptionEn} - ${widget.item.descriptionAr}",
                                  style: const TextStyle(
                                    color: secondaryTextColor,
                                    fontFamily: "primary",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width * 0.96,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width * 0.31,
                          child: iconButton(
                              onClick: () async {
                                genericPopup(context,
                                    title:
                                        "${"Contact".tr} ${Get.locale.toString() == "en" ? widget.item.nameEn : widget.item.nameAr}",
                                    children: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          width: width * 0.5,
                                          child: iconButton(
                                            onClick: () {
                                              Get.put(HelperController()).openUrl(
                                                  url:
                                                      "tel:+968${widget.item.contact}");
                                              Navigator.pop(context);
                                            },
                                            text: "Contact".tr,
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
                                                      "whatsapp://send?phone=${widget.item.contact}&text=");
                                              Navigator.pop(context);
                                            },
                                            text: "Whatsapp".tr,
                                            icon: const Icon(
                                              Icons.whatsapp,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    )).show();
                              },
                              icon: const Icon(
                                Icons.phone,
                                size: 20,
                                color: Colors.white,
                              ),
                              text: "Contact".tr),
                        ),
                        SizedBox(
                          width: width * 0.31,
                          child: iconButton(
                              onClick: () async {
                                Get.to(AddUpdateSpa(item: widget.item));
                              },
                              icon: const Icon(
                                Icons.edit,
                                size: 20,
                                color: Colors.white,
                              ),
                              text: "Update".tr),
                        ),
                        if (controller.loading.value) Container(),
                        SizedBox(
                          width: width * 0.31,
                          child: iconButton(
                              onClick: () async {
                                genericPopup(context,
                                    title:
                                        "Are you sure you want to ${widget.item.isBlocked == 0 ? "block" : "unblock"} ${Get.locale.toString() == "en" ? widget.item.nameEn : widget.item.nameAr}",
                                    children: GetX<SpaController>(
                                        builder: (controller) {
                                  return Container(
                                    child: controller.loading.value
                                        ? const BQLoaing()
                                        : Column(
                                            children: <Widget>[
                                              SizedBox(
                                                width: width * 0.5,
                                                child: iconButton(
                                                  onClick: () async {
                                                    bool respose = await controller
                                                        .blockUnblockSpa(
                                                            status: widget.item
                                                                        .isBlocked ==
                                                                    0
                                                                ? 1
                                                                : 0,
                                                            spaID: widget
                                                                    .item.id ??
                                                                0);
                                                    if (respose) {
                                                      ToastMessages.showSuccess(
                                                          "Spa has been ${widget.item.isBlocked == 0 ? "blocked" : "unblocked"}");
                                                      // ignore: use_build_context_synchronously
                                                      Navigator.pop(context);
                                                      // ignore: use_build_context_synchronously
                                                      Navigator.pop(context);
                                                    } else {
                                                      ToastMessages.showError(
                                                          "Something went wrong");
                                                    }
                                                  },
                                                  text: "Yes",
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                width: width * 0.5,
                                                child: iconButton(
                                                  onClick: () {
                                                    Navigator.pop(context);
                                                  },
                                                  text: "No",
                                                ),
                                              )
                                            ],
                                          ),
                                  );
                                })).show();
                              },
                              icon: const Icon(
                                size: 20,
                                Icons.block,
                                color: Colors.white,
                              ),
                              text: widget.item.isBlocked == 0
                                  ? "Block"
                                  : "Unblock"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  dottedLine(thicknes: 1),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Services",
                    maxLines: 1,
                    style: TextStyle(
                        fontFamily: "primary",
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.05),
                  ),
                ),
              ],
            ),
            for (var i = 0; i < widget.item.services!.length; i++)
              serviceItem(
                cardHeight,
                context,
                saloon: widget.item,
                service: widget.item.services![i],
              )
          ],
        );
      }))),
    );
  }
}
