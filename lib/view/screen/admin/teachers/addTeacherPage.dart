// //ignore_for_file: file_names

// // ignore_for_file: unused_import

// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:school_management/linkApi.dart';
// import 'dart:convert';

// // import 'linkapi.dart';

// class AddTeacherPage extends StatefulWidget {
//   const AddTeacherPage({super.key});

//   @override
//   State<AddTeacherPage> createState() => _AddTeacherPageState();
// }

// class _AddTeacherPageState extends State<AddTeacherPage> {
//   final TextEditingController teacherNameController = TextEditingController();
//   List<dynamic> classes = [];
//   // List<Map<String, dynamic>> classes = []; // قائمة الصفوف
//   bool isLoadingClasses = true; // تحميل الصفوف

//   String? selectedClassId;
//   bool isLoading = false;
//   // bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchClasses();
//   }

// //
//   Future<void> _fetchClasses() async {
//     try {
//       var response = await http.get(Uri.parse(AppLink.getNameClasses));
//       if (response.statusCode == 200) {
//         List<dynamic> data = json.decode(response.body);
//         // final data = json.decode(response.body);

//         setState(() {
//           classes = data; // احتفظ بالصفوف المرسلة من السيرفر
//           isLoadingClasses = false;
//         });
//       }

//       //
//       else {
//         throw Exception('Failed to load classes: ${response.statusCode}');
//       }
//     } catch (e) {
//       debugPrint('Error fetching classes: $e');
//       isLoadingClasses = false;

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('خطأ: $e')),
//       );
//     }
//   }
//   Future<void> _addTeacher() async {
//     setState(() {
//       isLoading = true;
//     });
//     try {
//       final response = await http.post(
//         Uri.parse(AppLink.addTeacher),
//         body: {
//           'teacherName': teacherNameController.text.trim(),
//           'classId':
//               selectedClassId, // تأكد أن selectedClassId يحتوي على قيمة صالحة
//         },
//       );

//       if (response.statusCode == 200) {
//         setState(() {
//           isLoading = false;
//         });
//         final responseBody = json.decode(response.body);
//         if (responseBody['success']) {
//           Get.back();
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('تم إضافة المعلم بنجاح')),
//           );
//         } else {
//           throw Exception(responseBody['message'] ?? 'Failed to add teacher');
//         }
//       } else {
//         throw Exception('HTTP Error: ${response.statusCode}');
//       }
//     } catch (e) {
//       debugPrint('Error adding teacher: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('خطأ: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('إضافة معلم جديد')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: teacherNameController,
//               decoration: const InputDecoration(
//                 labelText: 'اسم المعلم',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             DropdownButtonFormField<String>(
//               value:
//                   selectedClassId, // تأكد أن selectedClassId هي المتغير المستخدم لتخزين قيمة الصف المحدد
//               onChanged: (newValue) {
//                 setState(() {
//                   selectedClassId = newValue!;
//                 });
//               },
//               items: classes.map((classItem) {
//                 return DropdownMenuItem<String>(
//                   value: classItem['id'], // استخدم id كقيمة
//                   child: Text(classItem['className']), // استخدم className كنص
//                 );
//               }).toList(),
//               decoration: const InputDecoration(
//                 labelText: 'اختر الصف',
//                 border: OutlineInputBorder(),
//               ),
//               hint: isLoadingClasses
//                   ? const Text('جاري تحميل الصفوف...')
//                   : const Text('اختر الصف'),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'يرجى اختيار صف';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 16),
//             isLoading
//                 ? const CircularProgressIndicator()
//                 : ElevatedButton(
//                     onPressed: _addTeacher,
//                     child: const Text('إضافة المعلم'),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//
// AddTeacherToClassPage

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/core/class/handlingdataview.dart';
import 'package:school_management/view/controller/roleAdmin/controller_roleAdmin_Teachers.dart';

class AddTeacherPage extends StatelessWidget {
  const AddTeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TeachersControllerImp());
    return Scaffold(
        appBar: AppBar(title: const Text('إضافة معلم إلى صف')),
        body: GetBuilder<TeachersControllerImp>(
            builder: (controller) => HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: Column(
                    children: [
                      // اختيار المعلم
                      DropdownButtonFormField<String>(
                        value: controller.selectedTeacher,
                        items: controller.teachers
                            .map<DropdownMenuItem<String>>((teacher) {
                          return DropdownMenuItem<String>(
                            value: teacher['id'].toString(),
                            child: Text(teacher['name'] ?? ""),
                          );
                        }).toList(),
                        onChanged: (value) {
                          controller.selectedTeacher = value;
                          controller.update();
                        },
                        decoration: const InputDecoration(
                          labelText: 'اختر المعلم',
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // اختيار الصف
                      DropdownButtonFormField<String>(
                        value: controller.selectedClass,
                        items: controller.classes
                            .map<DropdownMenuItem<String>>((classItem) {
                          return DropdownMenuItem<String>(
                            value: classItem['id'].toString(),
                            child: Text(classItem['className']),
                          );
                        }).toList(),
                        onChanged: (value) {
                          controller.selectedClass = value;
                          controller.update();
                        },
                        decoration: const InputDecoration(
                          labelText: 'اختر الصف',
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                      const SizedBox(height: 30),
                      // زر الحفظ
                      ElevatedButton(
                        onPressed: () async {
                          await controller.addTeacherToClass();
                        },
                        child: const Text('حفظ'),
                      ),
                    ],
                  ),
                )));
  }
}
