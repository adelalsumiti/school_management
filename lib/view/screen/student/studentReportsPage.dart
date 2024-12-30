import 'dart:convert';
import 'dart:developer';
// import 'dart:nativewrappers/_internal/vm/lib/developer.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/linkapi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:audioplayers/audioplayers.dart';

class StudentReportsPage extends StatefulWidget {
  // final int studentId;

  const StudentReportsPage({
    super.key,
    //  required this.studentId
  });

  @override
  _StudentReportsPageState createState() => _StudentReportsPageState();
}

class _StudentReportsPageState extends State<StudentReportsPage> {
  late Future<List<dynamic>> _reports;
  int? studentId;

  @override
  void initState() {
    super.initState();
    _reports = fetchReports(studentId);
  }

  Future<List<dynamic>> fetchReports(student) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    studentId = prefs.getInt("id");
    log("$studentId", name: 'studentId', error: studentId);
    final response = await http.get(
      Uri.parse('${AppLink.getReports}?student_id=$studentId'),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['success']) {
        return jsonData['data'];
      } else {
        throw Exception(jsonData['message']);
      }
    } else {
      throw Exception('Failed to fetch reports');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text('التقارير المرسلة'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _reports,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('خطأ في جلب البيانات: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('لا توجد تقارير متاحة.'));
          } else {
            final reports = snapshot.data!;
            return Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(
                  top: 10, bottom: 5, right: 10, left: 10),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  boxShadow: const [BoxShadow(blurRadius: 3, spreadRadius: 2)],
                  borderRadius: BorderRadius.circular(20)),
              child: ListView.builder(
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  final report = reports[index];
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
                      title: Text(
                        'التقييم: ${report['assessment']}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ملاحظة: ${report['note'] ?? 'لا توجد ملاحظات'}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          // Text('المعلم: ${report['teacher_name']}'),
                          Text('التاريخ: ${report['created_at']}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          if (report['file_path'] != null)
                            TextButton(
                              onPressed: () {
                                // فتح الملف
                                launchUrl(report['file_path'],
                                    mode: LaunchMode.externalApplication);
                              },
                              child: const Text('فتح الملف'),
                            ),
                          if (report['audio_path'] != null)
                            TextButton(
                              onPressed: () {
                                // تشغيل الصوت
                                playAudio(report['audio_path']);
                              },
                              child: const Text('تشغيل الصوت'),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  // void playAudio(String audioUrl) {
  //   // أضف كود تشغيل الصوت هنا

  void playAudio(Source audioUrl) async {
    audioUrl = AssetSource('https://example.com/sample.mp3');

    final audioPlayer = AudioPlayer();

    // int result = await audioPlayer.play(audioUrl);
    Future<void> result = audioPlayer.play(audioUrl);

    if (result == 1) {
      // الصوت يتم تشغيله بنجاح
      print('تم تشغيل الصوت بنجاح.');
    } else {
      // فشل في تشغيل الصوت
      print('فشل في تشغيل الصوت.');
    }
  }
  // }

  // void launchUrl(String fileUrl) {
  //   // أضف كود فتح الملفات هنا

  void launchUrl(String fileUrl, {required LaunchMode mode}) async {
    final uri = Uri.parse(fileUrl);
    launchUrl('https://example.com/sample.pdf', mode: mode);

    if (await canLaunchUrl(uri)) {
      launchUrl(uri as String, mode: LaunchMode.externalApplication);
    } else {
      throw 'لا يمكن فتح الرابط: $fileUrl';
    }
  }
  // }
}
