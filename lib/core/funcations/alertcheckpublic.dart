// import 'package:adminkingfashion/core/funcations/translatefatabase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/core/constant/colors.dart';

Future<bool> alertCheckPublic(
    {String title = "",
    String middleText = "",
    Function()? onPressedYes,
    Function()? onPressedNo}) async {
  bool isYes = false;

  await Get.defaultDialog(
      title: title,
      titleStyle: const TextStyle(
          color: AppColors.primaryColor, fontWeight: FontWeight.bold),
      middleText: middleText,
      actions: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(AppColors.primaryColor)),
            onPressed: onPressedYes ??
                () {
                  isYes = true;
                  Get.back();
                },
            child: Text("48".tr)),
        onPressedNo != null
            ? ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(AppColors.primaryColor)),
                onPressed: onPressedNo,
                child: Text("49".tr))
            : Container()
      ]);

  return Future.value(isYes);
}

alertLoadingPublic(BuildContext context) async {
  Get.dialog(
    AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7), child: Text("160".tr)),
        ],
      ),
    ),
  );
}
