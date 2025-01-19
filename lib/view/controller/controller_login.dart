import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/core/class/statusrequest.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/constant/routes.dart';
import 'package:school_management/core/funcations/handlinfdatacontroller.dart';
import 'package:school_management/core/services/services.dart';
import 'package:school_management/data/dataSource/remote/auth/login_data.dart';
import 'package:school_management/view/screen/home/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginController extends GetxController {
  login();
  goToSignUp();
}

class LoginControllerImp extends LoginController {
  LoginData loginData = LoginData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  String? userName;
  int? userId;
  String? role;
  late SharedPreferences prefs;
  MyServices myServices = Get.find();

  //
  @override
  login() async {
    // if (formstate.currentState!.validate()) {
    statusRequest = StatusRequest.loading;
    update();

    var response = await loginData.login(
      emailController.text,
      passwordController.text,
    );
    statusRequest = handlingData(response);
    update();
    if (StatusRequest.success == statusRequest) {
      if (response['success']) {
        userId = response['id'];
        // حفظ البريد الإلكتروني في SharedPreferences
        userName = response['name']; // الاسم القادم من API
        role = response['role']; // الاسم القادم من API
        update();
        // SharedPreferences
        prefs = await SharedPreferences.getInstance();
        update();
        log("$userId", name: 'userId', error: userId);
        log("$role", name: 'role', error: role);
        log("$userName", name: 'userName', error: userName);

        // حفظ البريد الإلكتروني والاسم
        await prefs.setString('email', emailController.text);
        await prefs.setString('name', userName!);
        await prefs.setInt('id', userId!);

        await prefs.setString('role', role!);
        update();

        log("$prefs", name: 'predfs', error: prefs);

        myServices.sharedPreferences.setString("homePage", "2");
        update();

        // الانتقال إلى الصفحة الرئيسية
        Get.to(() => const HomePage());
        update();
        //
        statusRequest = StatusRequest.none;
        update();
      } else {
        statusRequest = StatusRequest.none;
        // عرض رسالة خطأ
        Get.snackbar(
          'خطأ',
          response['message'],
          backgroundColor: AppColors.primaryColor,
          colorText: AppColors.backgroundIDsColor,
          animationDuration: const Duration(seconds: 5),
        );
      }
      update();
    }
    update();
  }

  //
  @override
  void onInit() async {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
    statusRequest = StatusRequest.none;
    update();
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  goToSignUp() {
    Get.toNamed(AppRoute.signUpPage);
  }
}
