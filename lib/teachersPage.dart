// //ignore_for_file: file_names

// // ignore_for_file: unused_import, invalid_use_of_protected_member

// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

// class TeachersPage extends StatelessWidget {
//   const TeachersPage({super.key});

//   // دالة لجلب المعلمين مع الصفوف
//   Future<List<Map<String, dynamic>>> _fetchTeachersWithClasses() async {
//     final teachersSnapshot =
//         await FirebaseFirestore.instance.collection('teachers').get();

//     return teachersSnapshot.docs.map((doc) {
//       final data = doc.data();
//       return {
//         'teacherName': data['name']?.toString() ?? 'اسم غير معروف',
//         'className': data['className'] ?? 'غير محدد',
//         'id': doc.id, // إضافة معرف المعلم للحذف لاحقًا
//       };
//     }).toList();
//   }

//   // دالة لحذف المعلم من قاعدة البيانات
//   Future<void> _deleteTeacher(String teacherId) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('teachers')
//           .doc(teacherId)
//           .delete();
//       log('تم حذف المعلم بنجاح');
//     } catch (e) {
//       log('حدث خطأ أثناء الحذف: $e', name: "DeleteError");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('قائمة المعلمين'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () {
//               // إعادة بناء الصفحة
//               (context as Element).reassemble();
//             },
//           ),
//         ],
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: _fetchTeachersWithClasses(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             log('حدث خطأ: ${snapshot.error}', name: "snapshot.error");
//             return Center(child: Text('حدث خطأ: ${snapshot.error}'));
//           }

//           final teachers = snapshot.data ?? [];
//           return Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Expanded(
//                     child: Container(
//                       height: 55,
//                       margin: const EdgeInsets.only(left: 10),
//                       padding: const EdgeInsets.only(left: 10),
//                       child: TextField(
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(10)),
//                           ),
//                           labelText: 'بحث',
//                           prefixIcon: Icon(Icons.search),
//                         ),
//                         onChanged: (value) {
//                           // تطبيق تصفية البيانات هنا
//                         },
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       height: 55,
//                       margin: const EdgeInsets.only(right: 10, left: 10),
//                       decoration: const BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                         border: Border(
//                           bottom: BorderSide(color: Colors.black45),
//                           left: BorderSide(color: Colors.black45),
//                           right: BorderSide(color: Colors.black45),
//                           top: BorderSide(color: Colors.black45),
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           'عدد المعلمين: ${teachers.length}',
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: teachers.isEmpty
//                     ? const Center(child: Text('لا يوجد معلمون لإظهارهم.'))
//                     : ListView.builder(
//                         itemCount: teachers.length,
//                         itemBuilder: (context, index) {
//                           final teacher = teachers[index];
//                           return ListTile(
//                             leading: const Icon(Icons.person),
//                             title: Text(teacher['teacherName']),
//                             subtitle: Text('الفصل: ${teacher['className']}'),
//                             trailing: Container(
//                               decoration: const BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   boxShadow: [
//                                     BoxShadow(spreadRadius: 0.5, blurRadius: 4)
//                                   ],
//                                   color: Colors.white,
//                                   border: Border.symmetric(
//                                       horizontal: BorderSide(),
//                                       vertical: BorderSide())),
//                               child: IconButton(
//                                 // color: Colors.black,
//                                 // splashColor: Colors.black,
//                                 // highlightColor: Colors.black,
//                                 // focusColor: Colors.black,
//                                 // hoverColor: Colors.black,
//                                 // disabledColor: Colors.black,
//                                 icon:
//                                     const Icon(Icons.delete, color: Colors.red),
//                                 onPressed: () {
//                                   showDialog(
//                                     context: context,
//                                     builder: (context) => AlertDialog(
//                                       title: const Text('تأكيد الحذف'),
//                                       content: const Text(
//                                           'هل أنت متأكد من حذف هذا المعلم ؟'),
//                                       actions: [
//                                         TextButton(
//                                           onPressed: () =>
//                                               // Navigator.of(context).pop(),
//                                               Get.back(),
//                                           child: const Text('إلغاء'),
//                                         ),
//                                         TextButton(
//                                           onPressed: () {
//                                             // Navigator.of(context).pop();
//                                             Get.back();
//                                             // _deleteClass(docId);
//                                             _deleteTeacher(teacher['id']);
//                                           },
//                                           child: const Text(
//                                             'حذف',
//                                             style: TextStyle(color: Colors.red),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                   // تحديث الصفحة بعد الحذف
//                                   (context as Element).reassemble();
//                                 },
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
