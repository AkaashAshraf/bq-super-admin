import 'package:bq_admin/config/colors.dart';
import 'package:bq_admin/config/constants.dart';
import 'package:bq_admin/config/text_sizes.dart';
import 'package:bq_admin/models/simple/gym_package.dart';
import 'package:bq_admin/models/simple/shop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Padding gymPackageItem(
  double cardHeight,
  BuildContext context, {
  required GymPackage package,
  required Shop shop,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 2.0, left: 5, right: 5),
    child: SizedBox(
        // width: width * 0.95,

        child: Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: Card(
        elevation: 5,
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.network(
                    imageBaseUrl + package.image.toString(),
                    fit: BoxFit.fill,
                    height: cardHeight,
                    width: cardHeight * 0.99,
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: screenWidth(context) * 0.65,
                          child: Text(
                            "${package.nameEn} - ${package.nameAr}",
                            style: TextStyle(
                                fontFamily: "primary",
                                color: titleColor,
                                fontSize:
                                    getTextSize(context).smallItemMainText),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth(context) * 0.65,
                          child: Text(
                            "${package.description} - ${package.descriptionAr}",
                            maxLines: 1,
                            style: TextStyle(
                                fontFamily: "primary",
                                color: secondaryTextColor,
                                fontSize:
                                    getTextSize(context).smallItemSubText),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth(context) * 0.65,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${package.price} ${"OMR".tr}",
                                maxLines: 1,
                                style: TextStyle(
                                    fontFamily: "primary",
                                    color: secondaryTextColor,
                                    fontSize:
                                        getTextSize(context).smallItemSubText),
                              ),
                              // Icon(
                              //   Icons.shopping_cart,
                              //   size: 18,
                              //   color: primaryColor,
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )),
  );
}
