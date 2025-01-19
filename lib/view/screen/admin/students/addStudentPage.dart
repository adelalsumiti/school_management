import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/core/class/handlingdataview.dart';
import 'package:school_management/view/controller/roleAdmin_Students.dart/controller_roleAdmin_Students.dart';

class AddStudentPage extends StatelessWidget {
  const AddStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(StudentsControllerImp());
    return Scaffold(
        appBar: AppBar(title: const Text('إضافة طالب إلى صف')),
        body: GetBuilder<StudentsControllerImp>(
            builder: (controller) => HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: controller.selectedStudent,
                        items: controller.students
                            .map<DropdownMenuItem<String>>((student) {
                          return DropdownMenuItem<String>(
                            value: student['id'].toString(),
                            child: Text(student['name'] ?? "s"),
                          );
                        }).toList(),
                        onChanged: (value) async {
                          controller.update();

                          controller.selectedStudent = value;
                          controller.update();
                        },
                        decoration:
                            const InputDecoration(labelText: 'اختر الطالب'),
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value: controller.selectedClass,
                        items: controller.classes
                            .map<DropdownMenuItem<String>>((classItem) {
                          return DropdownMenuItem<String>(
                            value: classItem['id'].toString(),
                            child: Text(classItem['className']),
                          );
                        }).toList(),
                        onChanged: (value) => controller.selectedClass = value,
                        decoration:
                            const InputDecoration(labelText: 'اختر الصف'),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: controller.addStudentToClass,
                        child: const Text('حفظ'),
                      ),
                    ],
                  ),
                )));
  }
}
