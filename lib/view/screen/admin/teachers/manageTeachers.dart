// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/core/class/handlingdataview.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/constant/routes.dart';
import 'package:school_management/view/controller/roleAdmin_Teachers/controller_roleAdmin_Teachers.dart';

class ManageTeachersPage extends StatelessWidget {
  ManageTeachersPage({super.key});

  TeachersControllerImp control = Get.put(TeachersControllerImp());

  @override
  Widget build(BuildContext context) {
    Get.put(TeachersControllerImp());
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (control.fetchTeachers() != null) {
              Get.toNamed(AppRoute.addTeacherPage);
            }
          },
          backgroundColor: AppColors.backgroundIDsColor,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('إدارة المعلمين'),
          actions: [
            IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () async {
                  control.fetchTeachers();
                }),
          ],
        ),
        body: GetBuilder<TeachersControllerImp>(
            builder: (controller) => HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: Column(
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
                                  hintText: 'ابحث عن معلم...',
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onTap: () async {
                                  controller.filterTeachers;
                                },
                                onChanged: controller
                                    .filterTeachers, // تنفيذ التصفية عند تغيير النص
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 55,
                              margin:
                                  const EdgeInsets.only(right: 10, left: 10),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: Border(
                                  bottom: BorderSide(color: Colors.black45),
                                  left: BorderSide(color: Colors.black45),
                                  right: BorderSide(color: Colors.black45),
                                  top: BorderSide(color: Colors.black45),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'عدد المعلمين: ${controller.originalTeachers.length}',
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
                          itemCount: controller.filteredTeachers.length,
                          itemBuilder: (context, index) {
                            final teacher = controller.filteredTeachers[index];
                            return ListTile(
                              title: Text('المعلم: ${teacher['teacher_name']}'),
                              subtitle: Text('الصف: ${teacher['class_name']}'),
                              trailing: Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 0.5, blurRadius: 4)
                                    ],
                                    color: Color.fromARGB(248, 255, 255, 255),
                                    border: Border.symmetric(
                                        horizontal: BorderSide(),
                                        vertical: BorderSide())),
                                child: IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: AppColors.actionColor),
                                    onPressed: () async {
                                      Get.defaultDialog(
                                          title: 'تأكيد الحذف',
                                          titlePadding: const EdgeInsets.only(
                                              right: 10,
                                              left: 100,
                                              top: 20,
                                              bottom: 20),
                                          textConfirm: "حذف",
                                          content: const Text(
                                            "هل تريد بالتأكيد حذف هذا المعلم ؟",
                                            style: TextStyle(
                                                color: AppColors.actionColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          cancel: TextButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: const Text(
                                                "الغاء",
                                                style: TextStyle(
                                                    color: AppColors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          confirm: MaterialButton(
                                            onPressed: () async {
                                              Get.back();
                                              int teacherId = int.parse(
                                                  teacher['id'].toString());

                                              await controller
                                                  .deleteTeacher(teacherId);
                                            },
                                            child: const Text(
                                              "حذف",
                                              style: TextStyle(
                                                  color: AppColors.actionColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ));
                                    }
                                    // deleteTeacher(teacher['teacher_id']),
                                    ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )));
  }
}
