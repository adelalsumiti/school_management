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
//
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_management/linkApi.dart';

class AddTeacherPage extends StatefulWidget {
  const AddTeacherPage({super.key});

  @override
  State<AddTeacherPage> createState() => _AddTeacherPageState();
}

class _AddTeacherPageState extends State<AddTeacherPage> {
  List<dynamic> teachers = [];
  List<dynamic> classes = [];
  String? selectedTeacher;
  String? selectedClass;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTeachersAndClasses();
  }

  Future<void> fetchTeachersAndClasses() async {
    // جلب المعلمين
    final teacherResponse = await http.get(Uri.parse(AppLink.getTeachers));
    // جلب الصفوف
    final classResponse = await http.get(Uri.parse(AppLink.getClasses));

    if (teacherResponse.statusCode == 200 && classResponse.statusCode == 200) {
      final teacherData = json.decode(teacherResponse.body);
      final classData = json.decode(classResponse.body);

      if (teacherData['success'] && classData['success']) {
        setState(() {
          teachers = teacherData['teachers'];
          classes = classData['classes'];
          isLoading = false;
        });
      }
    }
  }

  Future<void> addTeacherToClass() async {
    // isLoading = true;
    if (selectedTeacher == null || selectedClass == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى اختيار معلم وصف.')),
      );
      return;
    }
    setState(() {
      isLoading = true;
    });

    final response = await http.post(
      Uri.parse(AppLink.addTeacherToClass),
      body: {
        'teacher_id': selectedTeacher,
        'class_id': selectedClass,
      },
    );

    final data = json.decode(response.body);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(data['message'])),
    );

    if (data['success']) {
      // إعادة تهيئة الحقول بعد نجاح الإضافة
      setState(() {
        isLoading = false;

        selectedTeacher = null;
        selectedClass = null;
        Get.back();
      });
    } else {
      setState(() {
        isLoading = false;
      });

      // Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة معلم إلى صف')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // اختيار المعلم
                DropdownButtonFormField<String>(
                  value: selectedTeacher,
                  items: teachers.map<DropdownMenuItem<String>>((teacher) {
                    return DropdownMenuItem<String>(
                      value: teacher['id'].toString(),
                      child: Text(teacher['name']),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => selectedTeacher = value),
                  decoration: const InputDecoration(
                    labelText: 'اختر المعلم',
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
                const SizedBox(height: 20),
                // اختيار الصف
                DropdownButtonFormField<String>(
                  value: selectedClass,
                  items: classes.map<DropdownMenuItem<String>>((classItem) {
                    return DropdownMenuItem<String>(
                      value: classItem['id'].toString(),
                      child: Text(classItem['className']),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => selectedClass = value),
                  decoration: const InputDecoration(
                    labelText: 'اختر الصف',
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
                const SizedBox(height: 30),
                // زر الحفظ
                ElevatedButton(
                  onPressed: () {
                    addTeacherToClass();
                  },
                  child: const Text('حفظ'),
                ),
              ],
            ),
    );
  }
}
