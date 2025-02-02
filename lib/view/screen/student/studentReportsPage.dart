import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_utils/mc_utils.dart';
import 'package:school_management/core/class/handlingdataview.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/view/controller/roleStudent/controller_reports.dart';
import 'package:school_management/view/screen/student/custom_get_report_review_quran.dart';
import 'dart:io';

import 'package:school_management/view/screen/student/custom_get_report_saved_quran.dart';
import 'package:school_management/view/widgets/custom_IconButton_Delete.dart';

class StudentReportsPage extends StatelessWidget {
  StudentReportsPage({super.key});

  final RoleStudentsReportControllerImp control =
      Get.put(RoleStudentsReportControllerImp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text('التقارير المرسلة'),
        actions: [
          IconButton(
            onPressed: () async {
              control.getReports();
            },
            icon: const Icon(Icons.refresh_outlined),
          ),
        ],
      ),
      body: GetBuilder<RoleStudentsReportControllerImp>(
        builder: (controller) => HandlingDataView(
          statusRequest: controller.statusRequest,
          widget: Container(
            padding: const EdgeInsets.all(10),
            margin:
                const EdgeInsets.only(top: 10, bottom: 5, right: 8, left: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              boxShadow: const [BoxShadow(blurRadius: 3, spreadRadius: 2)],
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListView.builder(
              itemCount: controller.reportStudent.length,
              itemBuilder: (context, index) {
                final report = controller.reportStudent[index];
                return Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    margin: const EdgeInsets.only(top: 10, right: 2, left: 2),
                    // margin: const EdgeInsets.only(
                    //     top: 10, bottom: 15, right: 10, left: 0),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundIDsColor,
                      boxShadow: const [
                        BoxShadow(blurRadius: 5, spreadRadius: 2)
                      ],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Wrap(
                              spacing: 5,
                              runSpacing: 5,
                              direction: Axis.vertical,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'التقييم: ${report['assessment']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 5,
                                  runSpacing: 5,
                                  direction: Axis.vertical,
                                  alignment: WrapAlignment.center,
                                  children: [
                                    Text(
                                        'ملاحظة: ${report['note'] ?? 'لا توجد ملاحظات'}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal)),
                                    Text('التاريخ: ${report['date']}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    // Wrap(
                                    //   spacing: 5,
                                    //   crossAxisAlignment:
                                    //       WrapCrossAlignment.center,
                                    //   runSpacing: 5,
                                    //   runAlignment: WrapAlignment.spaceBetween,
                                    //   alignment: WrapAlignment.center,
                                    //   direction: Axis.horizontal,
                                    //   children: [
                                    //     if (report['audio_note_path'] != null)
                                    //       McButton(
                                    //         blod: true,
                                    //         colorBtn: AppColors.primaryColor,
                                    //         txt: 'تسجيل المعلم',
                                    //         fontSize: 15,
                                    //         onTap: () {
                                    //           controller.playAudio(
                                    //               report['audio_note_path']);
                                    //         },
                                    //       ),
                                    //     if (report[
                                    //             'student_audio_response_path'] !=
                                    //         null)
                                    //       McButton(
                                    //         blod: true,
                                    //         colorBtn: AppColors.primaryColor,
                                    //         txt: 'تسجيل الطالب',
                                    //         fontSize: 15,
                                    //         onTap: () async {
                                    //           controller.playAudio(report[
                                    //               'student_audio_response_path']);
                                    //         },
                                    //       ),
                                    //   ],
                                    // )
                                    // //
                                    // ,

                                    //
                                    Wrap(
                                      spacing: 5,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      runSpacing: 5,
                                      runAlignment: WrapAlignment.spaceBetween,
                                      alignment: WrapAlignment.center,
                                      direction: Axis.horizontal,
                                      children: [
                                        if (report['audio_note_path'] != null)
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            decoration: BoxDecoration(
                                                color: AppColors.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Wrap(
                                              children: [
                                                controller.audioPlayer.isStopped
                                                    ? Row(
                                                        children: [
                                                          TextButton(
                                                            child: const Text(
                                                                'تسجيل المعلم',
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      AppColors
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15,
                                                                )),
                                                            onPressed: () {
                                                              controller.playAudio(
                                                                  report[
                                                                      'audio_note_path']);
                                                              controller
                                                                  .audioPlayer
                                                                  .isPlaying;
                                                              controller
                                                                      .audioPlayer
                                                                      .isStopped ==
                                                                  false;
                                                              // controller
                                                              //     .update();
                                                            },
                                                          ),
                                                        ],
                                                      )
                                                    //
                                                    : IconButton(
                                                        iconSize: 30,
                                                        icon: const Icon(Icons
                                                                .pause_presentation_sharp
                                                            // : Icons.mic
                                                            ),
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                const WidgetStatePropertyAll(
                                                                    AppColors
                                                                        .actionColor),
                                                            alignment: Alignment
                                                                .center,
                                                            iconColor:
                                                                WidgetStateProperty
                                                                    .all(AppColors
                                                                        .backgroundIDsColor)),
                                                        onPressed: () async {
                                                          controller.audioPlayer
                                                              .isStopped;
                                                          controller.update();
                                                        },
                                                      ),
                                              ],
                                            ),
                                          ),
                                        //

                                        //
                                        if (report[
                                                'student_audio_response_path'] !=
                                            null)
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            decoration: BoxDecoration(
                                                color: AppColors.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Wrap(children: [
                                              controller.audioPlayer.isStopped
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        TextButton(
                                                          child: const Text(
                                                              'تسجيل الطالب',
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15,
                                                              )),
                                                          onPressed: () async {
                                                            controller.playAudio(
                                                                report[
                                                                    'student_audio_response_path']);
                                                          },
                                                        ),
                                                        CustomButtonDelete(
                                                          bodyMessage:
                                                              'هل أنت متأكد من حذف تسجيل الطالب ؟',
                                                          titileMessage:
                                                              'تأكيد الحذف ؟ ',
                                                          onPressedCancel: () =>
                                                              Get.back(),
                                                          onPressedYes:
                                                              () async {
                                                            controller.deleteAudio(
                                                                report['id'],
                                                                'student_audio_response_path');
                                                          },
                                                        ),
                                                      ],
                                                    )
                                                  : IconButton(
                                                      iconSize: 30,
                                                      icon: const Icon(Icons
                                                              .pause_presentation_sharp
                                                          // : Icons.mic
                                                          ),
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              const WidgetStatePropertyAll(
                                                                  AppColors
                                                                      .actionColor),
                                                          alignment:
                                                              Alignment.center,
                                                          iconColor:
                                                              WidgetStateProperty
                                                                  .all(AppColors
                                                                      .backgroundIDsColor)),
                                                      onPressed: () async {
                                                        controller.audioPlayer
                                                            .isStopped;
                                                        controller.update();
                                                      },
                                                    ),
                                            ]),
                                          ),
                                        //

                                        //
                                      ],
                                    )
                                    //
                                    ,
                                  ],
                                ),
                              ]),
                          const SizedBox(
                            height: 8,
                          ),
                          Wrap(
                            spacing: 5,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            runSpacing: 5,
                            runAlignment: WrapAlignment.center,
                            alignment: WrapAlignment.center,
                            direction: Axis.horizontal,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          spreadRadius: 0.5, blurRadius: 4)
                                    ],
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(15)),
                                height: 45,
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
                                        child: StudentReportSavedQuranPage(
                                          reportsSaved: [
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
                              Container(
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          spreadRadius: 0.5, blurRadius: 4)
                                    ],
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(15)),
                                height: 45,
                                child: TextButton(
                                  child: const Text(
                                    "مراجعة",
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
                                        child: StudentReportReviewQuranPage(
                                          reportsReview: [
                                            {
                                              "surahReview":
                                                  report['surahReview'],
                                              "startVerseReview":
                                                  report['startVerseReview'],
                                              "endVerseReview":
                                                  report['endVerseReview'],
                                            }
                                          ],
                                        )));
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Wrap(
                            children: [
                              IconButton(
                                iconSize: 30,
                                icon: Icon(controller.isRecording
                                    ? Icons.pause_presentation_sharp
                                    : Icons.mic),
                                style: ButtonStyle(
                                    backgroundColor:
                                        const WidgetStatePropertyAll(
                                            AppColors.actionColor),
                                    alignment: Alignment.center,
                                    iconColor: WidgetStateProperty.all(
                                        controller.isRecording
                                            ? AppColors.backgroundIDsColor
                                            : AppColors.backgroundIDsColor)),
                                onPressed: () async {
                                  if (controller.isRecording) {
                                    await controller.stopRecording();
                                    controller.isRecording = false;
                                  } else {
                                    await controller.startRecording();
                                    controller.isRecording = true;
                                  }
                                },
                              ),
                              if (controller.recordedFilePath != null)
                                ElevatedButton(
                                  onPressed: () async {
                                    await controller.sendAudioSt(
                                      report['id'],
                                      File(controller.recordedFilePath!),
                                    );
                                  },
                                  style: const ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                          AppColors.actionColor)),
                                  child: const Text(
                                    'إرسال التسجيل',
                                    style: TextStyle(
                                        color: AppColors.backgroundIDsColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                            ],
                          ),
                        ]));
              },
            ),
          ),
        ),
      ),
    );
  }
}
