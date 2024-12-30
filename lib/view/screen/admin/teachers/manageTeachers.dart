import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/constant/routes.dart';
import 'package:school_management/linkApi.dart';

class ManageTeachersPage extends StatefulWidget {
  const ManageTeachersPage({super.key});

  @override
  State<ManageTeachersPage> createState() => _ManageTeachersPageState();
}

class _ManageTeachersPageState extends State<ManageTeachersPage> {
  List<dynamic> teachers = [];
  List<dynamic> originalTeachers = []; // قائمة المعلمين الأصلية
  List<dynamic> filteredTeachers = []; // قائمة المعلمين المفلترة

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTeachers();
  }

  Future<void> fetchTeachers() async {
    isLoading = true;
    final response = await http.get(Uri.parse(AppLink.getTeachersWithClasses));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        isLoading = false;

        setState(() {
          teachers = data['teachers'];
          log("$teachers", name: 'teachers');

          originalTeachers = teachers;
          filteredTeachers = originalTeachers;
          isLoading = false;
        });
      }
    }
  }

  Future<void> deleteTeacher(teacherId) async {
    final response = await http.post(
      Uri.parse(AppLink.deleteTeacherFromClass),
      body: {'id': teacherId.toString()},
    );
    final data = json.decode(response.body);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(data['message'])),
    );
    fetchTeachers();
  }
  //

  /// تصفية قائمة المعلمين بناءً على النص المدخل
  void _filterTeachers(String query) async {
    setState(() {
      if (query.isEmpty) {
        // إذا كان النص فارغًا، عرض القائمة الأصلية
        filteredTeachers = originalTeachers;
      } else {
        // تصفية المعلمين بناءً على النص المدخل
        filteredTeachers = originalTeachers.where((teacher) {
          final name = teacher['teacher_name']?.toLowerCase() ?? '';
          final className = teacher['class_name']?.toLowerCase() ?? '';
          return name.contains(query.toLowerCase()) ||
              className.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoute.addTeacherPage);
        },
        backgroundColor: AppColors.backgroundIDsColor,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('إدارة المعلمين'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // إعادة بناء الصفحة

              setState(() {
                fetchTeachers();
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
                            hintText: 'ابحث عن معلم...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onTap: () {
                            _filterTeachers;
                          },
                          onChanged:
                              _filterTeachers, // تنفيذ التصفية عند تغيير النص
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
                            'عدد المعلمين: ${originalTeachers.length}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredTeachers.length,
                    itemBuilder: (context, index) {
                      final teacher = filteredTeachers[index];
                      return ListTile(
                        title: Text('المعلم: ${teacher['teacher_name']}'),
                        subtitle: Text('الصف: ${teacher['class_name']}'),
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
                              icon: const Icon(Icons.delete,
                                  color: AppColors.actionColor),
                              onPressed: () async {
                                Get.defaultDialog(
                                    title: 'تأكيد الحذف',
                                    titlePadding: const EdgeInsets.only(
                                        right: 10,
                                        left: 100,
                                        top: 20,
                                        bottom: 20),
                                    textConfirm: "حذف",
                                    content: const Text(
                                      "هل تريد بالتأكيد حذف هذا المعلم ؟",
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
                                        deleteTeacher(teacher['id']);
                                      },
                                      child: const Text(
                                        "حذف",
                                        style: TextStyle(
                                            color: AppColors.actionColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ));
                                //
                                //
                              }
                              // deleteTeacher(teacher['teacher_id']),
                              ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
