import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/view/controller/controller_signUp.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    Get.put(SignUpControllerImp());
    return Scaffold(
        appBar: AppBar(title: const Text('إنشاء حساب جديد')),
        body: GetBuilder<SignUpControllerImp>(
          builder: (controller) => (controller.isLoading == true)
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.primaryColor,
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                  color: AppColors.black)
                            ],
                          ),
                          // padding: const EdgeInsets.all(16.0),
                          margin: const EdgeInsets.all(16.0),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  TextField(
                                    controller: controller.nameController,
                                    decoration: const InputDecoration(
                                        labelText: 'الاسم'),
                                  ),
                                  const SizedBox(height: 10),
                                  TextField(
                                    controller: controller.emailController,
                                    decoration: const InputDecoration(
                                        labelText: 'البريد الإلكتروني'),
                                  ),
                                  const SizedBox(height: 10),
                                  TextField(
                                    controller: controller.passwordController,
                                    decoration: const InputDecoration(
                                        labelText: 'كلمة المرور'),
                                    obscureText: true,
                                  ),
                                  TextField(
                                    controller:
                                        controller.phoneNumberController,
                                    decoration: const InputDecoration(
                                        labelText: 'رقم الهاتف'),
                                  ),
                                  TextField(
                                    controller: controller.addressConteroller,
                                    decoration: const InputDecoration(
                                        labelText: 'العنوان'),
                                  ),
                                  const SizedBox(height: 10),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        right: .0, top: 10, bottom: 10),
                                    child: Text('   الدور :',
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9),
                                      color: AppColors.backgroundIDsColor,
                                      boxShadow: const [
                                        BoxShadow(
                                            blurRadius: 5,
                                            spreadRadius: 1,
                                            color: AppColors.black)
                                      ],
                                    ),
                                    child: DropdownButtonFormField<String>(
                                      // isDense: false,

                                      // isExpanded: true,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.only(
                                          bottom: 0, top: 0, right: 10),

                                      // iconSize: 0,
                                      // elevation: 2,

                                      borderRadius: BorderRadius.circular(20),
                                      dropdownColor: AppColors.backgroundcolor,
                                      value: controller.role,
                                      onChanged: (value) async {
                                        // setState(() =>
                                        controller.role = value!;
                                      },
                                      // ),
                                      decoration: const InputDecoration(
                                          // constraints: BoxConstraints(),
                                          ),
                                      items: const [
                                        DropdownMenuItem(
                                            value: 'student',
                                            child: Text('طالب')),
                                        DropdownMenuItem(
                                            value: 'father',
                                            child: Text('ولي أمر')),
                                        DropdownMenuItem(
                                            value: 'teacher',
                                            child: Text('معلم')),
                                        DropdownMenuItem(
                                            value: 'admin',
                                            child: Text('مدير')),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 60),
                                  // (controller.isLoading == true)
                                  //     ? const Center(
                                  //         child: CircularProgressIndicator())
                                  //     :
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        maximumSize:
                                            const WidgetStatePropertyAll(
                                                Size(400, 90)),
                                        minimumSize:
                                            const WidgetStatePropertyAll(
                                                Size(20, 55)),
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                AppColors.backgroundIDsColor)),
                                    onPressed: () async {
                                      await controller.signUp();
                                    },
                                    child: const Text('إنشاء حساب',
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 60),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ));
  }
}
