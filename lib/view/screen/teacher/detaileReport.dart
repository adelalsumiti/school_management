import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/constant/routes.dart';
import 'package:school_management/linkapi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DetailReport extends StatefulWidget {
  const DetailReport({super.key});

  @override
  State<DetailReport> createState() => _DetailReportState();
}

class _DetailReportState extends State<DetailReport> {
  List<dynamic> reportStudent = [];
  List<dynamic> responsev = [];
  bool isLoading = true;
  SharedPreferences? prefs;
  int? userId;
  int? studentId;
  int? classId;

  fetchReportStudent() async {
    isLoading = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentId = prefs.getInt("student_id");
    final url =
        // '${AppLink.getReportStudent}?student_id=$studentId'; // ضع الرابط الصحيح هنا
        '${AppLink.getReports}?student_id=$studentId'; // ضع الرابط الصحيح هنا
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      isLoading = false;

      final data = json.decode(response.body);

      if (data['success']) {
        // reportStudent = data['data'];
        setState(() {
          reportStudent = data['data'];
        });
        // prefs.setInt('student_id', studentId!);
        // userId = data['id'];
        // studentId = data['student_id'];
        log("studentId", error: studentId);

        // reportStudent = data['data'];
        // reportStudent = data['data'];
        // print('Data received: ${data['data']}');
        print('Data received reportStudent: $reportStudent');

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
    fetchReportStudent();

    // استدعاء API لجلب الطلاب المرتبطين بالصفوف التي يدرّسها المعلم
    // reportStudent =
    // fetchreportStudent as Future<List<Map<String, dynamic>>>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      floatingActionButton: FloatingActionButton(
          // backgroundColor: AppColors.black,

          backgroundColor: AppColors.backgroundIDsColor,
          onPressed: () {
            Get.toNamed(AppRoute.addReportPage);
          },
          child: const Text(
            "تقرير\nجديد",
            style:
                TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
          )
          //  const Icon(
          //   Icons.add,
          // color: AppColors.backgroundIDsColor,
          // )
          ),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          "التقارير",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
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
                        itemCount: reportStudent.length,
                        itemBuilder: (context, index) {
                          final item = reportStudent[index];

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
                              selected: true,
                              selectedColor: AppColors.black,

                              title: Text(
                                'التقييم: ${item['assessment']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'الملاحظة: ${item['note']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              // leading: Text('التاريخ: ${item['date']}'),
                              leading: Text(
                                ' ${item['date']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              // onTap: () async {
                              //   SharedPreferences prefs =
                              //       await SharedPreferences.getInstance();
                              //   studentId = item['student_id'];
                              //   classId = item['class_id'];
                              //   await prefs.setInt('student_id', studentId!);
                              //   await prefs.setInt('class_id', classId!);
                              //   log("studentId 111", error: studentId);
                              //   log("classId 111", error: classId);
                              // }
                            ),
                          );
                        }),
                  ),
                ),
                const SizedBox(height: 40)
              ],
            ),
    );
  }
}
