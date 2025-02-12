import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:school_management/core/class/curd.dart';
import 'package:school_management/core/class/statusrequest.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/funcations/handlinfdatacontroller.dart';
import 'package:school_management/core/services/report_Service.dart';
import 'package:school_management/data/dataSource/remote/roleTeacher/report_data.dart';
import 'package:school_management/data/model/report_Model.dart';
import 'package:school_management/linkapi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quran/quran.dart' as quran;

abstract class AddReportController extends GetxController {
  submitReport(File? audioFile);
  deleteAudio(int? reportId, String? fieldName);
  getReports();
  initialData();
}

class AddReportControllerImp extends AddReportController {
  ReportData reportData = ReportData(Get.find());
  ReportService reportService = Get.find();
  late SharedPreferences prefs;
  ReportModel reportModel = ReportModel();
  String? selectedAssessment;
  String? selectedSurah;
  String? selectedSurahReview;
  TextEditingController noteController = TextEditingController();
  String? selectedFile;
  Crud crud = Crud();
  File? audioFileSelected;
  late int studentIdd;
  late int reportId;
  late int studentId;
  late int teacherIdd;
  late int teacherId;
  late int classIdd;
  late int classId;
  late int startVersee;
  late int endVersee;
  late int startVerseReview;
  late int endVerseReview;
  late StatusRequest statusRequest;
  List<dynamic> reportStudents = [];
  int? userId;
  File? selectedPickFile;
  List<String> items = ['ممتاز', 'جيد', 'متوسط', 'ضعيف'];
  FlutterSoundRecorder audioRecorder = FlutterSoundRecorder();
  late FlutterSoundPlayer audioPlayer = FlutterSoundPlayer();
  late FlutterSoundPlayer audioPlayerAyah = FlutterSoundPlayer();
  bool isRecording = false;
  String? recordedFilePath;
  bool isLoading = false;
  bool isPlayingg = false;
  bool isPlayinggAyah = false;
  String? playingAyah;
  //  مسار القارئ المختار
  String? moqra = 'Nasser_Alqatami_128kbps';
  // القيمة المختارة
  Map<String, dynamic>? selectedNameMoqra;
  //   خريطة اسماء ومسارات القراء
  final List<Map<String, dynamic>> nameMoqra = [
    {'name': 'المنشاوي', 'value': 'Minshawy_Mujawwad_64kbps'},
    {'name': 'الحصري', 'value': 'Husary_Mujawwad_64kbps'},
    {'name': 'محمد ايوب', 'value': 'Muhammad_Ayyoub_64kbps'},
    {'name': 'سعود الشريم', 'value': 'Saood_ash-Shuraym_64kbps'},
    {'name': 'ياسر الدوسري', 'value': 'Yasser_Ad-Dussary_128kbps'},
    {'name': 'ناصر القطامي', 'value': 'Nasser_Alqatami_128kbps'},
  ];
  //
  Future<void> playAyahAudio(int surah, int verse) async {
    statusRequest = StatusRequest.loading;
    update();
    isLoading = true;
    update();
    log("surahNumber", error: surah);
    log("VerseNumber", error: verse);
    // تحديد رابط الصوت لكل آية
    String fullPath =
        "https://www.everyayah.com/data/$moqra/${surah.toString().padLeft(3, '0')}${verse.toString().padLeft(3, '0')}.mp3";
    // try {
    var response = await reportData.getPlayAyahAudio(fullPath);
    statusRequest = await handlingData(await response);
    update();
    //
    if (StatusRequest.success == statusRequest) {
      isLoading = true;
      // تأكد من أن المشغل مفتوح
      if (!audioPlayerAyah.isPlaying) {
        await audioPlayerAyah.openPlayer();
        // تشغيل الصوت باستخدام المسار الكامل
        await audioPlayerAyah.startPlayer(fromURI: fullPath);
        isPlayinggAyah = true;
        playingAyah = "$surah:$verse";
        isLoading = false;
        update();
      } else {
        isLoading = false;
        await audioPlayerAyah.closePlayer();
        isPlayinggAyah = false;
        playingAyah = null;
        update();
      }
    }

    // statusRequest = StatusRequest.none;
    isLoading = false;
    update();
    // } catch (e) {
    //   // Get.snackbar('خطأ', 'فشل في تشغيل التسجيل: $e');
    //   // Get.snackbar('اشعار', 'تم ايقاف تشغيل التسجيل');
    // }
  }

//
  Future sendTeacherAudio(int reportId, File audioFile) async {
    statusRequest = StatusRequest.loading;
    update();
    var request = await reportData.sendRecord(reportId, audioFile);
    statusRequest = await handlingData(request);
    update();
    if (statusRequest == StatusRequest.success) {
      if (request['success']) {
        Get.snackbar('نجاح', 'تم إرسال التسجيل بنجاح');
        print(
            'تم رفع الملف إلى: ${request['audio_note_path']}'); // طباعة المسار
        await getReports(); // تحديث قائمة التقارير بعد الإرسال
        update();
      } else {
        statusRequest = StatusRequest.serverException;
        // Get.snackbar('خطأ', jsonResponse['message']);
        log('خطأ', error: request['message']);
      }
    } else {
      statusRequest = StatusRequest.failure;
      Get.snackbar('خطأ', 'فشل في إرسال التسجيل');
    }
  }

  Future<void> startRecording() async {
    try {
      await requestMicrophonePermission();
      await audioRecorder.openRecorder();
      Directory tempDir = await getTemporaryDirectory();
      recordedFilePath = '${tempDir.path}/recTe.aac';
      await audioRecorder.startRecorder(toFile: recordedFilePath);
      Get.snackbar('نجاح', 'بدأ التسجيل');
      update();
    } catch (e) {
      Get.snackbar('خطأ', 'فشل في بدء التسجيل: $e');
      update();
    }
  }

  Future<void> stopRecording() async {
    try {
      await audioRecorder.stopRecorder();
      Get.snackbar('نجاح', 'تم إيقاف التسجيل');
      update();
    } catch (e) {
      Get.snackbar('خطأ', 'فشل في إيقاف التسجيل: $e');
      update();
    }
  }

  Future<void> stopAudio() async {
    try {
      await audioPlayer.stopPlayer();
      await audioPlayer.closePlayer();
      Get.snackbar('نجاح', 'تم إيقاف التشغيل');
    } catch (e) {
      Get.snackbar('خطأ', 'فشل في إيقاف التشغيل: $e');
    }
  }

//
  Future<void> requestMicrophonePermission() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      status = await Permission.microphone.request();
      if (!status.isGranted) {
        throw Exception(' من فضلك فعل أذونات الميكرفون اولا');
      }
    }
  }

//
  Future playAudio(String? filePath) async {
    statusRequest = StatusRequest.loading;
    update();
    String? fullPath = '${AppLink.upload}$filePath';
    try {
      var response = await reportData.getPlayAudio(fullPath);
      statusRequest = await handlingData(response);
      update();
      if (StatusRequest.success == statusRequest) {
        // تأكد من أن المشغل مفتوح
        if (!audioPlayer.isPlaying) {
          await audioPlayer.openPlayer();
          update();
        } else {
          await audioPlayer.closePlayer();
          update();
        }
        // تشغيل الصوت باستخدام المسار الكامل
        await audioPlayer.startPlayer(fromURI: fullPath);
        update();

        Get.snackbar('نجاح', 'بدأ تشغيل التسجيل');
        if (audioPlayer.isPlaying) {
          await audioPlayer.openPlayer();
          update();
        } else if (!audioPlayer.isPaused) {
          await audioPlayer.closePlayer();
          update();
        } else {
          await audioPlayer.stopPlayer();
          update();
        }
        update();
      } else {
        Get.snackbar('خطأ', 'الملف غير موجود');
        // Get.snackbar('خطأ', 'الملف غير موجود: $fullPath');
        log('خطأ', error: 'الملف غير موجود: $fullPath');
      }

      statusRequest = StatusRequest.none;
      update();
    } catch (e) {
      // Get.snackbar('خطأ', 'فشل في تشغيل التسجيل: $e');
      Get.snackbar('اشعار', 'تم ايقاف تشغيل التسجيل');
    }
  }

//
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
  String getVersesReview(String surahName, int startVerse, int endVerse) {
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
  String getVerses(int surahName, int startVerse, int endVerse) {
    // الحصول على رقم السورة بناءً على اسمها
    int? surahNumberNew = surahMap[surahName];
    if (surahNumberNew == null) {
      return 'السورة غير موجودة';
    }
    String verses = '';
    for (int i = startVerse; i <= endVerse; i++) {
      verses +=
          ' ${quran.getVerse(surahNumberNew, i)}﴿$i﴾ '; // إضافة النص لكل آية
    }
    return verses;
  }

//
  @override
  void deleteAudio(int? reportId, String? fieldName) async {
    Get.back();
    update();
    statusRequest = StatusRequest.loading;
    update();
    var response = await reportData.deleteAudio(
        reportId?.toInt(), fieldName?.toString().trim());
    statusRequest = await handlingData(response);
    update();
    if (StatusRequest.success == statusRequest) {
      //

      if (response['success'] == true) {
        Get.snackbar(
          "نجاح",
          'تم حذف الملف الصوتي بنجاح!',
          backgroundColor: AppColors.backgroundIDsColor,
          colorText: AppColors.primaryColor,
          barBlur: 4,
          animationDuration: const Duration(seconds: 5),
        );
        update();

        await getReports(); // تحديث قائمة التقارير بعد الحذف
        update();
      }
    } else {
      statusRequest = StatusRequest.none;
      throw Exception(response['message'] ?? 'فشل في حذف الملف الصوتي');
    }
  }

  deleteReport(int? id) async {
    Get.back();
    update();
    statusRequest = StatusRequest.loading;
    update();

    var response = await reportData.deleteReport(id?.toInt());
    statusRequest = await handlingData(response);
    update();
    if (StatusRequest.success == statusRequest) {
      // if (response is Map<String, dynamic>) {
      if (response['success'] == true) {
        Get.snackbar(
          "نجاح",
          'تم حذف التقرير بنجاح !',
          backgroundColor: AppColors.backgroundIDsColor,
          colorText: AppColors.primaryColor,
          barBlur: 4,
          // animationDuration: const Duration(seconds: 5),
        );
        await getReports();
        update();
      }
    } else {
      statusRequest = StatusRequest.none;
      throw Exception(response['message'] ?? 'فشل في حذف التقرير');
    }
    statusRequest = StatusRequest.none;
    update();
  }

// //

  @override
  getReports() async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      update();
      prefs = await SharedPreferences.getInstance();
      studentId = prefs.getInt("student_id")!;
      // جلب البيانات
      var response = await reportData.getDataReport(studentId);
      statusRequest = handlingData(await response);

      if (StatusRequest.success == statusRequest) {
        // تأكد من أن response هو كائن JSON

        if (await response['success'] == true) {
          response is Map<String, dynamic>;
          log("studentId", error: studentId);
          reportStudents = await response['data'];
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
  submitReport(File? audioFile) async {
    if (audioFileSelected != null) {
      audioFile = audioFileSelected;
    }
    statusRequest = StatusRequest.loading;
    update();
    // try {
    prefs = await SharedPreferences.getInstance();
    studentIdd = prefs.getInt("student_id")!;
    classIdd = prefs.getInt("class_id")!;
    teacherIdd = prefs.getInt("id")!;
    startVersee = prefs.getInt("startVerse") ?? 0;
    endVersee = prefs.getInt("endVerse") ?? 0;
    selectedSurah = prefs.getString("surah") ?? "";
    startVerseReview = prefs.getInt("startVerseReview") ?? 0;
    endVerseReview = prefs.getInt("endVerseReview") ?? 0;
    selectedSurahReview = prefs.getString("surahReview");

    log("$selectedSurah", name: 'selectedSurah', error: selectedSurah);
    print("=========selectedSurah => $selectedSurah ==");
    // log("$startVersee", name: 'startVersee', error: startVersee);
    // log("$endVersee", name: 'endVersee', error: endVersee);
    // log("$selectedSurahReview",
    //     name: 'selectedSurahReview', error: selectedSurahReview);
    // log("$startVerseReview",
    //     name: 'startVerseReview', error: startVerseReview);
    // log("$endVerseReview", name: 'endVerseReview', error: endVerseReview);
    // log("selectedAssessment", error: selectedAssessment);
    // log("reportModel.assessment", error: reportModel.assessment);
    // final response = await reportService.sendReport(reportModel);
    final response = await reportService.sendReport(ReportModel(
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
      audioNotePath: audioFile?.path,
      filePath: audioFile?.path,
    ));
    statusRequest = await handlingData(response);
    // log("audioNotePath", error: audioFilee);
    update();
    if (StatusRequest.success == statusRequest) {
      if (response['success'] == true) {
        statusRequest = StatusRequest.none;
        update();
        Get.snackbar(
          "نجاح",
          "تم أضافة التقرير بنجاح",
          backgroundColor: AppColors.primaryColor,
          colorText: AppColors.backgroundIDsColor,
          animationDuration: const Duration(seconds: 5),
        );
        prefs = await SharedPreferences.getInstance();
        update();

        // await prefs.remove('student_id');
        // await prefs.remove('class_id');
        await prefs.remove('surah');
        await prefs.remove('startVerse');
        await prefs.remove('endVerse');
        await prefs.remove('surahReview');
        await prefs.remove('startVerseReview');
        await prefs.remove('endVerseReview');
        await getReports();
        update();
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
      }
    }

    statusRequest = StatusRequest.none;
    update();
  }

  //
  @override
  void onInit() async {
    statusRequest = StatusRequest.none;
    update();
    initialData();

    // prefs = await SharedPreferences.getInstance();
    super.onInit();
  }

  //
  @override
  initialData() async {
    statusRequest = StatusRequest.none;
    // reportModel = ReportModel();
    // reportService = ReportService();
    getReports();

    // await audioRecorder.openRecorder();
    // await audioPlayer.openPlayer();
    // await audioPlayerAyah.openPlayer();
  }

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
    // int? selectedSurah;
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
                        log("selectedSurah", name: "======$selectedSurah");
                        print("==========selectedSurah => $selectedSurah");

                        startVerse = null;
                        endVerse = null;
                      });
                    },
                    items: List.generate(
                      114,
                      (index) {
                        int surahNumber = index + 1;
                        return DropdownMenuItem(
                          // value: surahNumber.toString(),
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
                        quran
                            .getVerseCount(int.parse(selectedSurah.toString())),
                        // quran.getVerseCount(selectedSurah!),
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
                        quran
                            .getVerseCount(int.parse(selectedSurah.toString())),
                        // quran.getVerseCount(selectedSurah!),
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
      await prefs.setString('surah', selectedSurah.toString());

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
    int surahNumberNew = 2; // سورة البقرة
    int verseNumber = 255; // آية الكرسي
    print(quran.getVerse(surahNumberNew, verseNumber)); // النص الكامل للآية
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
}

//
