import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_utils/mc_utils.dart';
import 'package:school_management/core/class/handlingdataview.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/constant/routes.dart';
import 'package:school_management/view/controller/controller_addReport.dart';
import 'package:school_management/view/screen/student/custom_get_report_review_quran.dart';
import 'package:school_management/view/screen/student/custom_get_report_saved_quran.dart';
import 'package:school_management/view/widgets/custom_TextButton_Delete.dart';

// ignore: must_be_immutable
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
        ),
        body: GetBuilder<AddReportControllerImp>(
            builder: (controller) => HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(
                        top: 10, bottom: 5, right: 8, left: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      boxShadow: const [
                        BoxShadow(blurRadius: 3, spreadRadius: 2)
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListView.builder(
                      itemCount: controller.reportStudentForRoleTeacher.length,
                      itemBuilder: (context, index) {
                        final report =
                            controller.reportStudentForRoleTeacher[index];
                        return Container(
                            padding: const EdgeInsets.only(bottom: 20),
                            margin: const EdgeInsets.only(
                                top: 10, right: 2, left: 2),
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
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
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
                                            Text('التاريخ: ${report['date']}',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Wrap(
                                              spacing: 5,
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              runSpacing: 5,
                                              runAlignment:
                                                  WrapAlignment.spaceBetween,
                                              alignment: WrapAlignment.center,
                                              direction: Axis.horizontal,
                                              children: [
                                                if (report['audio_note_path'] !=
                                                    null)
                                                  McButton(
                                                    blod: true,
                                                    colorBtn:
                                                        AppColors.primaryColor,
                                                    txt: 'تسجيل المعلم',
                                                    fontSize: 15,
                                                    onTap: () {
                                                      controller.playAudio(report[
                                                          'audio_note_path']);
                                                    },
                                                  ),
                                                if (report[
                                                        'student_audio_response_path'] !=
                                                    null)
                                                  McButton(
                                                    blod: true,
                                                    colorBtn:
                                                        AppColors.primaryColor,
                                                    txt: 'تسجيل الطالب',
                                                    fontSize: 15,
                                                    onTap: () async {
                                                      controller.playAudio(report[
                                                          'student_audio_response_path']);
                                                    },
                                                  ),
                                              ],
                                            )
                                            //
                                            ,
                                          ],
                                        ),
                                      ]),
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
                                                    ? AppColors
                                                        .backgroundIDsColor
                                                    : AppColors
                                                        .backgroundIDsColor)),
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
                                            await controller.sendTeacherAudio(
                                              report['id'],
                                              File(
                                                  controller.recordedFilePath!),
                                            );
                                          },
                                          style: const ButtonStyle(
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                      AppColors.actionColor)),
                                          child: const Text(
                                            'إرسال التسجيل',
                                            style: TextStyle(
                                                color: AppColors
                                                    .backgroundIDsColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                    ],
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
                                            color: AppColors.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(15)),
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
                                                        BorderRadius.circular(
                                                            20)),
                                                child:
                                                    StudentReportSavedQuranPage(
                                                  reportsSaved: [
                                                    {
                                                      "surah": report['surah'],
                                                      "startVerse":
                                                          report['startVerse'],
                                                      "endVerse":
                                                          report['endVerse'],
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
                                            color: AppColors.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(15)),
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
                                                        BorderRadius.circular(
                                                            20)),
                                                child:
                                                    StudentReportReviewQuranPage(
                                                  reportsReview: [
                                                    {
                                                      "surahReview":
                                                          report['surahReview'],
                                                      "startVerseReview": report[
                                                          'startVerseReview'],
                                                      "endVerseReview": report[
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
                                          onPressedCancel: () => Get.back(),
                                          onPressedYes: () async {
                                            Get.back();
                                            controller.update();

                                            await controller
                                                .deleteReport(report['id']);
                                          }),
                                    ],
                                  ),
                                ]));
                      },
                    ),
                  ),
                )));
  }
}
