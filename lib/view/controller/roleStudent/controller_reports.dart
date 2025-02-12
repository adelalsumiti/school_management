import 'dart:developer';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:retry/retry.dart';
import 'package:school_management/core/class/statusrequest.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/funcations/handlinfdatacontroller.dart';
import 'package:school_management/data/dataSource/remote/roleStudent/student_data.dart';
import 'package:school_management/linkapi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quran/quran.dart' as quran;
// import 'package:http/http.dart' as http;

abstract class RoleStudentsReportController extends GetxController {
  getReports();
  deleteAudio(int? reportId, String? fieldName);
  initialData();
}

class RoleStudentsReportControllerImp extends RoleStudentsReportController {
  StudentData studentData = StudentData(Get.find());
  late SharedPreferences prefs;
  late int studentIdd;
  int? studentId;
  late int teacherIdd;
  late StatusRequest statusRequest;
  List<dynamic> reportStudent = [];
  File? selectedPickFile;
  //

  final FlutterSoundRecorder audioRecorder = FlutterSoundRecorder();
  // FlutterSoundPlayer audioPlayer = FlutterSoundPlayer();
  final FlutterSoundPlayer audioPlayer = FlutterSoundPlayer();
  bool isRecording = false;
  String? recordedFilePath;

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
  bool isPlayingg = false;
  String? playingAyah;
  Future<void> playAyahAudio(int surah, int verse) async {
    // تحديد رابط الصوت لكل آية
    String url =
        "https://www.everyayah.com/data/Minshawy_Mujawwad_64kbps/$surah${verse.toString().padLeft(3, '0')}.mp3";
    update();
    // إيقاف الصوت السابق إذا كان يعمل
    if (isPlayingg) {
      await audioPlayer.stopPlayer();
      update();
      isPlayingg = false;
      playingAyah = null;
      update();
    }
    // تشغيل الصوت الجديد
    await audioPlayer.openPlayer(isBGService: UrlSource(url));
    update();
    isPlayingg = true;
    playingAyah = "$surah:$verse";
    update();
    // عند انتهاء الصوت
    await audioPlayer.closePlayer();
    update();
    isPlayingg = false;
    playingAyah = null;
    update();
  }

  Future sendAudioSt(int reportId, File audioFile) async {
    statusRequest = StatusRequest.loading;
    update();
    var request = await studentData.sendRecordSt(reportId, audioFile);
    log("reportID: $reportId , audioFile: $audioFile ==");
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
// //
// is good:
  // Future<void> sendAudioSt(int reportId, File audioFile) async {
  //   statusRequest = StatusRequest.loading;
  //   update();
  //   try {
  //     var request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse(AppLink.submitStudentResponse),
  //     );
  //     request.fields['report_id'] = reportId.toString();
  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         'student_audio_response',
  //         audioFile.path,
  //       ),
  //     );
  //     var response = await request.send();
  //     if (response.statusCode == 200) {
  //       final responseBody = await response.stream.bytesToString();
  //       final jsonResponse = json.decode(responseBody);
  //       if (jsonResponse['success']) {
  //         Get.snackbar('نجاح', 'تم إرسال التسجيل بنجاح');
  //         print(
  //             'تم رفع الملف إلى: ${jsonResponse['file_path']}'); // طباعة المسار
  //         getReports(); // تحديث قائمة التقارير بعد الإرسال
  //       } else {
  //         Get.snackbar('خطأ', jsonResponse['message']);
  //       }
  //     } else {
  //       Get.snackbar('خطأ', 'فشل في إرسال التسجيل');
  //     }
  //   } catch (e) {
  //     Get.snackbar('خطأ', 'حدث خطأ أثناء إرسال التسجيل: $e');
  //   }
  //   statusRequest = StatusRequest.none;
  //   update();
  // }

  Future<void> startRecording() async {
    try {
      await audioRecorder.openRecorder();
      Directory tempDir = await getTemporaryDirectory();
      recordedFilePath = '${tempDir.path}/Rec_St.aac';
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

//
  Future playAudio(String? filePath) async {
    statusRequest = StatusRequest.loading;
    update();
    String? fullPath = '${AppLink.upload}$filePath';
    try {
      var response = await studentData.getPlayAudio(fullPath);
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

  @override
  void deleteAudio(int? reportId, String? fieldName) async {
    // Future deleteAudio(int? reportId, String? fieldName) async {
    Get.back();
    update();
    statusRequest = StatusRequest.loading;
    update();
    var response = await studentData.deleteAudio(
        reportId?.toInt(), fieldName?.toString().trim());
    statusRequest = await handlingData(response);
    update();
    if (StatusRequest.success == statusRequest) {
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

//
  @override
  getReports() async {
    statusRequest = StatusRequest.loading;
    update();
    try {
      prefs = await SharedPreferences.getInstance();
      studentId = prefs.getInt("id");
      update();
      var response = await studentData.getDataReports(studentId);
      statusRequest = await handlingData(response);
      update();
      if (StatusRequest.success == statusRequest) {
        if (response['success']) {
          reportStudent = response['data'];
          update();
        } else {
          statusRequest = StatusRequest.offlinefailure;
          throw Exception(response['message']);
        }
      } else {
        statusRequest = StatusRequest.offlinefailure;
        throw Exception('Invalid response format');
      }
    } catch (e) {
      print('Error: $e');
      statusRequest = StatusRequest.none;
    }
    update();
  }

  //
  @override
  void onInit() {
    statusRequest = StatusRequest.none;
    initialData();
    super.onInit();
  }

  //
  @override
  initialData() async {
    statusRequest = StatusRequest.none;
    getReports();
    await audioRecorder.openRecorder();
    await audioPlayer.openPlayer();
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
}
