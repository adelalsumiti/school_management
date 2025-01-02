import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/constant/imageAssets.dart';
import 'package:school_management/core/constant/routes.dart';

import 'package:school_management/view/widgets/home/card_home.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

abstract class ControllerRolesHome extends GetxController {
  widgetAdmin();
  widgetTeacher();
  widgetStudent();
  widgetFather();
  void initState();
}

class ControllerRolesHomeImp extends ControllerRolesHome {
  String? userRole;
  Future<void> fetchUserRole(String userId) async {
    // String? role = await getUserRole(userId);
    //  void setState({
    // userRole = role;
    // });
  }

  @override
  void initState() {
    // يجب استدعاء `fetchUserRole` هنا أو عند الحاجة
    const userId = "1"; // معرف المستخدم
    fetchUserRole(userId);
    //  super.initState();
  }

  //
  //
  Widget buildRoleSpecificUI() {
    switch (userRole) {
      case 'admin':
        return widgetAdmin();
      case 'teacher':
        return widgetTeacher();
      case 'father':
        return widgetFather();
      // case 'parent':
      case 'student':
        return widgetStudent();
      default:
        // return const LoginPage();
        return const Center(child: Text('دور المستخدم غير معروف.'));
    }
  }

  @override
  widgetAdmin() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 16.0, right: 16.0, left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'خيارات المدير :',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          GridView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.1,
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                // mainAxisExtent: 180,

                mainAxisSpacing: 5),
            children: [
              CardHome(
                onTap: () {
                  Get.toNamed(AppRoute.manageAccountsPage);
                },
                title: " إدارة الحسابات ",
                url: AppImageAsset.accounts,
              ),
              CardHome(
                  onTap: () {
                    Get.toNamed(AppRoute.manageTeachersPage);
                  },
                  url: AppImageAsset.users,
                  title: "إدارة المعلمين"),
              CardHome(
                onTap: () {
                  Get.toNamed(AppRoute.manageClassesPage);
                },
                title: 'إدارة الصفوف',
                url: AppImageAsset.classes,
              ),
              CardHome(
                onTap: () {
                  Get.toNamed(AppRoute.manageStudentsPage);
                },
                title: 'إدارة الطلاب',
                url: AppImageAsset.vendors,
              ),
              CardHome(
                onTap: () {
                  Get.toNamed(AppRoute.manageParentsPage);
                },
                title: 'إدارة أولياء الأمور',
                url: AppImageAsset.parent,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  widgetFather() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // عرض بيانات الطالب
              },
              child: const Text('عرض بيانات الطالب'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  widgetStudent() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 16.0, left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'خيارات الطالب:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 20),
            GridView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.only(right: 3, left: 1),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.1,
                  crossAxisCount: 2,
                  crossAxisSpacing: 3,
                  // mainAxisExtent: 180,

                  mainAxisSpacing: 3),
              children: [
                CardHome(
                  onTap: () {
                    Get.toNamed(AppRoute.studentReportsPage);
                  },
                  title: ('عرض التقارير'),
                  url: AppImageAsset.logo,
                ),
                // CardHome(
                //   onTap: () {
                //     Get.toNamed(AppRoute.teacherStudentsPage);
                //     // Get.to(() => const TeacherStudentsPage());
                //   },
                //   title: 'عرض الطلاب',
                //   url: AppImageAsset.users,
                // ),
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  @override
  widgetTeacher() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 5, bottom: 5, right: 8, left: 8),
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            boxShadow: const [BoxShadow(blurRadius: 3, spreadRadius: 2)],
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              'خيارات المعلم:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            GridView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.only(right: 3, left: 1),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.1,
                  crossAxisCount: 2,
                  crossAxisSpacing: 3,
                  // mainAxisExtent: 180,

                  mainAxisSpacing: 3),
              children: [
                CardHome(
                  onTap: () {
                    Get.toNamed(AppRoute.teacherDashboardPage);
                  },
                  title: ('عرض الصفوف الخاصة'),
                  url: AppImageAsset.classes,
                ),
                CardHome(
                  onTap: () {
                    Get.toNamed(AppRoute.teacherStudentsPage);
                    // Get.to(() => const TeacherStudentsPage());
                  },
                  title: 'عرض الطلاب',
                  url: AppImageAsset.users,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
    //
  }
}
