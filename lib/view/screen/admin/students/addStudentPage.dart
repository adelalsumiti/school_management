// //ignore_for_file: file_names

// // ignore_for_file: unused_import

// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:school_management/linkApi.dart';
// import 'dart:convert';

// // import 'linkapi.dart';

// class AddStudentPage extends StatefulWidget {
//   const AddStudentPage({super.key});

//   @override
//   State<AddStudentPage> createState() => _AddStudentPageState();
// }

// class _AddStudentPageState extends State<AddStudentPage> {
//   final TextEditingController studentNameController = TextEditingController();
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

//   Future<void> _addStudent() async {
//     setState(() {
//       isLoading = true;
//     });
//     try {
//       final response = await http.post(
//         Uri.parse(AppLink.addStudent),
//         body: {
//           'studentName': studentNameController.text.trim(),
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
//             const SnackBar(content: Text('تم إضافة الطالب بنجاح')),
//           );
//         } else {
//           throw Exception(responseBody['message'] ?? 'Failed to add student');
//         }
//       } else {
//         throw Exception('HTTP Error: ${response.statusCode}');
//       }
//     } catch (e) {
//       debugPrint('Error adding student: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('خطأ: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('إضافة طالب جديد')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: studentNameController,
//               decoration: const InputDecoration(
//                 labelText: 'اسم الطالب',
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
//                     onPressed: _addStudent,
//                     child: const Text('إضافة الطالب'),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//
//

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_management/linkApi.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({super.key});

  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  List<dynamic> students = [];
  List<dynamic> classes = [];
  String? selectedStudent;
  String? selectedClass;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStudentsAndClasses();
  }

  Future<void> fetchStudentsAndClasses() async {
    final studentResponse = await http.get(Uri.parse(AppLink.getStudents));
    final classResponse = await http.get(Uri.parse(AppLink.getClasses));

    if (studentResponse.statusCode == 200 && classResponse.statusCode == 200) {
      final studentData = json.decode(studentResponse.body);
      final classData = json.decode(classResponse.body);

      if (studentData['success'] && classData['success']) {
        setState(() {
          students = studentData['students'];
          classes = classData['classes'];
          isLoading = false;
        });
      }
    }
  }

  Future<void> addStudentToClass() async {
    if (selectedStudent == null || selectedClass == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يجب اختيار الطالب والصف.')),
      );
      return;
    }
    setState(() {
      isLoading = true;
    });

    final response = await http.post(
      Uri.parse(AppLink.addStudentToClass),
      body: {
        'student_id': selectedStudent,
        'class_id': selectedClass,
      },
    );

    final data = json.decode(response.body);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(data['message'])),
    );

    if (data['success']) {
      setState(() {
        isLoading = false;

        selectedStudent = null;
        selectedClass = null;
        Get.back();
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة طالب إلى صف')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                DropdownButtonFormField<String>(
                  value: selectedStudent,
                  items: students.map<DropdownMenuItem<String>>((student) {
                    return DropdownMenuItem<String>(
                      value: student['id'].toString(),
                      child: Text(student['name']),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => selectedStudent = value),
                  decoration: const InputDecoration(labelText: 'اختر الطالب'),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectedClass,
                  items: classes.map<DropdownMenuItem<String>>((classItem) {
                    return DropdownMenuItem<String>(
                      value: classItem['id'].toString(),
                      child: Text(classItem['className']),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => selectedClass = value),
                  decoration: const InputDecoration(labelText: 'اختر الصف'),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: addStudentToClass,
                  child: const Text('حفظ'),
                ),
              ],
            ),
    );
  }
}
