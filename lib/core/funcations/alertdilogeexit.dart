// ignore: depend_on_referenced_packages
import 'dart:io';

import 'package:school_management/core/constant/colors.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

Future<bool> alertDialogExit() {
  Get.defaultDialog(
      title: "46".tr,
      middleText: "47".tr,
      radius: 30.0,
      titleStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: AppColors.primaryColor),
      textCancel: "49".tr,
      cancelTextColor: AppColors.primaryColor,
      onConfirm: (() => exit(0)),
      textConfirm: "48".tr,
      backgroundColor: AppColors.backgroundcolor,
      confirmTextColor: Colors.white,
      buttonColor: AppColors.primaryColor);
  return Future.value(true);
}
