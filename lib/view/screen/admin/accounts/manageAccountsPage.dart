import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/view/controller/controller_account.dart';
import 'package:school_management/view/widgets/accounts/accountsList.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  // String? selectedCategory;

  // String selectedCategory =
  // ('admin' 'teacher' 'father' 'student'); // القسم الافتراضي
  // String selectedCategory; // القسم الافتراضي
  // final controller = Get.put(ManageAccountsControllerImp());

  @override
  Widget build(BuildContext context) {
    Get.put(ManageAccountsControllerImp());
    // setState(() {
    // controller.selectedCategoryy == "admin";
    // });

    return Scaffold(
        // bottomNavigationBar:
        appBar: AppBar(
          title: const Text('إدارة الحسابات'),
        ),
        body: GetBuilder<ManageAccountsControllerImp>(
          builder: (controller) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              controller.selectedCategoryy == 'admin'
                  ? const Expanded(
                      child: AccountsList(),
                    )
                  : controller.selectedCategoryy == 'teacher'
                      ? const Expanded(
                          child: AccountsList(),
                        )
                      : controller.selectedCategoryy == 'father'
                          ? const Expanded(
                              child: AccountsList(),
                            )
                          : controller.selectedCategoryy == 'student'
                              ? const Expanded(
                                  child: AccountsList(),
                                )
                              : controller.selectedCategoryy == 'blocked'
                                  ? const Expanded(
                                      child: AccountsList(),
                                    )
                                  : Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        child: const Center(
                                          child: Icon(Icons.face),
                                        ),
                                      ),
                                    ),
              BottomAppBar(
                notchMargin: 1,
                height: 85,
                padding: const EdgeInsets.all(.5),
                elevation: 20,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 10, right: 1, left: 1),
                  decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(color: Colors.grey.shade300)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: BottomSheetButton(
                          label: 'الإدارة',
                          isSelected: controller.selectedCategoryy == 'admin',
                          onTap: () async {
                            controller.changeCategory("admin");
                          },
                        ),
                      ),
                      Expanded(
                        child: BottomSheetButton(
                          label: 'المعلمين',
                          isSelected: controller.selectedCategoryy == "teacher",
                          onTap: () async {
                            controller.changeCategory("teacher");
                          },
                        ),
                      ),
                      Expanded(
                        child: BottomSheetButton(
                          label: 'الآباء',
                          isSelected: controller.selectedCategoryy == 'father',
                          onTap: () async {
                            controller.changeCategory("father");
                          },
                        ),
                      ),
                      Expanded(
                        child: BottomSheetButton(
                          label: 'الطلاب',
                          isSelected: controller.selectedCategoryy == 'student',
                          onTap: () async {
                            controller.changeCategory("student");
                          },
                        ),
                      ),
                      Expanded(
                        child: BottomSheetButton(
                          label: 'المحظورة',
                          isSelected: controller.selectedCategoryy == 'blocked',
                          onTap: () async {
                            controller.changeCategory("blocked");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //   Expanded(
              //     child: Container(
              //       padding: const EdgeInsets.only(bottom: 10, right: 3, left: 3),
              //       decoration: BoxDecoration(
              //         border:
              //             Border(top: BorderSide(color: Colors.grey.shade300)),
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           BottomSheetButton(
              //             label: 'الإدارة',
              //             isSelected: controller.selectedCategoryy == 'admin',
              //             onTap: () async {
              //               controller.changeCategory("admin");
              //             },
              //           ),
              //           BottomSheetButton(
              //             label: 'المعلمين',
              //             isSelected: controller.selectedCategoryy == "teacher",
              //             onTap: () async {
              //               controller.changeCategory("teacher");
              //             },
              //           ),
              //           BottomSheetButton(
              //             label: 'الآباء',
              //             isSelected: controller.selectedCategoryy == 'father',
              //             onTap: () async {
              //               controller.changeCategory("father");
              //             },
              //           ),
              //           BottomSheetButton(
              //             label: 'الطلاب',
              //             isSelected: controller.selectedCategoryy == 'student',
              //             onTap: () async {
              //               controller.changeCategory("student");
              //             },
              //           ),
              //           BottomSheetButton(
              //             label: 'المحظورة',
              //             isSelected: controller.selectedCategoryy == 'blocked',
              //             onTap: () async {
              //               controller.changeCategory("blocked");
              //             },
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
            ],
          ),
        ));
  }
}

class BottomSheetButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const BottomSheetButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(ManageAccountsControllerImp());
    return GetBuilder<ManageAccountsControllerImp>(
        builder: (controller) => GestureDetector(
            onTap: onTap,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 65,
                  // width: 150,
                  margin: const EdgeInsets.only(right: 2, left: .5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(5),
                    // shape: BoxShape.rectangle,
                    boxShadow: const [BoxShadow(blurRadius: 1)],
                    color:
                        isSelected ? AppColors.blue : AppColors.bottomBarColor,
                    // )
                  ),

                  child: Center(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
                if (isSelected)
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
              ],
            )));
  }
}
