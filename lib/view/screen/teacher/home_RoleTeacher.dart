import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/constant/imageAssets.dart';
import 'package:school_management/core/constant/routes.dart';
import 'package:school_management/view/widgets/home/card_home.dart';

class HomeRoleTeacher extends StatelessWidget {
  const HomeRoleTeacher({super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}
