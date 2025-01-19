// import 'dart:developer';

// ignore_for_file: must_be_immutable

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_utils/mc_utils.dart';
import 'package:school_management/core/class/handlingdataview.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/constant/routes.dart';
import 'package:school_management/view/controller/controller_addReport.dart';
import 'package:school_management/view/screen/student/audioNoteDialog.dart';
import 'package:school_management/view/screen/student/custom_get_report_review_quran.dart';
import 'package:school_management/view/screen/student/custom_get_report_saved_quran.dart';
import 'package:school_management/view/screen/student/recording_Screen.dart';
// import 'package:school_management/view/widgets/custom_IconButton_Delete.dart';
import 'package:school_management/view/widgets/custom_TextButton_Delete.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailReport extends StatelessWidget {
  DetailReport({super.key});

  AddReportControllerImp control = Get.put(AddReportControllerImp());

  @override
  Widget build(BuildContext context) {
    Get.put(AddReportControllerImp());
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.backgroundIDsColor,
            onPressed: () {
              Get.toNamed(AppRoute.addReportPage);
            },
            child: const Text(
              "تقرير\nجديد",
              style: TextStyle(
                  color: AppColors.black, fontWeight: FontWeight.bold),
            )),
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: const Text(
            "التقارير",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          // actions: [
          //   IconButton(
          //       onPressed: () {},
          //       icon: const Icon(
          //         Icons.refresh,
          //         color: AppColors.black,
          //       ))
          // ],
        ),
        body: GetBuilder<AddReportControllerImp>(
            builder: (controller) => HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget:
                      // controller.isLoading == true
                      // ? const Center(
                      //     child: CircularProgressIndicator(),
                      //   )
                      // :
                      Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        // flex: 30,
                        child: Container(
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
                              shrinkWrap: true,
                              itemCount:
                                  controller.reportStudentForRoleTeacher.length,
                              itemBuilder: (context, index) {
                                final report = controller
                                    .reportStudentForRoleTeacher[index];
                                // log("'التقييم: ${report['assessment']}'",
                                //     error: report['assessment']);
                                // final item =
                                //     controller.reportStudentForRoleTeacher[index];

                                return Container(
                                  // clipBehavior: Clip.none,
                                  // height: Get.height,
                                  // height:
                                  //     Get.height / Get.width + Get.height / 2,
                                  // height: 150,
                                  // width: Get.height,
                                  // height: Get.width,
                                  padding: const EdgeInsets.only(
                                      top: 8, bottom: 10, right: 2, left: 2),

                                  // padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(
                                      top: 8, bottom: 10, right: 2, left: 2),
                                  decoration: BoxDecoration(
                                      color: AppColors.backgroundIDsColor,
                                      boxShadow: const [
                                        BoxShadow(
                                            blurRadius: 3, spreadRadius: 2)
                                      ],
                                      borderRadius: BorderRadius.circular(20)),
                                  //
                                  child: McCardItem(
                                      margin: const EdgeInsets.all(5),
                                      padding: const EdgeInsets.only(
                                          right: 25, left: 2, bottom: 15),
                                      // width: Get.height,
                                      // hight: 200,
                                      child: Wrap(
                                        spacing: 5,
                                        runSpacing: 5,
                                        direction: Axis.vertical,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        // alignment: WrapAlignment.start,
                                        // mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          // ListTile(
                                          // title:
                                          Text(
                                            'التقييم: ${report['assessment']}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          // const SizedBox(
                                          //   height: 10,
                                          // ),
                                          // subtitle:
                                          Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            spacing: 5,
                                            runSpacing: 5,
                                            direction: Axis.vertical,
                                            alignment: WrapAlignment.center,
                                            children: [
                                              Text(
                                                  'ملاحظة: ${report['note'] ?? 'لا توجد ملاحظات'}',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal)),
                                              // Text('المعلم: ${report['teacher_name']}'),
                                              Wrap(
                                                spacing: 5,
                                                // runAlignment: WrapAlignment.center,
                                                // runSpacing: 5,
                                                // alignment: WrapAlignment.center,
                                                // crossAxisAlignment:
                                                //     WrapCrossAlignment.center,
                                                direction: Axis.vertical,
                                                // mainAxisAlignment:
                                                //     MainAxisAlignment.spaceAround,
                                                children: [
                                                  // Text('التاريخ: ${report['date']}',
                                                  //     style: const TextStyle(
                                                  //         fontWeight: FontWeight.bold)),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 0,
                                                            top: 10,
                                                            left: 115),
                                                    child: Text(
                                                        'التاريخ: ${report['date']}',
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                ],
                                              ),
                                              if (report['file_path'] != null)
                                                TextButton(
                                                  onPressed: () {
                                                    // فتح الملف
                                                    launchUrl(
                                                        report['file_path'],
                                                        mode: LaunchMode
                                                            .externalApplication);
                                                  },
                                                  child:
                                                      const Text('فتح الملف'),
                                                ),
                                              if (report['audio_note_path'] !=
                                                  null)
                                                TextButton(
                                                  onPressed: () {
                                                    // تشغيل الصوت
                                                    playAudio(report[
                                                        'audio_note_path']);
                                                  },
                                                  child:
                                                      const Text('تشغيل الصوت'),
                                                ),
                                            ],
                                          ),
                                          // leading:
                                          // Text('${report['date']}',
                                          //     style: const TextStyle(
                                          //         fontWeight: FontWeight.bold)),
                                          // trailing:
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Wrap(
                                            spacing: 5,
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            runSpacing: 5,
                                            runAlignment: WrapAlignment.center,
                                            alignment: WrapAlignment.center,
                                            direction: Axis.horizontal,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          spreadRadius: 0.5,
                                                          blurRadius: 4)
                                                    ],
                                                    color:
                                                        AppColors.primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                height: 45,
                                                // width: 105,
                                                // height: Get.height,
                                                child: TextButton(
                                                  child: const Text(
                                                    "مقرر الحفظ",
                                                    style: TextStyle(
                                                        color: AppColors.darker,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  onPressed: () {
                                                    Get.bottomSheet(Container(
                                                        width: Get.height,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child:
                                                            StudentReportSavedQuranPage(
                                                          reportsSaved: [
                                                            {
                                                              "surah": report[
                                                                  'surah'],
                                                              "startVerse": report[
                                                                  'startVerse'],
                                                              "endVerse": report[
                                                                  'endVerse'],
                                                            }
                                                          ],
                                                        )));
                                                  },
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          spreadRadius: 0.5,
                                                          blurRadius: 4)
                                                    ],
                                                    color:
                                                        AppColors.primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                height: 45,
                                                // width: 105,
                                                // height: Get.height,
                                                child: TextButton(
                                                  //
                                                  onPressed: () =>
                                                      // await Permission.microphone
                                                      //     .request();
                                                      // await Permission.storage
                                                      //     .request();
                                                      Get.to(() =>
                                                          const RecordingScreen()),

                                                  // showAudioNoteDialog(
                                                  //     context),

                                                  // tooltip: 'إضافة ملاحظة صوتية',
                                                  child: const Icon(Icons.mic),
                                                  //

                                                  // child: const Text(
                                                  //   "تسميع",
                                                  //   style: TextStyle(
                                                  //       color: AppColors.darker,
                                                  //       fontWeight:
                                                  //           FontWeight.bold),
                                                  // ),
                                                  //
                                                  // onPressed: () {},
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          spreadRadius: 0.5,
                                                          blurRadius: 4)
                                                    ],
                                                    color:
                                                        AppColors.primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                height: 45,
                                                // width: 105,
                                                // height: Get.height,
                                                child: TextButton(
                                                  child: const Text(
                                                    "مراجعة",
                                                    style: TextStyle(
                                                        color: AppColors.darker,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  onPressed: () {
                                                    Get.bottomSheet(Container(
                                                        width: Get.height,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child:
                                                            StudentReportReviewQuranPage(
                                                          reportsReview: [
                                                            {
                                                              "surahReview": report[
                                                                  'surahReview'],
                                                              "startVerseReview":
                                                                  report[
                                                                      'startVerseReview'],
                                                              "endVerseReview":
                                                                  report[
                                                                      'endVerseReview'],
                                                            }
                                                          ],
                                                        )));
                                                  },
                                                ),
                                              ),
                                              CustomTextButtonDelete(
                                                  nameButton: 'حذف',
                                                  titileMessage: "تأكيد الحذف",
                                                  bodyMessage:
                                                      'هل أنت متأكد من حذف هذا التقرير ؟',
                                                  onPressedCancel: () =>
                                                      Get.back(),
                                                  onPressedYes: () async {
                                                    Get.back();
                                                    controller.update();

                                                    await controller
                                                        .deleteReport(
                                                            report['id']);
                                                  }),
                                            ],
                                          ),
                                          // ],

                                          // )));
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
                                        ],
                                      )),

                                  //
                                  //
                                  // child:
                                  //  Column(
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   children: [
                                  //     ListTile(
                                  //       selected: true,
                                  //       selectedColor: AppColors.black,

                                  //       title: Text(
                                  //         'التقييم: ${item['assessment']}',
                                  //         style: const TextStyle(
                                  //             fontWeight: FontWeight.bold),
                                  //       ),
                                  //       subtitle: Text(
                                  //         'الملاحظة: ${item['note']}',
                                  //         style: const TextStyle(
                                  //             fontWeight: FontWeight.bold),
                                  //       ),
                                  //       // dense: true,
                                  //       // leading: Text('التاريخ: ${item['date']}'),
                                  //       // visualDensity: const VisualDensity(
                                  //       //     vertical: 4, horizontal: 4),
                                  //       // horizontalTitleGap: 5,
                                  //       leading: Text(
                                  //         ' ${item['date']}',
                                  //         style: const TextStyle(
                                  //             fontWeight: FontWeight.bold),
                                  //       ),
                                  //       trailing: Wrap(
                                  //         crossAxisAlignment:
                                  //             WrapCrossAlignment.start,
                                  //         children: [
                                  //           Column(
                                  //             // verticalDirection:
                                  //             //     VerticalDirection.down,
                                  //             crossAxisAlignment:
                                  //                 CrossAxisAlignment.start,
                                  //             mainAxisSize: MainAxisSize.min,
                                  //             //
                                  //             // mainAxisAlignment:
                                  //             //     MainAxisAlignment.center,
                                  //             children: [
                                  //               Container(
                                  //                 // padding: const EdgeInsets.only(
                                  //                 //   bottom: 5,
                                  //                 //   top: 5,
                                  //                 // ),
                                  //                 decoration: BoxDecoration(
                                  //                     boxShadow: const [
                                  //                       BoxShadow(
                                  //                           spreadRadius: 0.5,
                                  //                           blurRadius: 4)
                                  //                     ],
                                  //                     color:
                                  //                         AppColors.primaryColor,
                                  //                     borderRadius:
                                  //                         BorderRadius.circular(
                                  //                             15)),
                                  //                 height: 35,
                                  //                 width: 110,
                                  //                 // height: Get.height,
                                  //                 child: TextButton(
                                  //                   child: const Text(
                                  //                     "مقرر الحفظ",
                                  //                     style: TextStyle(
                                  //                         color: AppColors.darker,
                                  //                         fontWeight:
                                  //                             FontWeight.bold),
                                  //                   ),
                                  //                   onPressed: () {
                                  //                     Get.bottomSheet(Container(
                                  //                         width: Get.height,
                                  //                         decoration: BoxDecoration(
                                  //                             borderRadius:
                                  //                                 BorderRadius
                                  //                                     .circular(
                                  //                                         20)),
                                  //                         child:
                                  //                             StudentReportQuranPage(
                                  //                           reports: [
                                  //                             {
                                  //                               "surah":
                                  //                                   item['surah'],
                                  //                               "startVerse": item[
                                  //                                   'startVerse'],
                                  //                               "endVerse": item[
                                  //                                   'endVerse'],
                                  //                             }
                                  //                           ],
                                  //                         )));
                                  //                   },
                                  //                 ),
                                  //               ),
                                  //               // const SizedBox(
                                  //               //   height: 5,
                                  //               // ),
                                  //               CustomTextButtonDelete(
                                  //                   nameButton: 'حذف',
                                  //                   titileMessage: "تأكيد الحذف",
                                  //                   bodyMessage:
                                  //                       'هل أنت متأكد من حذف هذا التقرير ؟',
                                  //                   onPressedCancel: () =>
                                  //                       Get.back(),
                                  //                   onPressedYes: () {
                                  //                     controller.deleteReport(
                                  //                         item['id']);
                                  //                   }),

                                  //             ],
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //     // const SizedBox(width: 3)
                                  //   ],
                                  // ),
                                );
                              }),
                        ),
                      ),
                      // const SizedBox(height: 40)
                    ],
                  ),
                )));
  }

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

  void showAudioNoteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AudioNoteDialog(onSubmit: (audioFile) {
          // استدعاء الوظيفة لإرسال الملاحظة الصوتية هنا
          control.sendAudioNoteToTeacher(audioFile);
        });
      },
    );
  }
}

//
//

// },
