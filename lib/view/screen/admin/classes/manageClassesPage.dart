// ignore: file_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_management/core/constant/routes.dart';

import 'package:school_management/linkapi.dart'; // رابط API الخاص بك

class ManageClassesPage extends StatefulWidget {
  const ManageClassesPage({super.key});

  @override
  State<ManageClassesPage> createState() => _ManageClassesPageState();
}

class _ManageClassesPageState extends State<ManageClassesPage> {
  final TextEditingController classNameController = TextEditingController();
  List<dynamic> classes = [];
  List<dynamic> originalClasses = []; // قائمة المعلمين الأصلية
  List<dynamic> filteredClasses = []; // قائمة المعلمين المفلترة

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchClasses();
  }

  Future<void> _fetchClasses() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(AppLink.getClasses));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          setState(() {
            setState(() {
              originalClasses = data['classes'];

              // originalClasses = responseBody['data'];
              filteredClasses = originalClasses; // نسخ البيانات إلى قائمة البحث
            });
            // classes = data['classes'];
          });
        } else {
          throw Exception('فشل في جلب البيانات');
        }
      } else {
        throw Exception('فشل في الاتصال بالخادم');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _addClass() async {
    if (classNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى إدخال اسم الصف')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(AppLink.addClass),
        body: {'className': classNameController.text.trim()},
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تمت إضافة الصف بنجاح!')),
        );
        classNameController.clear();
        _fetchClasses();
      } else {
        throw Exception(data['message'] ?? 'فشل في إضافة الصف');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الاسم موجود من قبل')),
      );
    }
  }

  Future<void> _deleteClass(String classId) async {
    try {
      final response = await http.post(
        Uri.parse(AppLink.deleteClass),
        // body: {'classId': classId},
        body: {'classId': classId},
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم حذف الصف بنجاح!')),
        );
        _fetchClasses();
      } else {
        throw Exception(data['message'] ?? 'فشل في حذف الصف');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('مرتبط ببيانات أخرى')),
      );
    }
  }

  //

  /// تصفية قائمة المعلمين بناءً على النص المدخل
  void _filterClasses(String query) async {
    setState(() {
      if (query.isEmpty) {
        // إذا كان النص فارغًا، عرض القائمة الأصلية
        filteredClasses = originalClasses;
      } else {
        // تصفية المعلمين بناءً على النص المدخل
        filteredClasses = originalClasses.where((classId) {
          // final name = teacher['name']?.toLowerCase() ?? '';
          final className = classId['className']?.toLowerCase() ?? '';
          return
              // name.contains(query.toLowerCase()) ||
              className.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الصفوف'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // إعادة بناء الصفحة

              setState(() {
                _fetchClasses();
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'إدارة الصفوف',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                        _filterClasses;
                      },
                      onChanged: _filterClasses, // تنفيذ التصفية عند تغيير النص
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
                        'عدد الصفوف: ${originalClasses.length}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
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
                    controller: classNameController,
                    decoration: const InputDecoration(
                      labelText: 'اسم الصف',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addClass,
                  child: const Text('إضافة'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: filteredClasses.isEmpty
                        ? const Center(child: Text('لا توجد صفوف مضافة'))
                        : ListView.builder(
                            // itemCount: classes.length,
                            itemCount: filteredClasses.length,
                            itemBuilder: (context, index) {
                              final classData = filteredClasses[index];
                              return ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(classData['className']),
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
                                        onPressed: () {
                                          Get.toNamed(AppRoute.editClassPage,
                                                  arguments: classData)
                                              ?.then((_) {
                                            _fetchClasses();
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),

                                trailing: Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 0.5, blurRadius: 4)
                                      ],
                                      color: Color.fromARGB(248, 255, 255, 255),
                                      border: Border.symmetric(
                                          horizontal: BorderSide(),
                                          vertical: BorderSide())),
                                  child: IconButton(
                                    icon: const Icon(Icons.delete),
                                    // color: Colors.red,
                                    color: Colors.red[700],

                                    // onPressed: () => _deleteTeacher(teacher['id']),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('تأكيد الحذف'),
                                          content: const Text(
                                              'هل أنت متأكد من حذف هذا الصف ؟'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  // Navigator.of(context).pop(),
                                                  Get.back(),
                                              child: const Text('إلغاء'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                // Navigator.of(context).pop();
                                                Get.back();
                                                // _deleteClass(docId);
                                                _deleteClass(classData['id']);
                                              },
                                              child: const Text(
                                                'حذف',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                // trailing: IconButton(
                                //   icon: const Icon(Icons.delete,
                                //       color: Colors.red),
                                //   onPressed: () =>
                                //       _deleteClass(classData['id']),
                                // ),
                              );
                            },
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}
