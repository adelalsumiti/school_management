import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:school_management/linkapi.dart';

class EditStudentPage extends StatefulWidget {
  const EditStudentPage({super.key});

  @override
  State<EditStudentPage> createState() => _EditStudentPageState();
}

class _EditStudentPageState extends State<EditStudentPage> {
  late TextEditingController nameController;
  late String? selectedClassId;
  late String? studentId;
  // List<dynamic> classes = [];
  List<dynamic> classList = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchClasses();

    // استلام بيانات الطالب من الصفحة السابقة
    Map<String, dynamic> student = Get.arguments;
    studentId = student['id'];
    nameController = TextEditingController(text: student['name']);
    selectedClassId = student['classId']; // تأكد أن المفتاح صحيح
  }

  // List<Map<String, dynamic>> classList = []; // قائمة الصفوف
  bool isLoadingClasses = true; // تحميل الصفوف

  Future<void> _fetchClasses() async {
    try {
      final response = await http.get(Uri.parse(AppLink.getNameClasses));
      if (response.statusCode == 200) {
        // final data = json.decode(response.body);
        List<dynamic> data = json.decode(response.body);
        setState(() {
          classList = data; // احتفظ بالصفوف المرسلة من السيرفر
          isLoadingClasses = false;
        });

        // if (data['success']) {
        //   setState(() {
        //     classList = List<Map<String, dynamic>>.from(data['classes']);
        //     isLoadingClasses = false;
        //   });
      } else {
        throw Exception('Failed to fetch classes');
      }
      // else {
      //   throw Exception('Failed to fetch classes');
      // }
    } catch (e) {
      debugPrint('Error fetching classes: $e');
      setState(() {
        isLoadingClasses = false;
      });
    }
  }

  Future<void> _updateStudent() async {
    setState(() {
      isLoading = true;
    });
    if (nameController.text.isEmpty || selectedClassId!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى ملء جميع الحقول')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(AppLink.editStudent),
        body: {
          'studentId': studentId,
          'name': nameController.text.trim(),
          'classId': selectedClassId, // يجب أن تكون القيمة محدثة
        },
      );

      final responseBody = json.decode(response.body);
      if (responseBody['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseBody['message'])),
        );
        Get.back();

        // Navigator.pop(context); // العودة للصفحة السابقة
      } else {
        throw Exception(responseBody['message']);
      }
    } catch (e) {
      debugPrint('Error updating student: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ أثناء تحديث بيانات الطالب: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعديل بيانات الطالب'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'اسم الطالب',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedClassId,
              items: classList.map((classItem) {
                return DropdownMenuItem<String>(
                  value: classItem['id'], // استخدم id كقيمة
                  child: Text(classItem['className']), // استخدم className كنص
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedClassId = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'اختر الصف',
                border: OutlineInputBorder(),
              ),
              hint: isLoadingClasses
                  ? const Text('جاري تحميل الصفوف...')
                  : const Text('اختر الصف'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى اختيار صف';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _updateStudent,
                    child: const Text('تحديث'),
                  ),
          ],
        ),
      ),
    );
  }
}
