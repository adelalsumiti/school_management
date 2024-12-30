//  Scaffold(
//         appBar: AppBar(
//           title: const Text('الصفحة الرئيسية'),
//         ),
//         body: controller.userRole == null
//             ? const Center(child: CircularProgressIndicator())
//             : GetBuilder<ControllerRolesHomeImp>(
//                 builder: (controller) => controller.buildRoleSpecificUI(),
//               ));

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/services/services.dart';
import 'package:school_management/view/controller/controller_roles.dart';
import 'package:school_management/core/constant/routes.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  // final Map<String, dynamic> userData;

  const HomePage({
    super.key,
    // required this.userData,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MyServices myServices = Get.find();
  String? userEmail;
  String? userName;
  int? userId;
  String? role;
  @override
  void initState() {
    super.initState();
    _getEmail();
  }

  Future<void> _getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      log("$prefs", name: 'predfs', error: prefs);
      userId = prefs.getInt("id");
      userEmail = prefs.getString('email') ?? 'غير معروف'; // البريد الإلكتروني
      userName = prefs.getString('name') ?? 'ضيف';
      role = prefs.getString('role') ?? 'ضيف';
      log("$userId", name: 'userId', error: userId);
      log("$role", name: 'role', error: role);
      log("$userName", name: 'userName', error: userName);
    });
  }

  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('name');
    await prefs.remove('role');
    await prefs.remove('id');
    log("$prefs", name: 'predfs', error: prefs);

    Get.offAllNamed(AppRoute.loginPage); // العودة إلى صفحة تسجيل الدخول
  }

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(ControllerRolesHomeImp());
    Get.put(ControllerRolesHomeImp());

    // final String role = widget.userData['role'] ?? 'guest';
    // final String email = widget.userData['email'] ?? 'unknown';

    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: const Text(
            'الصفحة الرئيسية',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              color: AppColors.black,
              onPressed: () {
                Get.dialog(
                    // context: context,
                    // builder: (context) =>
                    AlertDialog(
                  backgroundColor: AppColors.primaryColor,
                  title: const Text(
                    'تأكيد تسجيل الخروج',
                  ),
                  content: const Text('هل تريد  تسجيل الخروج ؟',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  actions: [
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
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
                        backgroundColor: WidgetStateProperty.all(
                            AppColors.backgroundIDsColor),
                      ),
                      onPressed: () async {
                        // Navigator.of(context).pop();
                        MyServices myServices = Get.find();

                        myServices.sharedPreferences.clear();

                        myServices.sharedPreferences
                            .setString("loginPage", "1");

                        Get.back();
                        logoutUser();
                        // Get.offAllNamed(AppRoute.loginPage);
                      },
                      child: const Text(
                        'خروج',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
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
        body: WillPopScope(
          onWillPop: () {
            Get.dialog(

                // context: context,
                // builder: (context) =>
                AlertDialog(
              shadowColor: AppColors.primaryColor,
              backgroundColor: AppColors.primaryColor,
              title: const Text(
                'تأكيد تسجيل الخروج',
              ),
              content: const Text(
                'هل تريد  تسجيل الخروج ؟',
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
                  onPressed: () => Get.back(),
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
                  onPressed: () async {
                    // Navigator.of(context).pop();
                    myServices.sharedPreferences.setString("loginPage", "1");

                    Get.back();
                    logoutUser();
                    // Get.offAllNamed(AppRoute.loginPage);
                  },
                  child: const Text(
                    'خروج',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.actionColor),
                  ),
                ),
              ],
            ));
            return Future.value(false);
          },
          child: GetBuilder<ControllerRolesHomeImp>(
            builder: (controller) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'اهلا بك، $userName',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    ' $userEmail',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    'دورك الحالي : $role',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  // if (role == 'admin') _adminWidgets(context),
                  if (role == 'admin') controller.widgetAdmin(),
                  // if (role == 'teacher') _teacherWidgets(context),
                  if (role == 'teacher') controller.widgetTeacher(),
                  // if (role == 'student') _studentWidgets(context),
                  if (role == 'student') controller.widgetStudent(),
                ],
              ),
            ),
          ),
        ));
  }
}
