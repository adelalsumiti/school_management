import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/core/class/handlingdataview.dart';
import 'package:school_management/view/controller/roleAdmin_Fathers/controller_roleAdmin_Fathers.dart';

class AddParentPage extends StatelessWidget {
  const AddParentPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FathersControllerImp());
    return Scaffold(
        appBar: AppBar(title: const Text('إدارة أولياء الأمور')),
        body: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            child: GetBuilder<FathersControllerImp>(
              builder: (controller) => HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: Column(
                  children: [
                    const SizedBox(height: 40),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: controller.selectedParent,
                      items: controller.parents
                          .map<DropdownMenuItem<String>>((parent) {
                        return DropdownMenuItem<String>(
                          value: parent['id'].toString(),
                          child: Text(parent['name']),
                        );
                      }).toList(),
                      onChanged: (value) => controller.selectedParent = value,
                      decoration:
                          const InputDecoration(labelText: 'اختر ولي الأمر'),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: controller.selectedStudent,
                      items: controller.students
                          .map<DropdownMenuItem<String>>((student) {
                        return DropdownMenuItem<String>(
                          value: student['id'].toString(),
                          child: Text(student['name']),
                        );
                      }).toList(),
                      onChanged: (value) => controller.selectedStudent = value,
                      decoration:
                          const InputDecoration(labelText: 'اختر الطالب'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: controller.addFatherToStudent,
                      child: const Text('حفظ'),
                    ),
                  ],
                ),
              ),
            )));
  }
}
