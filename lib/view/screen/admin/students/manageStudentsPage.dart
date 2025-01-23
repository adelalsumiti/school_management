// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/core/class/handlingdataview.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/view/controller/roleAdmin/controller_roleAdmin_Students.dart';

class ManageStudentsPage extends StatelessWidget {
  ManageStudentsPage({super.key});
  StudentsControllerImp control = Get.put(StudentsControllerImp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: control.navigateToAddStudent,
          backgroundColor: AppColors.backgroundIDsColor,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('قائمة الطلاب '),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () async {
                control.fetchStudentsWithClasses();
              },
            ),
          ],
        ),
        body: GetBuilder<StudentsControllerImp>(
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
                                hintText: 'ابحث عن طالب...',
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onTap: () {
                                controller.filterStudents;
                              },
                              onChanged: controller
                                  .filterStudents, // تنفيذ التصفية عند تغيير النص
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 55,
                            margin: const EdgeInsets.only(right: 10, left: 10),
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
                                'عدد الطلاب: ${controller.originalStudents.length}',
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
                        itemCount: controller.filteredStudents.length,
                        itemBuilder: (context, index) {
                          final student = controller.filteredStudents[index];
                          return ListTile(
                            title: Text('الطالب: ${student['student_name']}'),
                            subtitle: Text('الصف: ${student['class_name']}'),
                            trailing: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(spreadRadius: 0.5, blurRadius: 4)
                                  ],
                                  color: Color.fromARGB(248, 255, 255, 255),
                                  border: Border.symmetric(
                                      horizontal: BorderSide(),
                                      vertical: BorderSide())),
                              child: IconButton(
                                  onPressed: () {
                                    // print(
                                    //     ("student_id ${filteredStudents[index]['student_id']}"));
                                    // _deleteStudent(student['id']);

                                    Get.defaultDialog(
                                        title: 'تأكيد الحذف',
                                        titlePadding: const EdgeInsets.only(
                                            right: 10,
                                            left: 100,
                                            top: 20,
                                            bottom: 20),
                                        textConfirm: "حذف",
                                        content: const Text(
                                          "هل تريد بالتأكيد حذف هذا الطالب ؟",
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
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        confirm: MaterialButton(
                                          onPressed: () {
                                            Get.back();
                                            controller
                                                .deleteStudent(student['id']);
                                          },
                                          child: const Text(
                                            "حذف",
                                            style: TextStyle(
                                                color: AppColors.actionColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ));
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: AppColors.actionColor,
                                  )),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ))));
  }
}
