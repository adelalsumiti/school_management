import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/core/constant/imageAssets.dart';
import 'package:school_management/core/constant/routes.dart';
import 'package:school_management/view/widgets/home/card_home.dart';

class HomeRoleStudent extends StatelessWidget {
  const HomeRoleStudent({super.key});

  @override
  Widget build(BuildContext context) {
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
}
