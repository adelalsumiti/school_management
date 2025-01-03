// import 'dart:convert';
// import 'dart:developer';
// import 'dart:nativewrappers/_internal/vm/lib/developer.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
import 'package:school_management/core/constant/colors.dart';
// import 'package:school_management/linkapi.dart';
import 'package:school_management/view/controller/controller_addReport.dart';
import 'package:school_management/view/screen/student/custom_get_report_quran.dart';
import 'package:school_management/view/widgets/custom_TextButton_Delete.dart';
// import 'package:school_management/view/screen/student/custom_fetch_quran.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:quran/quran.dart' as quran;

class StudentReportsPage extends StatelessWidget {
  const StudentReportsPage({
    super.key,
  });
//

  // String getVerses(int surah, int startVerse, int endVerse) {
  //   String? verses = '';
  //   for (int i = startVerse; i <= endVerse; i++,) {
  //     verses = "${quran.getVerse(surah, i)}\n"; // إضافة النص لكل آية
  //   }
  //   return verses!;
  // }

  //
  String getVerses(String surahName, int startVerse, int endVerse) {
    // الحصول على رقم السورة بناءً على اسمها
    int? surahNumber = quran.getJuzNumber(startVerse, endVerse);

    String verses = '';
    for (int i = startVerse; i <= endVerse; i++) {
      verses += '${quran.getVerse(surahNumber, i)}\n'; // إضافة النص لكل آية
    }
    return verses;
  }

  //
  @override
  Widget build(BuildContext context) {
    Get.put(AddReportControllerImp());
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: const Text('التقارير المرسلة'),
        ),
        body:
            //  FutureBuilder<List<dynamic>>(
            // future: control.initialData(),
            // builder: (context, snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return const Center(child: CircularProgressIndicator());
            // } else if (snapshot.hasError) {
            //   return Center(
            //       child: Text('خطأ في جلب البيانات: ${snapshot.error}'));
            // } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            //   return const Center(child: Text('لا توجد تقارير متاحة.'));
            // } else {
            //   final reports = snapshot.data!;
            // return
            GetBuilder<AddReportControllerImp>(
                builder: (controller) => controller.isLoading == true
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(
                            top: 10, bottom: 5, right: 10, left: 10),
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            boxShadow: const [
                              BoxShadow(blurRadius: 3, spreadRadius: 2)
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        child: ListView.builder(
                          itemCount:
                              controller.reportStudentForRoleStudent.length,
                          itemBuilder: (context, index) {
                            final report =
                                controller.reportStudentForRoleStudent[index];
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
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'ملاحظة: ${report['note'] ?? 'لا توجد ملاحظات'}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal)),
                                    // Text('المعلم: ${report['teacher_name']}'),
                                    Text('التاريخ: ${report['date']}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    if (report['file_path'] != null)
                                      TextButton(
                                        onPressed: () {
                                          // فتح الملف
                                          launchUrl(report['file_path'],
                                              mode: LaunchMode
                                                  .externalApplication);
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
                                leading: Text('${report['date']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                trailing: Container(
                                  padding: const EdgeInsets.only(
                                    bottom: 5,
                                    top: 5,
                                  ),
                                  decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                            spreadRadius: 0.5, blurRadius: 4)
                                      ],
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  height: 45,
                                  width: 110,
                                  // height: Get.height,
                                  child: TextButton(
                                    child: const Text(
                                      "مقرر الحفظ",
                                      style: TextStyle(
                                          color: AppColors.darker,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      Get.bottomSheet(Container(
                                          width: Get.height,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: StudentReportQuranPage(
                                            reports: [
                                              {
                                                "surah": report['surah'],
                                                "startVerse":
                                                    report['startVerse'],
                                                "endVerse": report['endVerse'],
                                              }
                                            ],
                                          )));
                                    },
                                  ),
                                ),
                                // trailing: IconButton(
                                //     onPressed: () {
                                //       Get.to(() => StudentReportQuranPage(
                                //             reports: [
                                //               {
                                //                 "surah": report['surah'],
                                //                 "startVerse":
                                //                     report['startVerse'],
                                //                 "endVerse": report['endVerse'],
                                //               }
                                //             ],
                                //           ));
                                //       // Get.bottomSheet(
                                //       //     // Container(
                                //       //     // width: Get.height,
                                //       //     // decoration: BoxDecoration(
                                //       //     //     color: AppColors.primaryColor,
                                //       //     //     borderRadius:
                                //       //     //         BorderRadius.circular(20)),

                                //       //     // child: const Column(
                                //       //     //   mainAxisAlignment:
                                //       //     //       MainAxisAlignment.center,
                                //       //     //   children: [Text("data")],
                                //       //     // )

                                //       //     //
                                //       //     // child:
                                //       //     Expanded(
                                //       //   child: ListView.builder(
                                //       //     shrinkWrap: true,
                                //       //     itemCount: controller
                                //       //         .reportStudentForRoleStudent
                                //       //         .length,
                                //       //     itemBuilder: (context, index) {
                                //       //       final report = controller
                                //       //               .reportStudentForRoleStudent[
                                //       //           index];
                                //       //       int surah =
                                //       //           int.parse(report['surah']);
                                //       //       int startVerse =
                                //       //           int.parse(report['startVerse']);
                                //       //       int endVerse =
                                //       //           int.parse(report['endVerse']);

                                //       //       final verses = getVerses(
                                //       //           surah.toString(),
                                //       //           startVerse,
                                //       //           endVerse);

                                //       //       return Card(
                                //       //         margin: const EdgeInsets.all(8.0),
                                //       //         child: Padding(
                                //       //           padding:
                                //       //               const EdgeInsets.all(16.0),
                                //       //           child: Column(
                                //       //             crossAxisAlignment:
                                //       //                 CrossAxisAlignment.start,
                                //       //             children: [
                                //       //               Text(
                                //       //                 'سورة: ${quran.getSurahNameEnglish(report['surah'])}',
                                //       //                 // surah,
                                //       //                 style: const TextStyle(
                                //       //                     fontWeight:
                                //       //                         FontWeight.bold,
                                //       //                     fontSize: 18),
                                //       //               ),
                                //       //               const SizedBox(height: 8.0),
                                //       //               Text(
                                //       //                 'الآيات: $startVerse - $endVerse',
                                //       //                 style: const TextStyle(
                                //       //                     fontSize: 16),
                                //       //               ),
                                //       //               const SizedBox(height: 8.0),
                                //       //               Text(
                                //       //                 verses,
                                //       //                 style: const TextStyle(
                                //       //                     fontSize: 14),
                                //       //               ),
                                //       //             ],
                                //       //           ),
                                //       //         ),
                                //       //       );
                                //       //     },
                                //       //     // ),
                                //       //   ),
                                //       //   // ),
                                //       // ));
                                //     },
                                //     icon: const Icon(Icons.folder_open)),
                              ),
                            );
                          },
                        ),
                      )));
  }

  // },
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
  void launchUrl(String fileUrl, {required LaunchMode mode}) async {
    final uri = Uri.parse(fileUrl);
    launchUrl('https://example.com/sample.pdf', mode: mode);

    if (await canLaunchUrl(uri)) {
      launchUrl(uri as String, mode: LaunchMode.externalApplication);
    } else {
      throw 'لا يمكن فتح الرابط: $fileUrl';
    }
  }
}
