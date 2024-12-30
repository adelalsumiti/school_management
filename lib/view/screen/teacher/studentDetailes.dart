import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_management/core/constant/routes.dart';
import 'package:school_management/linkapi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentDetailsPage extends StatefulWidget {
  // final int studentId;
  // final int teacherId;

  const StudentDetailsPage({
    super.key,
    // required this.studentId, required this.teacherId
  });

  @override
  State<StudentDetailsPage> createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {
  // int? userId;
  int? studentId;
  bool isLoading = true;
  List<dynamic> studentData = [];

  int? teacherId;
  // SharedPreferences? prefs;

  //  SharedPreferences prefs = await SharedPreferences.getInstance();
  Future<void> fetchReports(student) async {
    isLoading = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    teacherId = prefs.getInt("id");
    studentId = prefs.getInt("student_id");
    log("$teacherId", name: 'teacherId', error: teacherId);
    log("$studentId", name: 'studentId', error: studentId);
    final response = await http.get(
      Uri.parse(
          '${AppLink.getReports}?student_id=$studentId steacher_id=$teacherId'),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['success']) {
        isLoading = false;
        studentData = jsonData['data'];
        log("$studentData", name: 'studentData', error: studentData);

        // return jsonData['data'];
      } else {
        throw Exception(jsonData['message']);
      }
    } else {
      throw Exception('Failed to fetch reports');
    }
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;

    fetchReports(teacherId);

    // SharedPreferences prefs =  SharedPreferences.getInstance();
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    // teacherId = prefs.getInt("id");
    // studentId = prefs.getInt("student_id");
    log("$teacherId", name: 'teacherId', error: "$teacherId ");
    log(name: "studentId", "$studentId", error: "$studentId");
    // استدعاء API لجلب الصفوف الخاصة بالمعلم المُسجل
    // teacherClasses = fetchTeacherClasses("id");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تفاصيل الطالب')),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                // جدول عرض التقارير
                Expanded(
                  child: FutureBuilder(
                    future: fetchReports(studentId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('حدث خطأ!'));
                      } else {
                        final reports = snapshot.data as List;
                        return ListView.builder(
                          itemCount: reports.length,
                          itemBuilder: (context, index) {
                            final report = reports[index];
                            return ListTile(
                              title: Text('التقييم: ${report['assessment']}'),
                              subtitle: Text('ملاحظة: ${report['note']}'),
                              trailing: Text('التاريخ: ${report['date']}'),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                // زر الإضافة
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoute.addReportPage, arguments: [
                      {"studentId": studentId, "teacherId": teacherId}
                    ]);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => AddReportPage(
                    //       studentId: studentId,
                    //       teacherId: teacherId,
                    //     ),
                    //   ),
                    // );
                  },
                  child: const Text('إضافة تقرير'),
                ),
              ],
            ),
    );
  }
}
