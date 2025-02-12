import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/core/class/handlingdataview.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/services/services.dart';
import 'package:school_management/view/controller/controller_roles.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    Get.put(ControllerRolesHomeImp());
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body:
            // Exit From App
            WillPopScope(
          onWillPop: () {
            Get.dialog(AlertDialog(
              shadowColor: AppColors.primaryColor,
              backgroundColor: AppColors.primaryColor,
              title: const Text(
                'تأكيد الخروج',
              ),
              content: const Text(
                'هل تريد الخروج من التطبيق ؟',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(AppColors.backgroundIDsColor),
                  ),
                  onPressed: () => Get.back(canPop: true, result: false),
                  child: const Text(
                    'إلغاء',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: AppColors.black),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(AppColors.backgroundIDsColor),
                  ),
                  onPressed: () => exit(0),
                  child: const Text(
                    'خروج',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.actionColor),
                  ),
                ),
              ],
            ));
            return Future.value(true);
          },
          // AppBar And Body
          child: GetBuilder<ControllerRolesHomeImp>(
            builder: (controller) => HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: SingleChildScrollView(
                padding: const EdgeInsets.all(1.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 2.2,
                                color: AppColors.black)
                          ],
                          borderRadius: BorderRadiusDirectional.only(
                              bottomEnd: Radius.circular(40),
                              bottomStart: Radius.circular(40))),
                      child:
                          // AppBar :
                          ListView(
                        shrinkWrap: true,
                        children: [
                          AppBar(
                            backgroundColor: AppColors.primaryColor,
                            title: const Text(
                              'الصفحة الرئيسية',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            actions: [
                              //  Exit From The Account :
                              IconButton(
                                color: AppColors.black,
                                onPressed: () {
                                  Get.dialog(AlertDialog(
                                    backgroundColor: AppColors.primaryColor,
                                    title: const Text(
                                      'تأكيد تسجيل الخروج',
                                    ),
                                    content: const Text(
                                        'هل تريد  تسجيل الخروج من الحساب ؟',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        )),
                                    actions: [
                                      TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  AppColors.backgroundIDsColor),
                                        ),
                                        onPressed: () => Get.back(),
                                        child: const Text('إلغاء',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                      TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  AppColors.backgroundIDsColor),
                                        ),
                                        onPressed: () async {
                                          MyServices myServices = Get.find();
                                          myServices.sharedPreferences.clear();
                                          myServices.sharedPreferences
                                              .setString("loginPage", "1");
                                          Get.back();
                                          controller.logoutUser();
                                        },
                                        child: const Text(
                                          'خروج',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ));
                                },
                                icon: const Icon(Icons.logout),
                                tooltip: 'تسجيل الخروج',
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Padding(
                              padding: const EdgeInsets.only(
                                right: 25,
                              ),
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  Text(
                                    'اهلا بك، ${controller.userName}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ' ${controller.userEmail}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ' دورك الحالي : ${controller.role}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              )),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    //  Body Home Screen:
                    if (controller.role == 'admin') const SizedBox(height: 20),
                    if (controller.role == 'admin') controller.widgetAdmin(),
                    if (controller.role == 'teacher')
                      const SizedBox(height: 20),
                    if (controller.role == 'teacher')
                      controller.widgetTeacher(),
                    if (controller.role == 'student')
                      const SizedBox(height: 20),
                    if (controller.role == 'student')
                      controller.widgetStudent(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
