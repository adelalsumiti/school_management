import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/core/class/handlingdataview.dart';
import 'package:school_management/view/controller/roleAdmin/controller_roleAdmin_Classes.dart';

class EditClassPage extends StatelessWidget {
  const EditClassPage({super.key});
  // ClassesControllerImp control = Get.put(ClassesControllerImp());
  @override
  Widget build(BuildContext context) {
    Get.put(ClassesControllerImp());
    return Scaffold(
        appBar: AppBar(
          title: const Text('تعديل بيانات الصف'),
        ),
        body: GetBuilder<ClassesControllerImp>(
            builder: (controller) => HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: controller.nameController,
                          decoration: const InputDecoration(
                            labelText: 'اسم الصف',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const SizedBox(height: 20),
                        // isLoading
                        //     ? const CircularProgressIndicator()
                        //     :
                        ElevatedButton(
                          onPressed: controller.updateClass,
                          child: const Text('تحديث'),
                        ),
                      ],
                    ),
                  ),
                )));
  }
}
