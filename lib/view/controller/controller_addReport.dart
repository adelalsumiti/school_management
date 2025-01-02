import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:school_management/core/services/report_Service.dart';
import 'package:school_management/data/model/report_Model.dart';
import 'package:school_management/linkapi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:quran/quran.dart' as quran;

abstract class AddReportController extends GetxController {
  sendReport();
  fetchReportStudentForRoleStudent();
  submitReport();
  fetchReportStudentForRoleTeacher();
  initialData();
}

class AddReportControllerImp extends AddReportController {
  ReportService reportService = Get.find();
  late SharedPreferences prefs;
  // = await SharedPreferences.getInstance();

  ReportModel reportModel = ReportModel();
  String? selectedAssessment;
  String? selectedSurah;
  bool isLoading = true;
  TextEditingController noteController = TextEditingController();
  File? selectedFile;
  File? audioFile;
  late int studentIdd;
  late int studentId;
  late int teacherIdd;
  late int teacherId;
  late int classIdd;
  late int classId;
  late int startVersee;
  late int endVersee;
  List<dynamic> reportStudentForRoleTeacher = [];
  List<dynamic> reportStudentForRoleStudent = [];
  // List<Map<String, dynamic>> response = [];
  int? userId;
  File? selectedPickFile;
  List<String> items = ['ممتاز', 'جيد', 'متوسط', 'ضعيف'];

  // SharedPreferences? prefs;

  FlutterSoundRecorder? audioRecorder;
  String? audioFilePath;
  //
  // List<dynamic> reportStudent = [];
  List<dynamic> responsev = [];

  @override
  fetchReportStudentForRoleTeacher() async {
    isLoading = true;
    update();
    prefs = await SharedPreferences.getInstance();
    studentId = prefs.getInt("student_id")!;
    final url =
        '${AppLink.getReports}?student_id=$studentId'; // ضع الرابط الصحيح هنا
    final response = await http.get(Uri.parse(url));
    isLoading = false;
    update();
    if (response.statusCode == 200) {
      isLoading = false;
      update();

      final data = json.decode(response.body);
      if (data['success']) {
        log("studentId", error: studentId);
        print('Data received reportStudent: $reportStudentForRoleTeacher');
        reportStudentForRoleTeacher = data['data'];
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception('Failed to load teacher students');
    }
  }

  //
  @override
  fetchReportStudentForRoleStudent() async {
    prefs = await SharedPreferences.getInstance();
    studentId = prefs.getInt("id")!;
    // studentId = prefs.getInt("student_id")!;
    log("$studentId", name: 'studentId', error: studentId);
    final response = await http.get(
      Uri.parse('${AppLink.getReports}?student_id=$studentId'),
    );
    if (response.statusCode == 200) {
      isLoading = false;
      final data = json.decode(response.body);
      if (data['success']) {
        return reportStudentForRoleStudent = data['data'];
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception('Failed to fetch reports');
    }
  }

  //
  @override
  submitReport() async {
    // if (selectedAssessment != null) {
    // try {
    prefs = await SharedPreferences.getInstance();

    // void submitReport() async {
    isLoading = true;
    update();

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    studentIdd = prefs.getInt("student_id")!;
    classIdd = prefs.getInt("class_id")!;
    teacherIdd = prefs.getInt("id")!;
    startVersee = prefs.getInt("startVerse") ?? 0;
    endVersee = prefs.getInt("endVerse") ?? 0;
    selectedSurah = prefs.getString("surah");

    log("$selectedSurah", name: 'selectedSurah', error: selectedSurah);
    log("$startVersee", name: 'startVersee', error: startVersee);
    log("$endVersee", name: 'endVersee', error: endVersee);

    var response = await reportService.sendReport(ReportModel(
      studentId: studentIdd,
      classId: classIdd,
      teacherId: teacherIdd,
      surah: selectedSurah,
      startVerse: startVersee,
      endVerse: endVersee,
      assessment: selectedAssessment,
      note: noteController.text,
      // filePath: selectedFile,
      // audioNotePath: audioFile,
    ));
    if (response['success']) {
      prefs = await SharedPreferences.getInstance();
      await prefs.remove('student_id');
      await prefs.remove('class_id');
      await prefs.remove('surah');
      await prefs.remove('startVerse');
      await prefs.remove('endVerse');

      isLoading = false;
      update();
      // Navigator.pop(context, true);
      Get.back(result: true);
    } else {
      isLoading = false;
      update();
      // Handle error
      Get.snackbar(
        "Handle Error",
        response['message'],
      );
    }
  }

  @override
  sendReport() async {
    prefs = await SharedPreferences.getInstance();

    // SharedPreferences prefs = await SharedPreferences.getInstance();

    teacherIdd = prefs.getInt("id")!;
    classIdd = prefs.getInt("class_id")!;

    log("$teacherIdd", name: 'teacherId', error: teacherIdd);
    log("$classIdd", name: 'classId', error: classIdd);
    studentIdd = prefs.getInt("student_id")!;
    log("$studentIdd", name: 'studentId', error: studentIdd);

    final url = Uri.parse(AppLink.addReport);

    var request = http.MultipartRequest('POST', url);

    // إضافة الحقول إلى الطلب
    request.fields['student_id'] = reportModel.studentId.toString();
    request.fields['class_id'] = reportModel.classId.toString();
    request.fields['teacher_id'] = reportModel.teacherId.toString();
    request.fields['assessment'] = reportModel.assessment ?? '';
    request.fields['note'] = reportModel.note ?? '';
    request.fields['surah'] = reportModel.surah ?? '';
    request.fields['startVerse'] = reportModel.startVerse.toString();
    request.fields['endVerse'] = reportModel.endVerse.toString();
    // request.fields['file_path'] = reportModel.filePath.toString();
    // request.fields['audio_note_path'] = reportModel.audioNotePath.toString();

    // إضافة الملف إذا كان موجودًا
    if (reportModel.filePath != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'file', reportModel.filePath!.path));
    }

    // إضافة الملف الصوتي إذا كان موجودًا
    if (reportModel.audioNotePath != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'audio_note', reportModel.audioNotePath!.path));
    }
    isLoading = true;

    // إرسال الطلب واستلام الاستجابة
    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        return json.decode(responseBody);
      } else {
        return {
          'success': false,
          'message':
              'فشل في الاتصال بالخادم. رمز الخطأ: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'حدث خطأ أثناء الإرسال: $e',
      };
    }
  }

  //

  //
  @override
  void onInit() {
    super.onInit();
    initialData();
    isLoading;

    // ReportModel();

    // reportModel;
  }

  //
  @override
  initialData() async {
    await fetchReportStudentForRoleStudent();
    await sendReport();
    reportModel = ReportModel();
    reportService = ReportService();
    isLoading;
    // reportModel;
    await fetchReportStudentForRoleTeacher();
    prefs = await SharedPreferences.getInstance();
    await submitReport();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  //
  //
  //
  void showQuranSelectionDialog(BuildContext context) {
    String? selectedSurah;
    int? startVerse;
    int? endVerse;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('تحديد الحفظ'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // اختيار السورة
                  DropdownButtonFormField<String>(
                    value: selectedSurah,
                    hint: const Text('اختر السورة'),
                    onChanged: (value) async {
                      setState(() {
                        selectedSurah = value;
                        startVerse = null;
                        endVerse = null;
                      });
                    },
                    items: List.generate(
                      114,
                      (index) {
                        int surahNumber = index + 1;
                        return DropdownMenuItem<String>(
                          value: surahNumber.toString(),
                          child:
                              Text('سورة ${quran.getSurahName(surahNumber)}'),
                        );
                      },
                    ),
                  ),

                  // اختيار آية البداية
                  if (selectedSurah != null)
                    DropdownButtonFormField<int>(
                      value: startVerse,
                      hint: const Text('اختر آية البداية'),
                      onChanged: (value) async {
                        setState(() {
                          startVerse = value;
                          if (endVerse != null && endVerse! < startVerse!) {
                            endVerse = null;
                          }
                        });
                      },
                      items: List.generate(
                        quran.getVerseCount(int.parse(selectedSurah!)),
                        (index) => DropdownMenuItem<int>(
                          value: index + 1,
                          child: Text('آية ${index + 1}'),
                        ),
                      ),
                    ),

                  // اختيار آية النهاية
                  if (startVerse != null)
                    DropdownButtonFormField<int>(
                      value: endVerse,
                      hint: const Text('اختر آية النهاية'),
                      onChanged: (value) async {
                        setState(() {
                          endVerse = value;
                        });
                        log("$endVerse", name: "$endVerse");
                      },
                      items: List.generate(
                        quran.getVerseCount(int.parse(selectedSurah!)),
                        (index) {
                          int verseNumber = index + 1;
                          return verseNumber >= startVerse!
                              ? DropdownMenuItem<int>(
                                  value: verseNumber,
                                  child: Text('آية $verseNumber'),
                                )
                              : null;
                        },
                      ).whereType<DropdownMenuItem<int>>().toList(),
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('إلغاء'),
                ),
                ElevatedButton(
                  onPressed: selectedSurah != null &&
                          startVerse != null &&
                          endVerse != null
                      ? () {
                          Navigator.pop(context, {
                            'surah': selectedSurah,
                            'startVerse': startVerse,
                            'endVerse': endVerse,
                          });
                        }
                      : null,
                  child: const Text('حفظ'),
                ),
              ],
            );
          },
        );
      },
    ).then((result) async {
      if (result != null) {
        print('السورة: ${quran.getSurahName(int.parse(result['surah']))}');
        print('من الآية: ${result['startVerse']}');
        print('إلى الآية: ${result['endVerse']}');
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'surah', quran.getSurahName(int.parse(result['surah'])));

      await prefs.setInt('startVerse', result['startVerse']);

      await prefs.setInt('endVerse', result['endVerse']);
    });
  }

  //
  void printSurahs() {
    for (int i = 1; i <= 114; i++) {
      print(
          'سورة ${quran.getSurahName(i)} - عدد الآيات: ${quran.getVerseCount(i)}');
    }
  }
//

  void printVerse() {
    int surahNumber = 2; // سورة البقرة
    int verseNumber = 255; // آية الكرسي
    print(quran.getVerse(surahNumber, verseNumber)); // النص الكامل للآية
  }
//

  Future<void> recordAudio() async {
    // طلب الإذن لاستخدام الميكروفون
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      if (audioRecorder == null) {
        audioRecorder = FlutterSoundRecorder();
        await audioRecorder?.openRecorder();
      }

      if (!audioRecorder!.isRecording) {
        audioFilePath = '/path/to/save/recorded_audio.aac'; // تحديد مسار الملف
        await audioRecorder!.startRecorder(toFile: audioFilePath);
        print('Recording started');
      } else {
        await audioRecorder!.stopRecorder();
        print('Recording stopped, file saved at: $audioFilePath');
      }
    } else {
      print('Microphone permission not granted');
    }
  }
  //

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      selectedPickFile = File(result.files.single.path!);
      print('File selected: ${selectedPickFile!.path}');
    } else {
      print('No file selected');
    }
  }

//

  //
}

//
