import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:school_management/core/constant/colors.dart';
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
  deleteReport(int id);
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
  late int studentIdInRoleTeacher;
  late int studentIdInRoleStudent;
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
  FlutterSoundRecorder? audioRecorder;
  String? audioFilePath;
  // خريطة تربط أسماء السور بأرقامها
  final Map<String, int> surahMap = {
    'الفاتحة': 1,
    'البقرة': 2,
    'آل عمران': 3,
    'النساء': 4,
    'المائدة': 5,
    'الأنعام': 6,
    'الأعراف': 7,
    'الأنفال': 8,
    'التوبة': 9,
    'يونس': 10,
    'هود': 11,
    'يوسف': 12,
    'الرعد': 13,
    'ابراهيم': 14,
    'الحجر': 15,
    'النحل': 16,
    'الإسراء': 17,
    'الكهف': 18,
    'مريم': 19,
    'طه': 20,
    'الأنبياء': 21,
    'الحج': 22,
    'المؤمنون': 23,
    'النور': 24,
    'الفرقان': 25,
    'الشعراء': 26,
    'النمل': 27,
    'القصص': 28,
    'العنكبوت': 29,
    'الروم': 30,
    'لقمان': 31,
    'السجدة': 32,
    'الأحزاب': 33,
    'سبإ': 34,
    'فاطر': 35,
    'يس': 36,
    'الصافات': 37,
    'ص': 38,
    'الزمر': 39,
    'غافر': 40,
    'فصلت': 41,
    'الشورى': 42,
    'الزخرف': 43,
    'الدخان': 44,
    'الجاثية': 45,
    'الأحقاف': 46,
    'محمد': 47,
    'الفتح': 48,
    'الحجرات': 49,
    'ق': 50,
    'الذاريات': 51,
    'الطور': 52,
    'النجم': 53,
    'القمر': 54,
    'الرحمن': 55,
    'الواقعة': 56,
    'الحديد': 57,
    'المجادلة': 58,
    'الحشر': 59,
    'الممتحنة': 60,
    'الصف': 61,
    'الجمعة': 62,
    'المنافقون': 63,
    'التغابن': 64,
    'الطلاق': 65,
    'التحريم': 66,
    'الملك': 67,
    'القلم': 68,
    'الحاقة': 69,
    'المعارج': 70,
    'نوح': 71,
    'الجن': 72,
    'المزمل': 73,
    'المدثر': 74,
    'القيامة': 75,
    'الانسان': 76,
    'المرسلات': 77,
    'النبأ': 78,
    'النازعات': 79,
    'عبس': 80,
    'التكوير': 81,
    'الإنفطار': 82,
    'المطففين': 83,
    'الإنشقاق': 84,
    'البروج': 85,
    'الطارق': 86,
    'الأعلى': 87,
    'الغاشية': 88,
    'الفجر': 89,
    'البلد': 90,
    'الشمس': 91,
    'الليل': 92,
    'الضحى': 93,
    'الشرح': 94,
    'التين': 95,
    'العلق': 96,
    'القدر': 97,
    'البينة': 98,
    'الزلزلة': 99,
    'العاديات': 100,
    'القارعة': 101,
    'التكاثر': 102,
    'العصر': 103,
    'الهمزة': 104,
    'الفيل': 105,
    'قريش': 106,
    'الماعون': 107,
    'الكوثر': 108,
    'الكافرون': 109,
    'النصر': 110,
    'المسد': 111,
    'الإخلاص': 112,
    'الفلق': 113,
    'الناس': 114
  };
  //
  String getVerses(String surahName, int startVerse, int endVerse) {
    // الحصول على رقم السورة بناءً على اسمها
    int? surahNumber = surahMap[surahName];
    if (surahNumber == null) {
      return 'السورة غير موجودة';
    }
    String verses = '';
    for (int i = startVerse; i <= endVerse; i++) {
      verses += ' ${quran.getVerse(surahNumber, i)}﴿$i﴾ '; // إضافة النص لكل آية
    }
    return verses;
  }

  //
  @override
  deleteReport(int id) async {
    isLoading = true;
    Get.back();

    update();
    try {
      final response = await http.post(
        Uri.parse(AppLink.deleteReport),
        body: {'id': id.toString()},
      );

      final data = json.decode(response.body);
      isLoading = false;

      if (response.statusCode == 200 && data['success'] == true) {
        isLoading = false;
        update();

        Get.snackbar(
          "نجاح",
          'تم حذف التقرير بنجاح !',
          backgroundColor: AppColors.backgroundIDsColor,
          colorText: AppColors.primaryColor,
          barBlur: 4,
          animationDuration: const Duration(seconds: 5),
        );
        fetchReportStudentForRoleTeacher();
        update();
      } else {
        throw Exception(data['message'] ?? 'فشل في حذف التقرير');
      }
    } catch (e) {
      Get.snackbar(
        'لايمكن الحذف',
        'مرتبط ببيانات أخرى',
        backgroundColor: AppColors.primaryColor,
        colorText: AppColors.backgroundIDsColor,
        animationDuration: const Duration(seconds: 5),
      );
    }
  }

//
  @override
  fetchReportStudentForRoleTeacher() async {
    isLoading = true;
    update();
    prefs = await SharedPreferences.getInstance();
    studentIdInRoleTeacher = prefs.getInt("student_id")!;
    final url =
        '${AppLink.getReports}?student_id=$studentIdInRoleTeacher'; // ضع الرابط الصحيح هنا
    final response = await http.get(Uri.parse(url));
    isLoading = false;
    update();
    if (response.statusCode == 200) {
      isLoading = false;
      update();

      final data = json.decode(response.body);
      if (data['success']) {
        log("studentIdInRoleTeacher", error: studentIdInRoleTeacher);
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
    // isLoading = true;

    prefs = await SharedPreferences.getInstance();
    studentIdInRoleStudent = prefs.getInt("id")!;
    update();
    // studentId = prefs.getInt("student_id")!;
    log("$studentIdInRoleStudent",
        name: 'studentIdInRoleStudent', error: studentIdInRoleStudent);
    final response = await http.get(
      Uri.parse('${AppLink.getReports}?student_id=$studentIdInRoleStudent'),
    );
    isLoading = false;
    update();
    if (response.statusCode == 200) {
      isLoading = false;
      update();

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
        "حدث خطأ",
        response['message'],
        backgroundColor: AppColors.primaryColor,
        colorText: AppColors.backgroundIDsColor,
        animationDuration: const Duration(seconds: 5),
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
  }

  //
  @override
  initialData() async {
    fetchReportStudentForRoleStudent();
    reportModel = ReportModel();
    reportService = ReportService();
    isLoading;
    fetchReportStudentForRoleTeacher();
    prefs = await SharedPreferences.getInstance();
    submitReport();
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
                          child: Text(
                              'سورة ${quran.getSurahNameArabic(surahNumber)}'),
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
        print(
            'السورة: ${quran.getSurahNameArabic(int.parse(result['surah']))}');
        print('من الآية: ${result['startVerse']}');
        print('إلى الآية: ${result['endVerse']}');
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'surah', quran.getSurahNameArabic(int.parse(result['surah'])));

      await prefs.setInt('startVerse', result['startVerse']);

      await prefs.setInt('endVerse', result['endVerse']);
    });
  }

  //
  void printSurahs() {
    for (int i = 1; i <= 114; i++) {
      print(
          'سورة ${quran.getSurahNameArabic(i)} - عدد الآيات: ${quran.getVerseCount(i)}');
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
