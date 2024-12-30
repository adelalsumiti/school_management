import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/constant/routes.dart';
import 'dart:convert';

import 'package:school_management/linkapi.dart';

class ManageStudentsPage extends StatefulWidget {
  const ManageStudentsPage({super.key});

  @override
  State<ManageStudentsPage> createState() => _ManageStudentsPageState();
}

class _ManageStudentsPageState extends State<ManageStudentsPage> {
  List<dynamic> studentsWithClasses = [];
  List<dynamic> originalStudents = []; // قائمة الطلاب الأصلية
  List<dynamic> filteredStudents = []; // قائمة الطلاب المفلترة

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStudentsWithClasses();
  }
  //

  // دالة حذف الطالب
  Future<void> deleteStudent(studentId) async {
    final response = await http.post(
      Uri.parse(AppLink.deleteStudent),
      body: {'id': studentId.toString()},
    );
    log("$response", name: "student_id");
    final data = json.decode(response.body);

    if (data['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'])),
      );
      fetchStudentsWithClasses(); // إعادة تحميل القائمة بعد الحذف
    } else {
      log("$response", name: "student_id");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'])),
      );
    }
    log("$response", name: "student_id");
  }

  /// الانتقال إلى صفحة إضافة طالب جديد
  void _navigateToAddStudent() {
    // Navigator.pushNamed(context, '/addStudent').then((_) {
    //   _fetchStudents();
    // });
    Get.toNamed(AppRoute.addStudentPage)?.then((_) {
      // _fetchStudents();
      fetchStudentsWithClasses();
    });
  }

  //

  /// تصفية قائمة الطلاب بناءً على النص المدخل
  void _filterStudents(String query) async {
    setState(() {
      if (query.isEmpty) {
        // إذا كان النص فارغًا، عرض القائمة الأصلية
        filteredStudents = originalStudents;
      } else {
        // تصفية الطلاب بناءً على النص المدخل
        filteredStudents = originalStudents.where((student) {
          final name = student['student_name']?.toLowerCase() ?? '';
          final className = student['class_name']?.toLowerCase() ?? '';
          return name.contains(query.toLowerCase()) ||
              className.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  //

  // دالة جلب البيانات من السيرفر
  Future<void> fetchStudentsWithClasses() async {
    isLoading = true;
    final response = await http.get(Uri.parse(AppLink.getStudentsWithClasses));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        isLoading = false;
        setState(() {
          studentsWithClasses = data['data'];
          log("$studentsWithClasses", name: 'studentsWithClasses');

          originalStudents = studentsWithClasses;
          filteredStudents = originalStudents;
          isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'])),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('فشل في الاتصال بالخادم.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _navigateToAddStudent,
          backgroundColor: AppColors.backgroundIDsColor,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('قائمة الطلاب '),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                // إعادة بناء الصفحة

                setState(() {
                  fetchStudentsWithClasses();
                });
              },
            ),
          ],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
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
                              _filterStudents;
                            },
                            onChanged:
                                _filterStudents, // تنفيذ التصفية عند تغيير النص
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 55,
                          margin: const EdgeInsets.only(right: 10, left: 10),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border(
                              bottom: BorderSide(color: Colors.black45),
                              left: BorderSide(color: Colors.black45),
                              right: BorderSide(color: Colors.black45),
                              top: BorderSide(color: Colors.black45),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'عدد الطلاب: ${originalStudents.length}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredStudents.length,
                      itemBuilder: (context, index) {
                        final student = filteredStudents[index];
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
                                          deleteStudent(student['id']);
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
              ));
  }
}
