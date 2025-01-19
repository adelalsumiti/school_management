import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/funcations/custombuttonlanguage.dart';
import 'package:school_management/core/localization/changelocallangcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> showDialogChangeLanguage(
    {String title = "",
    String middleText = "",
    Function()? onPressedYes,
    Function()? onPressedNo}) async {
  bool isYes = false;
  LocaleController controller = Get.put(LocaleController());
  await Get.defaultDialog(
    title: title,
    titleStyle: const TextStyle(
        color: AppColors.primaryColor, fontWeight: FontWeight.bold),
    middleText: middleText,
    actions: [
      Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("1".tr,
                  style: Theme.of(Get.context!).textTheme.headlineLarge),
              const SizedBox(height: 20),
              CustomButtonLang(
                  textbutton: "321".tr,
                  onPressed: () {
                    controller.changeLang("en");
                    Get.back();
                    // Get.toNamed(AppRoute.onBoarding);
                  }),
              CustomButtonLang(
                  textbutton: "322".tr,
                  onPressed: () {
                    controller.changeLang("en");
                    Get.back();
                    // Get.toNamed(AppRoute.onBoarding);
                  }),
            ],
          )),
    ],
  );

  return Future.value(isYes);
}
