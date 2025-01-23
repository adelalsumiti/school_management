// import 'dart:developer';

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_utils/mc_utils.dart';
import 'package:school_management/core/class/handlingdataview.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/view/controller/controller_addReport.dart';
// import 'package:school_management/view/screen/student/audioNoteDialog.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:quran/quran.dart' as quran;

class AddReportPage extends StatelessWidget {
  AddReportPage({
    super.key,
  });
  AddReportControllerImp control = Get.put(AddReportControllerImp());

  @override
  Widget build(BuildContext context) {
    Get.put(AddReportControllerImp());
    // Get.arguments({studentId: "studentId", teacherId: "id"});
    return Scaffold(
        appBar: AppBar(title: const Text('إضافة تقرير')),
        body: GetBuilder<AddReportControllerImp>(
            builder: (controller) => HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget:
                      // controller.isLoading == true
                      //     ? const Center(
                      //         child: CircularProgressIndicator(),
                      //       )
                      // :
                      Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Visibility(
                      visible: true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          McDropDownBtn<String?>(
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            listItemStyle: const TextStyle(
                                decorationColor: AppColors.primaryColor,
                                fontSize: 15),
                            headerStyle: const TextStyle(fontSize: 18),
                            radius: 15,
                            color: AppColors.primaryColor,
                            title: "التقييم",
                            list: controller.items,
                            model: controller.selectedAssessment,
                            onChange: (p0) =>
                                controller.selectedAssessment = p0,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: TextFormField(
                              // enableInteractiveSelection: false,
                              // enableIMEPersonalizedLearning: false,
                              // enableSuggestions: false,
                              cursorRadius: const Radius.circular(20),
                              cursorColor: AppColors.primaryColor,
                              // enableSuggestions: true,
                              // showCursor: true,

                              strutStyle: const StrutStyle(),
                              controller: controller.noteController,
                              decoration: const InputDecoration(
                                  labelText: '   اضغط لكتابة ملاحظة'),
                            ),
                          ),
                          McButton(
                              colorBorder: AppColors.black,
                              colorBtn: AppColors.primaryColor,
                              onTap: () async {
                                await controller.pickFile();
                              },
                              blod: true,
                              txt: 'تحميل ملف'),
                          const SizedBox(
                            height: 10,
                          ),
                          McButton(
                              colorBorder: AppColors.black,
                              colorBtn: AppColors.primaryColor,
                              onTap: () async {
                                // showAudioNoteDialog(context);
                                // Get.to(() => const RecordingScreen());
                                // await controller.recordAudio();
                              },
                              blod: true,
                              txt: 'تسجيل ملاحظة صوتية'),
                          const SizedBox(
                            height: 10,
                          ),
                          McButton(
                              colorBorder: AppColors.black,
                              colorBtn: AppColors.primaryColor,
                              onTap: () async {
                                await controller.pickFile();
                              },
                              blod: true,
                              txt: 'تحميل ملف'),
                          const SizedBox(
                            height: 10,
                          ),
                          McButton(
                              colorBorder: AppColors.black,
                              colorBtn: AppColors.primaryColor,
                              onTap: () =>
                                  controller.showQuranSelectionDialog(context),
                              blod: true,
                              txt: 'اختيار الحفظ'),
                          const SizedBox(
                            height: 10,
                          ),
                          McButton(
                              colorBorder: AppColors.black,
                              colorBtn: AppColors.primaryColor,
                              onTap: () => controller
                                  .showQuranReviewSelectionDialog(context),
                              blod: true,
                              txt: 'اختيار المراجعة'),
                          const SizedBox(
                            height: 10,
                          ),
                          const Spacer(),
                          McButton(
                              colorBorder: AppColors.black,
                              colorBtn: AppColors.primaryColor,
                              onTap: () async {
                                controller.submitReport();
                              },
                              blod: true,
                              txt: 'حفظ التقرير'),
                          const SizedBox(
                            height: 10,
                          ),

                          //
                        ],
                      ),
                    ),
                  ),
                )));
  }

 
}
