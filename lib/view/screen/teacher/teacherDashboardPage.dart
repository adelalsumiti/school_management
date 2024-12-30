import 'dart:developer';

import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/linkApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherDashboardPage extends StatefulWidget {
  final int? teacherId; // رقم المعلم المُسجل حاليًا

  const TeacherDashboardPage({super.key, this.teacherId});

  @override
  _TeacherDashboardPageState createState() => _TeacherDashboardPageState();
}

class _TeacherDashboardPageState extends State<TeacherDashboardPage> {
  late Future<List<Map<String, dynamic>>> teacherClasses;
  int? userId;

  Future<List<Map<String, dynamic>>> fetchTeacherClasses(teacherId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    userId = prefs.getInt("id");
    log("$userId", name: 'userId', error: userId);

    final url =
        '${AppLink.fetchTeacherClasses}?teacher_id=$userId'; // ضع الرابط الصحيح هنا
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        return List<Map<String, dynamic>>.from(data['data']);
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception('Failed to load teacher classes');
    }
  }

  @override
  void initState() {
    super.initState();
    // استدعاء API لجلب الصفوف الخاصة بالمعلم المُسجل
    teacherClasses = fetchTeacherClasses("id");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text('الصفوف الخاصة بك'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: teacherClasses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('لا توجد صفوف مرتبطة بك.'));
          } else {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(
                      top: 10, bottom: 5, right: 10, left: 10),
                  decoration: BoxDecoration(
                      color: AppColors.backgroundIDsColor,
                      boxShadow: const [
                        BoxShadow(blurRadius: 3, spreadRadius: 2)
                      ],
                      borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                    title: Text('اسم الصف: ${item['class_name']}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    trailing: const Icon(Icons.class_),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
