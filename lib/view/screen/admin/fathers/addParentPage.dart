import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_management/linkApi.dart';

class AddParentPage extends StatefulWidget {
  const AddParentPage({super.key});

  @override
  State<AddParentPage> createState() => _AddParentPageState();
}

class _AddParentPageState extends State<AddParentPage> {
  List<dynamic> parents = [];
  List<dynamic> students = [];
  String? selectedParent;
  String? selectedStudent;

  @override
  void initState() {
    super.initState();
    fetchParentsAndStudents();
  }

  Future<void> fetchParentsAndStudents() async {
    final response = await http.get(Uri.parse(AppLink.getParentsAndStudents));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['success']) {
        setState(() {
          parents = data['parents'];
          students = data['students'];
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ: ${data['message']}')),
        );
      }
    }
  }

  Future<void> saveParentStudent() async {
    if (selectedParent == null || selectedStudent == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى اختيار ولي أمر وطالب')),
      );
      return;
    }

    var response = await http.post(
      Uri.parse(AppLink.saveParentStudent),
      body: {
        'parent_id': selectedParent,
        'student_id': selectedStudent,
      },
    );
    Get.back();
    final data = await json.decode(response.body);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(data['message'])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إدارة أولياء الأمور')),
      body: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 40),
            DropdownButton<String>(
              isExpanded: true,
              hint: const Text('اختر ولي الأمر'),
              value: selectedParent,
              items: parents.map<DropdownMenuItem<String>>((parent) {
                return DropdownMenuItem<String>(
                  value: parent['id'].toString(),
                  child: Text(parent['name']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedParent = value;
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              isExpanded: true,
              hint: const Text('اختر الطالب'),
              value: selectedStudent,
              items: students.map<DropdownMenuItem<String>>((student) {
                return DropdownMenuItem<String>(
                  value: student['id'].toString(),
                  child: Text(student['name']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedStudent = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveParentStudent,
              child: const Text('حفظ'),
            ),
          ],
        ),
      ),
    );
  }
}
