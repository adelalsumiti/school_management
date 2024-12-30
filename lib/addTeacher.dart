// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AddTeacherPage extends StatefulWidget {
//   const AddTeacherPage({super.key});

//   @override
//   State<AddTeacherPage> createState() => _AddTeacherPageState();
// }

// class _AddTeacherPageState extends State<AddTeacherPage> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   String? selectedClass; // الصف المختار
//   bool isLoading = false;

//   // جلب أسماء الصفوف من Firestore
//   Future<List<String>> _fetchClasses() async {
//     try {
//       QuerySnapshot snapshot =
//           await FirebaseFirestore.instance.collection('classes').get();
//       // return snapshot.docs.map((doc) => doc['name'].toString()).toList();
//       return snapshot.docs.map((doc) => doc['className'].toString()).toList();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('خطأ في تحميل أسماء الصفوف: $e')),
//       );
//       return [];
//     }
//   }

//   Future<void> _addTeacher() async {
//     if (nameController.text.isEmpty ||
//         emailController.text.isEmpty ||
//         phoneController.text.isEmpty ||
//         selectedClass == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('يرجى ملء جميع الحقول واختيار الصف')),
//       );
//       return;
//     }

//     setState(() {
//       isLoading = true;
//     });

//     try {
//       // إضافة المعلم إلى Firestore
//       await FirebaseFirestore.instance.collection('teachers').add({
//         'name': nameController.text.trim(),
//         'email': emailController.text.trim(),
//         'phone': phoneController.text.trim(),
//         // 'class': selectedClass,
//         'className': selectedClass,
//         'createdAt': FieldValue.serverTimestamp(),
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('تم إضافة المعلم بنجاح!')),
//       );

//       // إعادة تعيين الحقول
//       nameController.clear();
//       emailController.clear();
//       phoneController.clear();
//       setState(() {
//         selectedClass = null;
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('خطأ أثناء إضافة المعلم: $e')),
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('إضافة معلم'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: FutureBuilder<List<String>>(
//           future: _fetchClasses(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (snapshot.hasError ||
//                 !snapshot.hasData ||
//                 snapshot.data!.isEmpty) {
//               return const Center(
//                 child: Text('لم يتم العثور على صفوف. أضف صفوفًا أولاً.'),
//               );
//             }

//             return SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'إضافة معلم جديد',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 20),
//                   TextField(
//                     controller: nameController,
//                     decoration: const InputDecoration(
//                       labelText: 'اسم المعلم',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   TextField(
//                     controller: emailController,
//                     decoration: const InputDecoration(
//                       labelText: 'البريد الإلكتروني',
//                       border: OutlineInputBorder(),
//                     ),
//                     keyboardType: TextInputType.emailAddress,
//                   ),
//                   const SizedBox(height: 10),
//                   TextField(
//                     controller: phoneController,
//                     decoration: const InputDecoration(
//                       labelText: 'رقم الهاتف',
//                       border: OutlineInputBorder(),
//                     ),
//                     keyboardType: TextInputType.phone,
//                   ),
//                   const SizedBox(height: 20),
//                   DropdownButtonFormField<String>(
//                     value: selectedClass,
//                     decoration: const InputDecoration(
//                       labelText: 'اختيار الصف',
//                       border: OutlineInputBorder(),
//                     ),
//                     items: snapshot.data!
//                         .map((className) => DropdownMenuItem(
//                               value: className,
//                               child: Text(className),
//                             ))
//                         .toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         selectedClass = value;
//                       });
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   isLoading
//                       ? const CircularProgressIndicator()
//                       : ElevatedButton(
//                           onPressed: _addTeacher,
//                           child: const Text('إضافة المعلم'),
//                         ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
