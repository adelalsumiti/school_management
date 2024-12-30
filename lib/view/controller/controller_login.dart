import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/core/services/services.dart';
import 'package:school_management/linkApi.dart';
import 'package:school_management/view/screen/home/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class LoginController extends GetxController {
  login();
  initialData();
}

class LoginControllerImp extends LoginController {
  // String email, String name, String rolee, String password
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String? userName;
  int? userId;
  String? role;
  MyServices myServices = Get.find();

  // String? apiUrl;

  //
  @override
  login() async {
    // try {
    // طلب API
    // setState(() {

    // });

    // final apiUrl = AppLink.login; // رابط API
    isLoading == true;
    update();
    //  لتسجيل الدخول
    final response = await http.post(Uri.parse(AppLink.login),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {
            'id': userId,
            'email': emailController.text.trim(),
            'name': userName,
            'role': role,
            'password': passwordController.text.trim(),
            // 'role': role,
          },
        ));
    // isLoading = false;
    update();

    try {
      isLoading = true;

      var data = json.decode(response.body);

      if (data['success']) {
        isLoading = false;

        userId = data['id'];
        // حفظ البريد الإلكتروني في SharedPreferences
        userName = data['name']; // الاسم القادم من API
        role = data['role']; // الاسم القادم من API
        SharedPreferences prefs = await SharedPreferences.getInstance();
        log("$userId", name: 'userId', error: userId);
        log("$role", name: 'role', error: role);
        log("$userName", name: 'userName', error: userName);

        // حفظ البريد الإلكتروني والاسم
        await prefs.setString('email', emailController.text);
        await prefs.setString('name', userName!);
        await prefs.setInt('id', userId!);

        await prefs.setString('role', role!);
        log("$prefs", name: 'predfs', error: prefs);

        myServices.sharedPreferences.setString("homePage", "2");

        // الانتقال إلى الصفحة الرئيسية

        Get.to(() => const HomePage());
      } else {
        isLoading = false;

        // عرض رسالة خطأ
        Get.snackbar('خطأ', data['message']);
      }
    } catch (e) {
      isLoading = false;

      debugPrint('Error: $e');
    }
  }

  //
  @override
  void onInit() async {
    super.onInit();
    // isLoading;
    // update();

    await initialData();
  }

  @override
  initialData() async {
    // isLoading;
    // update();

    await login();
  }
}
