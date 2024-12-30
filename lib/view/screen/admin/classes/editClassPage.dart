import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:school_management/linkapi.dart';

class EditClassPage extends StatefulWidget {
  const EditClassPage({super.key});

  @override
  State<EditClassPage> createState() => _EditClassPageState();
}

class _EditClassPageState extends State<EditClassPage> {
  late TextEditingController nameController;
  late String? classId;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    // استلام بيانات الصف من الصفحة السابقة
    Map<String, dynamic> classData = Get.arguments;
    classId = classData['id'];
    nameController = TextEditingController(text: classData['className']);
  }

  Future<void> _updateClass() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(AppLink.editClass),
        body: {
          'id': classId,
          'className': nameController.text.trim(),
        },
      );

      final responseBody = json.decode(response.body);
      if (responseBody['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseBody['message'])),
        );
        Get.back();
      } else {
        throw Exception(responseBody['message']);
      }
    } catch (e) {
      debugPrint('Error updating class: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('هذا الاسم موجود من قبل')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعديل بيانات الصف'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'اسم الصف',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _updateClass,
                    child: const Text('تحديث'),
                  ),
          ],
        ),
      ),
    );
  }
}
