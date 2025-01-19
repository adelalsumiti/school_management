import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/core/constant/imageAssets.dart';
import 'package:school_management/core/constant/routes.dart';
import 'package:school_management/view/widgets/home/card_home.dart';

class HomeRoleAdmin extends StatelessWidget {
  const HomeRoleAdmin({super.key});

  @override
  Widget build(BuildContext context) {
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
}
