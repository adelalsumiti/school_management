// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/core/class/handlingdataview.dart';
import 'package:school_management/core/constant/routes.dart';
import 'package:school_management/view/controller/roleAdmin_Classes/controller_roleAdmin_Classes.dart';
import 'package:school_management/view/widgets/custom_IconButton_Delete.dart';

class ManageClassesPage extends StatelessWidget {
  ManageClassesPage({super.key});
  ClassesControllerImp control = Get.put(ClassesControllerImp());
  @override
  Widget build(BuildContext context) {
    Get.put(ClassesControllerImp());
    return Scaffold(
        appBar: AppBar(
          title: const Text('إدارة الصفوف'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () async {
                control.fetchClasses();
              },
            ),
          ],
        ),
        body: GetBuilder<ClassesControllerImp>(
            builder: (controller) => HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          'إدارة الصفوف',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child:
                                  // حقل البحث
                                  Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'ابحث عن صف...',
                                    prefixIcon: const Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onTap: () {
                                    controller.filterClasses;
                                  },
                                  onChanged: controller
                                      .filterClasses, // تنفيذ التصفية عند تغيير النص
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
                                    'عدد الصفوف: ${controller.originalClasses.length}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: controller.classNameController,
                                decoration: const InputDecoration(
                                  labelText: 'اسم الصف',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: controller.addClass,
                              child: const Text('إضافة'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // isLoading
                        //     ? const CircularProgressIndicator()
                        //     :
                        Expanded(
                          child: controller.filteredClasses.isEmpty
                              ? const Center(child: Text('لا توجد صفوف مضافة'))
                              : ListView.builder(
                                  // shrinkWrap: true,
                                  // itemCount: classes.length,
                                  itemCount: controller.filteredClasses.length,
                                  itemBuilder: (context, index) {
                                    final classDataa =
                                        controller.filteredClasses[index];
                                    return ListTile(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(classDataa['className']),
                                          Container(
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
                                              icon: const Icon(Icons.edit),
                                              color: Colors.black,
                                              onPressed: () async {
                                                // SharedPreferences prefs =
                                                //     await SharedPreferences
                                                //         .getInstance();
                                                controller.classId =
                                                    classDataa['id'];
                                                // await prefs.setString(
                                                //     'id_class',
                                                //     classDataa['id']
                                                //         .toString());
                                                controller.nameController.text =
                                                    classDataa['className'];
                                                //
                                                // await prefs.setString(
                                                //     'name_class',
                                                //     classDataa['className']
                                                //         .toString());

                                                Get.toNamed(
                                                        AppRoute.editClassPage,
                                                        arguments: classDataa)
                                                    ?.then((_) {
                                                  controller.fetchClasses();
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: CustomButtonDelete(
                                        titileMessage: 'تأكيد الحذف',
                                        bodyMessage:
                                            'هل أنت متأكد من حذف هذا الصف ؟',
                                        onPressedCancel: () => Get.back(),
                                        onPressedYes: () async {
                                          Get.back();
                                          controller
                                              .deleteClass(classDataa['id']);
                                        },
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                )));
  }
}
