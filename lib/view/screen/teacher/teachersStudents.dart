import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/constant/routes.dart';
import 'package:school_management/view/controller/controller_teachers.dart';
// import 'package:school_management/linkApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherStudentsPage extends StatelessWidget {
  const TeacherStudentsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(TeachersControllerImp());
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: const Text(
            'الطلاب المرتبطين بك',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: GetBuilder<TeachersControllerImp>(
            builder: (controller) => controller.isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(
                              top: 10, bottom: 5, right: 10, left: 10),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              boxShadow: const [
                                BoxShadow(blurRadius: 3, spreadRadius: 2)
                              ],
                              borderRadius: BorderRadius.circular(20)),
                          child: ListView.builder(
                              itemCount: controller.teacherStudents.length,
                              itemBuilder: (context, index) {
                                final item = controller.teacherStudents[index];
                                // studentId = item['student_id'];
                                // prefs?.setInt('student_id', studentId!);
                                // log("studentId 111", error: studentId);

                                return Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 5, right: 10, left: 10),
                                  decoration: BoxDecoration(
                                      color: AppColors.backgroundIDsColor,
                                      boxShadow: const [
                                        BoxShadow(
                                            blurRadius: 3, spreadRadius: 2)
                                      ],
                                      borderRadius: BorderRadius.circular(20)),
                                  child: ListTile(
                                    title: Text(
                                      'الطالب: ${item['student_name']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      'الصف: ${item['class_name']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    leading: const Icon(Icons.person),
                                    onTap: () async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      controller.studentId = item['student_id'];
                                      controller.classId = item['class_id'];
                                      await prefs.setInt(
                                          'student_id', controller.studentId!);
                                      await prefs.setInt(
                                          'class_id', controller.classId!);
                                      log("studentId 111",
                                          error: controller.studentId);
                                      log("classId 111",
                                          error: controller.classId);

                                      Get.toNamed(AppRoute.detailReport);
                                    },
                                  ),
                                );
                              }),
                        ),
                      ),
                      const SizedBox(height: 40)
                    ],
                  )));
  }
}
