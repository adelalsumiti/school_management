import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_management/linkapi.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddReportPage extends StatefulWidget {
  // final int studentId;
  // final int teacherId;

  const AddReportPage({
    super.key,
    // required this.studentId, required this.teacherId
  });

  @override
  _AddReportPageState createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage> {
  String? selectedAssessment;
  bool isLoading = false;
  TextEditingController noteController = TextEditingController();
  File? selectedFile;
  File? audioFile;
  late int studentIdd;
  late int teacherIdd;
  late int classIdd;

  int? userId;
  File? selectedPickFile;
  SharedPreferences? prefs;

  FlutterSoundRecorder? _audioRecorder;
  String? audioFilePath;

  //

  Future<Map<String, dynamic>> sendReport({
    required int studentId,
    required int teacherId,
    required int classId,
    String? assessment,
    String? note,
    File? file,
    File? audio,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    teacherIdd = prefs.getInt("id")!;
    classIdd = prefs.getInt("class_id")!;
    log("$teacherIdd", name: 'teacherId', error: teacherIdd);
    log("$classIdd", name: 'classId', error: classIdd);
    studentIdd = prefs.getInt("student_id")!;
    log("$studentIdd", name: 'studentId', error: studentIdd);

    final url = Uri.parse(AppLink.addReport);

    var request = http.MultipartRequest('POST', url);

    // إضافة الحقول إلى الطلب
    request.fields['student_id'] = studentId.toString();
    request.fields['class_id'] = classId.toString();
    request.fields['teacher_id'] = teacherId.toString();
    request.fields['assessment'] = assessment ?? '';
    request.fields['note'] = note ?? '';

    // إضافة الملف إذا كان موجودًا
    if (file != null) {
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
    }

    // إضافة الملف الصوتي إذا كان موجودًا
    if (audio != null) {
      request.files
          .add(await http.MultipartFile.fromPath('audio_note', audio.path));
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

  void submitReport() async {
    setState(() {
      isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentIdd = prefs.getInt("student_id")!;
    classIdd = prefs.getInt("class_id")!;
    teacherIdd = prefs.getInt("id")!;

    // API call to submit the report
    final response = await sendReport(
      studentId: studentIdd,
      classId: classIdd,
      teacherId: teacherIdd,
      assessment: selectedAssessment,
      note: noteController.text,
      file: selectedFile,
      audio: audioFile,
    );

    if (response['success']) {
      prefs = await SharedPreferences.getInstance();
      await prefs.remove('student_id');
      await prefs.remove('class_id');

      setState(() {
        isLoading = false;
      });

      // Navigator.pop(context, true);
      Get.back(result: true);
    } else {
      setState(() {
        isLoading = false;
      });
      // Handle error
      Get.snackbar(
        "Handle Error",
        response['message'],
      );
    }
  }
  //

  Future<void> recordAudio() async {
    // طلب الإذن لاستخدام الميكروفون
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      if (_audioRecorder == null) {
        _audioRecorder = FlutterSoundRecorder();
        await _audioRecorder?.openRecorder();
      }

      if (!_audioRecorder!.isRecording) {
        audioFilePath = '/path/to/save/recorded_audio.aac'; // تحديد مسار الملف
        await _audioRecorder!.startRecorder(toFile: audioFilePath);
        print('Recording started');
      } else {
        await _audioRecorder!.stopRecorder();
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

  @override
  Widget build(BuildContext context) {
    // Get.arguments({studentId: "studentId", teacherId: "id"});
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة تقرير')),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    items: ['ممتاز', 'جيد', 'متوسط', 'ضعيف']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) => selectedAssessment = value,
                    decoration: const InputDecoration(labelText: 'التقييم'),
                  ),
                  TextField(
                    controller: noteController,
                    decoration: const InputDecoration(labelText: 'ملاحظة'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await pickFile();
                    },
                    child: const Text('تحميل ملف'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await recordAudio();
                    },
                    child: const Text('تسجيل ملاحظة صوتية'),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () => submitReport(),
                    child: const Text('حفظ التقرير'),
                  ),
                ],
              ),
            ),
    );
  }
}
