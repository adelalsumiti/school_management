import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/constant/routes.dart';
import 'package:school_management/linkApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherStudentsPage extends StatefulWidget {
  // final int teacherId; // رقم المعلم المُسجل حاليًا

  const TeacherStudentsPage({
    super.key,
  });

  @override
  _TeacherStudentsPageState createState() => _TeacherStudentsPageState();
}

class _TeacherStudentsPageState extends State<TeacherStudentsPage> {
  // late Future<List<Map<String, dynamic>>> teacherStudents;
  List<dynamic> teacherStudents = [];
  List<dynamic> responsev = [];
  bool isLoading = true;
  SharedPreferences? prefs;

  int? userId;
  int? studentId;
  int? classId;

  Future<void> fetchTeacherStudents(teacherId) async {
    isLoading = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt("id");
    final url =
        '${AppLink.fetchTeacherStudents}?teacher_id=$userId'; // ضع الرابط الصحيح هنا
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      isLoading = false;

      final data = json.decode(response.body);
      // List<Map<String, dynamic>> students = await fetchTeacherStudents(userId);

      // for (var student in students) {
      //   print(
      //       'Student: ${student['student_name']}, Class: ${student['class_name']}');
      // // }
      // final data = json.decode(response.body);

      if (data['success']) {
        // teacherStudents = data['data'];
        setState(() {
          teacherStudents = data['data'];
          // studentId = data['student_id'];

          // prefs.setInt('student_id', studentId!);

          // data['data'];

          // teacherStudents = data['class_name'];
        });
        // prefs.setInt('student_id', studentId!);
        // userId = data['id'];
        // studentId = data['student_id'];
        log("studentId", error: studentId);

        // teacherStudents = data['data'];
        // teacherStudents = data['data'];
        // print('Data received: ${data['data']}');
        print('Data received teacherStudents: $teacherStudents');

        // print(data); // طباعة البيانات للتحقق
        // if (data['success']) {
        //   return List<Map<String, dynamic>>.from(data['data']);
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception('Failed to load teacher students');
    }
  }

  @override
  void initState() {
    super.initState();
    final response = fetchTeacherStudents(userId);
    print(response);

    // استدعاء API لجلب الطلاب المرتبطين بالصفوف التي يدرّسها المعلم
    // teacherStudents =
    // fetchTeacherStudents as Future<List<Map<String, dynamic>>>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: const Text(
            'الطلاب المرتبطين بك',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: isLoading == true
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
                          itemCount: teacherStudents.length,
                          itemBuilder: (context, index) {
                            final item = teacherStudents[index];
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
                                    BoxShadow(blurRadius: 3, spreadRadius: 2)
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
                                  studentId = item['student_id'];
                                  classId = item['class_id'];
                                  await prefs.setInt('student_id', studentId!);
                                  await prefs.setInt('class_id', classId!);
                                  log("studentId 111", error: studentId);
                                  log("classId 111", error: classId);

                                  Get.toNamed(AppRoute.detailReport
                                      // AppRoute.addReportPage,
                                      //  arguments: {
                                      //   "studentId": studentId,
                                      //   "id": userId
                                      // }
                                      );
                                },
                              ),
                            );
                          }),
                    ),
                  ),
                  const SizedBox(height: 40)
                ],
              ));
  }
}
