import 'dart:convert';
import 'dart:developer';
import 'dart:io';
// import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:school_management/core/class/statusrequest.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/funcations/handlinfdatacontroller.dart';
import 'package:school_management/core/services/report_Service.dart';
import 'package:school_management/data/dataSource/remote/roleTeacher/report_data.dart';
import 'package:school_management/data/model/report_Model.dart';
import 'package:school_management/linkapi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:quran/quran.dart' as quran;

abstract class AddReportController extends GetxController {
  // sendReport();
  fetchReportStudentForRoleStudent();
  submitReport();
  deleteReport(int id);
  fetchReportStudentForRoleTeacher();
  initialData();
}

class AddReportControllerImp extends AddReportController {
  ReportData reportData = ReportData(Get.find());
  ReportService reportService = Get.find();
  late SharedPreferences prefs;
  // = await SharedPreferences.getInstance();

  ReportModel reportModel = ReportModel();
  String? selectedAssessment;
  String? selectedSurah;
  String? selectedSurahReview;
  bool isLoading = true;
  TextEditingController noteController = TextEditingController();
  File? selectedFile;
  // File? audioFile;
  // int? reportId;
  late int studentIdd;
  late int reportId;
  late int studentIdInRoleTeacher;
  late int studentIdInRoleStudent;
  late int teacherIdd;
  late int teacherId;
  late int classIdd;
  late int classId;
  late int startVersee;
  late int endVersee;
  late int startVerseReview;
  late int endVerseReview;
  late StatusRequest statusRequest;

  List<dynamic> reportStudentForRoleTeacher = [];
  List<dynamic> reportStudentForRoleStudent = [];
  // List<Map<String, dynamic>> response = [];
  int? userId;
  File? selectedPickFile;
  List<String> items = ['ممتاز', 'جيد', 'متوسط', 'ضعيف'];
  FlutterSoundRecorder? audioRecorder;
  late String audioFilePath;
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
  Future<Map<String, dynamic>> sendAudioNote({
    required int studentId,
    required int teacherId,
    required File audioFile,
  }) async {
    final url = Uri.parse(AppLink.addReport); // رابط API الخاص بك
    final request = http.MultipartRequest('POST', url);

    request.fields['student_id'] = studentId.toInt().toString();
    request.fields['teacher_id'] = teacherId.toInt().toString();
    // request.files
    //     .add(await http.MultipartFile.fromPath('audio_note', audioFile.path));
    Future<bool> fileExists(String path) async {
      return await File(path).exists();
    }

    if (await fileExists(audioFile.path)) {
      request.files
          .add(await http.MultipartFile.fromPath('audio_note', audioFile.path));

      // var file = await MultipartFile.fromPath('audio_note', audioFilePath!) ;
      // تابع التنفيذ
    } else {
      // return;

      print('الملف غير موجود: ${audioFile.path}');
    }

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      return json.decode(responseBody);
    } else {
      return {'success': false, 'message': 'فشل في إرسال الملاحظة الصوتية'};
    }
  }

//
  void sendAudioNoteToTeacher(File audioFile) async {
    prefs = await SharedPreferences.getInstance();
    isLoading = true;
    update();

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    studentIdd = prefs.getInt("student_id")!;
    // classIdd = prefs.getInt("class_id")!;
    teacherIdd = prefs.getInt("id")!;
    // أضف الكود لإرسال الملف إلى السيرفر
    // final response = await reportService.sendReport(ReportModel(
    final response = await sendAudioNote(
      studentId: studentIdd.toInt(), // استبدل بالقيم المناسبة
      teacherId: teacherIdd.toInt(),

      audioFile: audioFile,
    );

    if (response['success']) {
      Get.snackbar('نجاح', 'تم إرسال الملاحظة الصوتية بنجاح');
    } else {
      Get.snackbar('خطأ', 'فشل في إرسال الملاحظة الصوتية');
    }
  }

//
  //
  @override
  deleteReport(int id) async {
    // Get.back();

    statusRequest = StatusRequest.loading;

    update();
    try {
      Get.back();
      update();
      statusRequest = StatusRequest.loading;

      var response = reportData.deleteReport(id);
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response is Map<String, dynamic>) {
          if (response['success'] == true) {
            Get.snackbar(
              "نجاح",
              'تم حذف التقرير بنجاح !',
              backgroundColor: AppColors.backgroundIDsColor,
              colorText: AppColors.primaryColor,
              barBlur: 4,
              animationDuration: const Duration(seconds: 5),
            );
            await fetchReportStudentForRoleTeacher();
            update();
            // hasData = true;
          }
          statusRequest = StatusRequest.loading;
          update();
        }
      } else {
        statusRequest = StatusRequest.none;
        throw Exception(response['message'] ?? 'فشل في حذف التقرير');
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

// //
//   bool hasData = false;
//   Future<ReportModel?> getUsers() {
//     if (hasData) {
//       return Future(() => reportModel);
//     } else {
//       return Future(() => null);
//     }
//   }

// //
  @override
  fetchReportStudentForRoleTeacher() async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      update();
      prefs = await SharedPreferences.getInstance();
      studentIdInRoleTeacher = prefs.getInt("student_id")!;
      // جلب البيانات
      var response = await reportData
          .getDataReportTeachereStudents(studentIdInRoleTeacher);
      statusRequest = handlingData(await response);

      if (StatusRequest.success == statusRequest) {
        // تأكد من أن response هو كائن JSON

        if (await response['success'] == true) {
          response is Map<String, dynamic>;
          log("studentIdInRoleTeacher", error: studentIdInRoleTeacher);
          reportStudentForRoleTeacher = await response['data'];
          update();
          // hasData = true;
        } else {
          statusRequest = StatusRequest.failure;
          throw Exception(await response['message']);
        }
      } else {
        statusRequest = StatusRequest.failure;
        throw Exception('Invalid response format');
      }
    } catch (e) {
      print('Error: $e');
      statusRequest = StatusRequest.failure;
    }

    update();
  }

//
  @override
  fetchReportStudentForRoleStudent() async {
    statusRequest = StatusRequest.loading;
    update();
    try {
      prefs = await SharedPreferences.getInstance();
      studentIdInRoleStudent = prefs.getInt("id")!;
      // جلب البيانات
      var response = await reportData
          .getDataReportTeachereStudents(studentIdInRoleStudent);
      statusRequest = handlingData(await response);

      if (StatusRequest.success == statusRequest) {
        // تأكد من أن response هو كائن JSON
        // if (response is Map<String, dynamic>) {
        if (response['success'] == true) {
          response is Map<String, dynamic>;
          log("studentIdInRoleTeacher", error: studentIdInRoleStudent);
          reportStudentForRoleStudent = await response['data'];
          // hasData = true;
        } else {
          statusRequest = StatusRequest.failure;
          throw Exception(await response['message']);
        }
      } else {
        statusRequest = StatusRequest.failure;
        throw Exception('Invalid response format');
        // }
      }
    } catch (e) {
      print('Error: $e');
      statusRequest = StatusRequest.failure;
    }
    update();
  }

//
  @override
  submitReport() async {
    statusRequest = StatusRequest.loading;
    update();
    // if (selectedAssessment != null) {
    try {
      prefs = await SharedPreferences.getInstance();
      studentIdd = prefs.getInt("student_id")!;
      classIdd = prefs.getInt("class_id")!;
      teacherIdd = prefs.getInt("id")!;
      startVersee = prefs.getInt("startVerse") ?? 0;
      endVersee = prefs.getInt("endVerse") ?? 0;
      selectedSurah = prefs.getString("surah");
      startVerseReview = prefs.getInt("startVerseReview") ?? 0;
      endVerseReview = prefs.getInt("endVerseReview") ?? 0;
      selectedSurahReview = prefs.getString("surahReview");

      log("$selectedSurah", name: 'selectedSurah', error: selectedSurah);
      log("$startVersee", name: 'startVersee', error: startVersee);
      log("$endVersee", name: 'endVersee', error: endVersee);
      log("$selectedSurahReview",
          name: 'selectedSurahReview', error: selectedSurahReview);
      log("$startVerseReview",
          name: 'startVerseReview', error: startVerseReview);
      log("$endVerseReview", name: 'endVerseReview', error: endVerseReview);

      // // إعداد نموذج التقرير
      // ReportModel reportModel = ReportModel(
      //   studentId: studentIdd,
      //   classId: classIdd,
      //   teacherId: teacherIdd,
      //   surah: selectedSurah,
      //   startVerse: startVersee,
      //   endVerse: endVersee,
      //   assessment: selectedAssessment,
      //   note: noteController.text,
      //   filePath: selectedFile,
      //   audioNotePath: audioFile,
      // );

      log("selectedAssessment", error: selectedAssessment);

      log("reportModel.assessment", error: reportModel.assessment);
      // final response = await reportService.sendReport(reportModel);
      var response = await reportService.sendReport(ReportModel(
        studentId: studentIdd,
        classId: classIdd,
        teacherId: teacherIdd,
        surahReview: selectedSurahReview,
        startVerseReview: startVerseReview,
        endVerseReview: endVerseReview,
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
        await prefs.remove('surahReview');
        await prefs.remove('startVerseReview');
        await prefs.remove('endVerseReview');
        statusRequest = StatusRequest.none;
        update();
        // Navigator.pop(context, true);
        Get.back(result: true);
      } else {
        statusRequest = StatusRequest.failure;
        update();
        // Handle error
        Get.snackbar(
          "حدث خطأ",
          response['message'],
          backgroundColor: AppColors.primaryColor,
          colorText: AppColors.backgroundIDsColor,
          animationDuration: const Duration(seconds: 5),
        );
        // statusRequest = StatusRequest.none;
      }
      statusRequest = StatusRequest.none;
    } catch (e) {
      log("message => e", error: e);
      return e;
    }
  }

  // @override
  // sendReport() async {
  //   prefs = await SharedPreferences.getInstance();

  //   // SharedPreferences prefs = await SharedPreferences.getInstance();

  //   teacherIdd = prefs.getInt("id")!;
  //   classIdd = prefs.getInt("class_id")!;

  //   log("$teacherIdd", name: 'teacherId', error: teacherIdd);
  //   log("$classIdd", name: 'classId', error: classIdd);
  //   studentIdd = prefs.getInt("student_id")!;
  //   log("$studentIdd", name: 'studentId', error: studentIdd);

  //   final url = Uri.parse(AppLink.addReport);

  //   var request = http.MultipartRequest('POST', url);

  //   // إضافة الحقول إلى الطلب
  //   request.fields['student_id'] = reportModel.studentId.toString();
  //   request.fields['class_id'] = reportModel.classId.toString();
  //   request.fields['teacher_id'] = reportModel.teacherId.toString();
  //   request.fields['assessment'] = reportModel.assessment ?? '';
  //   request.fields['note'] = reportModel.note ?? '';
  //   request.fields['surah'] = reportModel.surah ?? '';
  //   request.fields['startVerse'] = reportModel.startVerse.toString();
  //   request.fields['endVerse'] = reportModel.endVerse.toString();
  //   request.fields['surahReview'] = reportModel.surahReview ?? '';
  //   request.fields['startVerseReview'] =
  //       reportModel.startVerseReview.toString();
  //   request.fields['endVerseReview'] = reportModel.endVerseReview.toString();
  //   // request.fields['file_path'] = reportModel.filePath.toString();
  //   // request.fields['audio_note_path'] = reportModel.audioNotePath.toString();

  //   // إضافة الملف إذا كان موجودًا
  //   if (reportModel.filePath != null) {
  //     request.files.add(await http.MultipartFile.fromPath(
  //         'file', reportModel.filePath!.path));
  //   }

  //   // إضافة الملف الصوتي إذا كان موجودًا
  //   if (reportModel.audioNotePath != null) {
  //     request.files.add(await http.MultipartFile.fromPath(
  //         'audio_note', reportModel.audioNotePath!.path));
  //   }
  //   isLoading = true;

  //   // إرسال الطلب واستلام الاستجابة
  //   try {
  //     final response = await request.send();

  //     if (response.statusCode == 200) {
  //       final responseBody = await response.stream.bytesToString();
  //       return json.decode(responseBody);
  //     } else {
  //       return {
  //         'success': false,
  //         'message':
  //             'فشل في الاتصال بالخادم. رمز الخطأ: ${response.statusCode}',
  //       };
  //     }
  //   } catch (e) {
  //     return {
  //       'success': false,
  //       'message': 'حدث خطأ أثناء الإرسال: $e',
  //     };
  //   }
  // }

  //

  //
  @override
  void onInit() async {
    statusRequest = StatusRequest.none;
    // deleteReport(0);

    super.onInit();
    // getUsers();
    await initialData();
    prefs = await SharedPreferences.getInstance();

    // isLoading;
  }

  //
  @override
  initialData() {
    statusRequest = StatusRequest.none;
    // getUsers();
    fetchReportStudentForRoleStudent();
    reportModel = ReportModel();
    reportService = ReportService();

    // isLoading;
    fetchReportStudentForRoleTeacher();
    // prefs = await SharedPreferences.getInstance();
    //  No ADD //  submitReport();
    // submitReport();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  //

  //
  void showQuranReviewSelectionDialog(BuildContext context) {
    String? selectedSurahReview;
    int? startVerseReview;
    int? endVerseReview;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('تحديد المراجعة'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // اختيار السورة
                  DropdownButtonFormField<String>(
                    value: selectedSurahReview,
                    hint: const Text('اختر السورة'),
                    onChanged: (value) async {
                      setState(() {
                        selectedSurahReview = value;
                        startVerseReview = null;
                        endVerseReview = null;
                      });
                    },
                    items: List.generate(
                      114,
                      (index) {
                        int surahReviewNumber = index + 1;
                        return DropdownMenuItem<String>(
                          value: surahReviewNumber.toString(),
                          child: Text(
                              'سورة ${quran.getSurahNameArabic(surahReviewNumber)}'),
                        );
                      },
                    ),
                  ),
                  // اختيار آية البداية
                  if (selectedSurahReview != null)
                    DropdownButtonFormField<int>(
                      value: startVerseReview,
                      hint: const Text('اختر آية البداية'),
                      onChanged: (value) async {
                        setState(() {
                          startVerseReview = value;
                          if (endVerseReview != null &&
                              endVerseReview! < startVerseReview!) {
                            endVerseReview = null;
                          }
                        });
                      },
                      items: List.generate(
                        quran.getVerseCount(int.parse(selectedSurahReview!)),
                        (index) => DropdownMenuItem<int>(
                          value: index + 1,
                          child: Text('آية ${index + 1}'),
                        ),
                      ),
                    ),

                  // اختيار آية النهاية
                  if (startVerseReview != null)
                    DropdownButtonFormField<int>(
                      value: endVerseReview,
                      hint: const Text('اختر آية النهاية'),
                      onChanged: (value) async {
                        setState(() {
                          endVerseReview = value;
                        });
                        log("$endVerseReview", name: "$endVerseReview");
                      },
                      items: List.generate(
                        quran.getVerseCount(int.parse(selectedSurahReview!)),
                        (index) {
                          int verseReviewNumber = index + 1;
                          return verseReviewNumber >= startVerseReview!
                              ? DropdownMenuItem<int>(
                                  value: verseReviewNumber,
                                  child: Text('آية $verseReviewNumber'),
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
                  onPressed: selectedSurahReview != null &&
                          startVerseReview != null &&
                          endVerseReview != null
                      ? () {
                          Navigator.pop(context, {
                            'surahReview': selectedSurahReview,
                            'startVerseReview': startVerseReview,
                            'endVerseReview': endVerseReview,
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
            'السورة: ${quran.getSurahNameArabic(int.parse(result['surahReview']))}');
        print('من الآية: ${result['startVerseReview']}');
        print('إلى الآية: ${result['endVerseReview']}');
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('surahReview',
          quran.getSurahNameArabic(int.parse(result['surahReview'])));

      await prefs.setInt('startVerseReview', result['startVerseReview']);

      await prefs.setInt('endVerseReview', result['endVerseReview']);
    });
  }

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

  // Future<void> recordAudio() async {
  //   // طلب الإذن لاستخدام الميكروفون
  //   var status = await Permission.microphone.request();
  //   if (status.isGranted) {
  //     if (audioRecorder == null) {
  //       audioRecorder = FlutterSoundRecorder();
  //       await audioRecorder?.openRecorder();
  //     }

  //     if (!audioRecorder!.isRecording) {
  //       audioFilePath = '/path/to/save/recorded_audio.aac'; // تحديد مسار الملف
  //       await audioRecorder!.startRecorder(toFile: audioFilePath);
  //       print('Recording started');
  //     } else {
  //       await audioRecorder!.stopRecorder();
  //       print('Recording stopped, file saved at: $audioFilePath');
  //     }
  //   } else {
  //     print('Microphone permission not granted');
  //   }
  // }
  // //

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
