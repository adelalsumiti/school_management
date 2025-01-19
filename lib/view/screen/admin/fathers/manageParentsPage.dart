// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/core/class/handlingdataview.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/constant/routes.dart';
import 'package:school_management/view/controller/roleAdmin_Fathers/controller_roleAdmin_Fathers.dart';

class ManageParentsPage extends StatelessWidget {
  ManageParentsPage({super.key});
  FathersControllerImp control = Get.put(FathersControllerImp());
  @override
  Widget build(BuildContext context) {
    Get.put(FathersControllerImp());
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(AppRoute.addParentPage);
          },
          backgroundColor: AppColors.backgroundIDsColor,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('أولياء الأمور والطلاب'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () async {
                // إعادة بناء الصفحة

                control.fetchRelationShips();
              },
            ),
          ],
        ),
        body: GetBuilder<FathersControllerImp>(
            builder: (controller) => HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: controller.relationships.isEmpty
                      ? const Center(child: Text('لا توجد بيانات حالياً'))
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child:
                                      // حقل البحث
                                      Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'ابحث عن ولي أمر...',
                                        prefixIcon: const Icon(Icons.search),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onTap: () {
                                        controller.filterParents;
                                      },
                                      onChanged: controller
                                          .filterParents, // تنفيذ التصفية عند تغيير النص
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 55,
                                    margin: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      border: Border(
                                        bottom:
                                            BorderSide(color: Colors.black45),
                                        left: BorderSide(color: Colors.black45),
                                        right:
                                            BorderSide(color: Colors.black45),
                                        top: BorderSide(color: Colors.black45),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'عدد أولياء الأمور: ${controller.originalParents.length}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: controller.filteredParents.length,
                                itemBuilder: (context, index) {
                                  final relationship =
                                      controller.filteredParents[index];
                                  return ListTile(
                                    leading: const Icon(Icons.family_restroom),
                                    title: Text(
                                        'ولي الأمر: ${relationship['parent_name']}'), // اسم ولي الأمر
                                    subtitle: Text(
                                        'الطالب: ${relationship['student_name']}'),
                                    trailing: Container(
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                                spreadRadius: 0.5,
                                                blurRadius: 4)
                                          ],
                                          color: Color.fromARGB(
                                              248, 255, 255, 255),
                                          border: Border.symmetric(
                                              horizontal: BorderSide(),
                                              vertical: BorderSide())),
                                      child: IconButton(
                                          onPressed: () {
                                            Get.defaultDialog(
                                                title: 'تأكيد الحذف',
                                                titlePadding:
                                                    const EdgeInsets.only(
                                                        right: 10,
                                                        left: 100,
                                                        top: 20,
                                                        bottom: 20),
                                                textConfirm: "حذف",
                                                content: const Text(
                                                  "هل تريد بالتأكيد حذف ولي الأمر هذا ؟",
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.actionColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                cancel: TextButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: const Text(
                                                      "الغاء",
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                confirm: MaterialButton(
                                                  onPressed: () {
                                                    Get.back();
                                                    controller.deleteFather(
                                                        relationship['id']);
                                                  },
                                                  child: const Text(
                                                    "حذف",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .actionColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ));
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: AppColors.actionColor,
                                          )),
                                    ), // اسم الطالب
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                )));
  }
}
