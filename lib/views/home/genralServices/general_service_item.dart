import 'package:bq_admin/config/colors.dart';
import 'package:bq_admin/config/constants.dart';
import 'package:bq_admin/config/text_sizes.dart';
import 'package:bq_admin/models/simple/general_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget generalServiceItem(double cardHeight, BuildContext context,
    {required GeneralService item, required dynamic onPress}) {
  return GestureDetector(
    onTap: () {
      onPress(item);
    },
    child: SizedBox(
        child: Padding(
      padding: const EdgeInsets.only(left: 0),
      child: Card(
        elevation: 5,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.network(
                imageBaseUrl + item.image,
                fit: BoxFit.fill,
                height: screenWidth(context) * 0.27,
                width: screenWidth(context) * 0.23,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: screenWidth(context) * 0.65,
                    child: Text(
                      Get.locale.toString() == "en" ? item.nameEn : item.nameAr,
                      textAlign: Get.locale.toString() == "en"
                          ? TextAlign.left
                          : TextAlign.right,
                      style: TextStyle(
                          fontFamily: "primary",
                          color: titleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: getTextSize(context).smallItemMainText),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: screenWidth(context) * 0.65,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Status",
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontFamily: "primary",
                          ),
                        ),
                        Text(
                          item.isActive == 1 ? "Active" : "Deactive",
                          style: TextStyle(
                            color:
                                item.isActive == 1 ? Colors.green : Colors.red,
                            fontFamily: "primary",
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: screenWidth(context) * 0.65,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "",
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontFamily: "primary",
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                item.isActive == 1
                                    ? Colors.red.withAlpha(500)
                                    : Colors.green),
                          ),
                          onPressed: () {},
                          child: SizedBox(
                            width: 70,
                            child: Center(
                              child: Text(
                                item.isActive == 1 ? "De-Activate" : "Activate",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: "primary",
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )),
  );
}
