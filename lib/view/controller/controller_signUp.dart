import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/linkApi.dart';
import 'package:http/http.dart' as http;

abstract class SignUpController extends GetxController {
  signUp();
  initialData();
}

class SignUpControllerImp extends SignUpController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressConteroller = TextEditingController();
  late String role = 'student'; // الدور الافتراضي
  BuildContext? context;

  var apiUrl = AppLink.createUser; // رابط API
  // var data;

  bool isLoading = false;

  @override
  signUp() async {
    // setState(() {
    isLoading = true;
    // update();
    // isLoading = false;
    update();

    // });

    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "phone_number": phoneNumberController.text.trim(),
        "address": addressConteroller.text.trim(),
        "role": role,
      }),
    );
    // setState(() {
    // isLoading = false;
    // update();

    // });

    if (response.statusCode == 200) {
      isLoading = false;
      update();
      var data = json.decode(response.body);
      if (data['success']) {
        //
        log("${data['message']}", error: "success php");
        //
        Get.back();

        Get.snackbar(
          'نجاح',
          data['message'],
          backgroundColor: AppColors.primaryColor,
          colorText: AppColors.backgroundIDsColor,
          animationDuration: const Duration(seconds: 5),
        );
      } else {
        // log("$response", error: " faield php");
        // log("${data['message']}", error: "php");

        // ScaffoldMessenger.of(context).showSnackBar(
        // SnackBar(content: Text(data['message']));
        // GetSnackBar(messageText: Text(data['message']));

        Get.snackbar(
          'خطأ',
          data['message'],
          backgroundColor: AppColors.primaryColor,
          colorText: AppColors.backgroundIDsColor,
          animationDuration: const Duration(seconds: 5),
        );

        // );
      }
    } else {
      // log("${data['message']}", error: "php");
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
//
  @override
  void onInit() {
    super.onInit();
    // isLoading;
    // update();

    initialData();
  }

  @override
  initialData() async {
    // isLoading;
    // update();

    await signUp();
  }
  //
}
