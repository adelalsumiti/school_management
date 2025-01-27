import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/core/class/handlingdataview.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/view/controller/controller_login.dart';
import 'package:school_management/view/widgets/auth/logoAuth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImp());
    return Scaffold(
        appBar: AppBar(title: const Text('تسجيل الدخول')),
        body: GetBuilder<LoginControllerImp>(
            builder: (controller) => HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget:

                      // controller.isLoading
                      //     ? const Center(child: CircularProgressIndicator())
                      // :
                      Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 30),
                          const LogoAuth(),
                          const SizedBox(height: 50),
                          Container(
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  boxShadow: const [
                                    BoxShadow(
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                        color: AppColors.black)
                                  ],
                                  borderRadius: BorderRadius.circular(20)),
                              margin: const EdgeInsets.all(20),
                              padding: const EdgeInsets.all(20),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: controller.emailController,
                                      decoration: const InputDecoration(
                                          labelText: 'البريد الإلكتروني',
                                          labelStyle: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500)),
                                      onTapAlwaysCalled: true,
                                    ),

                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: controller.passwordController,
                                      decoration: const InputDecoration(
                                          labelText: 'كلمة المرور',
                                          labelStyle: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500)),
                                      obscureText: true,
                                    ),
                                    const SizedBox(height: 50),
                                    ElevatedButton(
                                      // onPressed: () => controller.login,

                                      onPressed: () async {
                                        // controller.isLoading = true;
                                        controller.login();
                                        // controller.isLoading = false;
                                      },
                                      child: const Text('تسجيل الدخول',
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    // const SizedBox(height: 5),
                                    ElevatedButton(
                                      onPressed: () => controller.goToSignUp(),
                                      child: const Text(' أنشاء حساب ',
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    const SizedBox(height: 30),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                )));
  }
}
