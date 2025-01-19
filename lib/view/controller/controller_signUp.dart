import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/core/class/statusrequest.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/funcations/handlinfdatacontroller.dart';
import 'package:school_management/core/services/services.dart';
import 'package:school_management/data/dataSource/remote/auth/signUp_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SignUpController extends GetxController {
  signUp();
}

class SignUpControllerImp extends SignUpController {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController phoneNumberController;
  late TextEditingController addressConteroller;
  SignUpData signUpData = SignUpData(Get.find());
  late String role = 'student'; // الدور الافتراضي
  BuildContext? context;
  StatusRequest statusRequest = StatusRequest.none;
  late SharedPreferences prefs;
  MyServices myServices = Get.find();

  @override
  signUp() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await signUpData.signUp(
        emailController.text,
        passwordController.text,
        nameController.text,
        phoneNumberController.text,
        addressConteroller.text,
        role);
    statusRequest = handlingData(response);

    //
    if (StatusRequest.success == statusRequest) {
      update();
      if (response['success']) {
        log("${response['message']}", error: "success php");
        Get.back();
        Get.snackbar(
          'نجاح',
          response['message'],
          backgroundColor: AppColors.primaryColor,
          colorText: AppColors.backgroundIDsColor,
          animationDuration: const Duration(seconds: 5),
        );
      } else {
        Get.snackbar(
          'خطأ',
          response['message'],
          backgroundColor: AppColors.primaryColor,
          colorText: AppColors.backgroundIDsColor,
          animationDuration: const Duration(seconds: 5),
        );
      }
    } else {
      log("$response", error: " faield php");

      Get.snackbar(
        'أعد مرة أخرى',
        "البريد الالكتروني موجود مسبقا",
        backgroundColor: AppColors.primaryColor,
        colorText: AppColors.backgroundIDsColor,
        animationDuration: const Duration(seconds: 5),
      );
    }
  }

//

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    addressConteroller.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

//
  @override
  void onInit() async {
    statusRequest = StatusRequest.none;
    emailController = TextEditingController();
    passwordController = TextEditingController();
    addressConteroller = TextEditingController();
    nameController = TextEditingController();
    phoneNumberController = TextEditingController();

    super.onInit();

    update();
    prefs = await SharedPreferences.getInstance();
  }

  // @override
  // initialData() async {
  //   // isLoading;
  //   // update();

  //   await signUp();
  // }
  //
}
