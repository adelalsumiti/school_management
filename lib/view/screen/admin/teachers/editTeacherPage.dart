// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:school_management/linkapi.dart';

// class EditTeacherPage extends StatefulWidget {
//   const EditTeacherPage({super.key});

//   @override
//   State<EditTeacherPage> createState() => _EditTeacherPageState();
// }

// class _EditTeacherPageState extends State<EditTeacherPage> {
//   late TextEditingController nameController;
//   late String? selectedClassId;
//   late String? teacherId;
//   // List<dynamic> classes = [];
//   List<dynamic> classList = [];

//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _fetchClasses();

//     // استلام بيانات المعلم من الصفحة السابقة
//     Map<String, dynamic> teacher = Get.arguments;
//     teacherId = teacher['id'];
//     nameController = TextEditingController(text: teacher['name']);
//     selectedClassId = teacher['classId']; // تأكد أن المفتاح صحيح
//   }

//   // List<Map<String, dynamic>> classList = []; // قائمة الصفوف
//   bool isLoadingClasses = true; // تحميل الصفوف

//   Future<void> _fetchClasses() async {
//     try {
//       final response = await http.get(Uri.parse(AppLink.getNameClasses));
//       if (response.statusCode == 200) {
//         // final data = json.decode(response.body);
//         List<dynamic> data = json.decode(response.body);
//         setState(() {
//           classList = data; // احتفظ بالصفوف المرسلة من السيرفر
//           isLoadingClasses = false;
//         });

//         // if (data['success']) {
//         //   setState(() {
//         //     classList = List<Map<String, dynamic>>.from(data['classes']);
//         //     isLoadingClasses = false;
//         //   });
//       } else {
//         throw Exception('Failed to fetch classes');
//       }
//       // else {
//       //   throw Exception('Failed to fetch classes');
//       // }
//     } catch (e) {
//       debugPrint('Error fetching classes: $e');
//       setState(() {
//         isLoadingClasses = false;
//       });
//     }
//   }

//   Future<void> _updateTeacher() async {
//     setState(() {
//       isLoading = true;
//     });
//     if (nameController.text.isEmpty || selectedClassId!.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('يرجى ملء جميع الحقول')),
//       );
//       return;
//     }

//     try {
//       final response = await http.post(
//         Uri.parse(AppLink.editTeacher),
//         body: {
//           'teacherId': teacherId,
//           'name': nameController.text.trim(),
//           'classId': selectedClassId, // يجب أن تكون القيمة محدثة
//         },
//       );

//       final responseBody = json.decode(response.body);
//       if (responseBody['success']) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(responseBody['message'])),
//         );
//         Get.back();

//         // Navigator.pop(context); // العودة للصفحة السابقة
//       } else {
//         throw Exception(responseBody['message']);
//       }
//     } catch (e) {
//       debugPrint('Error updating teacher: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('خطأ أثناء تحديث بيانات المعلم: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('تعديل بيانات المعلم'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(
//                 labelText: 'اسم المعلم',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             DropdownButtonFormField<String>(
//               value: selectedClassId,
//               items: classList.map((classItem) {
//                 return DropdownMenuItem<String>(
//                   value: classItem['id'], // استخدم id كقيمة
//                   child: Text(classItem['className']), // استخدم className كنص
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedClassId = value!;
//                 });
//               },
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
//             const SizedBox(height: 20),
//             isLoading
//                 ? const CircularProgressIndicator()
//                 : ElevatedButton(
//                     onPressed: _updateTeacher,
//                     child: const Text('تحديث'),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
