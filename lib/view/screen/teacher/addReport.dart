// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_utils/mc_utils.dart';
import 'package:school_management/core/class/handlingdataview.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/view/controller/controller_addReport.dart';

class AddReportPage extends StatelessWidget {
  AddReportPage({
    super.key,
  });
  final AddReportControllerImp control = Get.put(AddReportControllerImp());

  @override
  Widget build(BuildContext context) {
    Get.put(AddReportControllerImp());
    // Get.arguments({studentId: "studentId", teacherId: "id"});
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.primaryColor,
          label: const Text(
            "حفظ التقرير",
            style:
                TextStyle(fontWeight: FontWeight.bold, color: AppColors.black),
          ),
          isExtended: true,
          extendedPadding: const EdgeInsets.all(150),
          onPressed: () async {
            File? file = control.recordedFilePath != null
                ? File(control.recordedFilePath!)
                : null;
            control.submitReport(file);
            Get.back();

            // control.submitReport(File(control.recordedFilePath!));
          },
        ),
        appBar: AppBar(title: const Text('إضافة تقرير')),
        body: GetBuilder<AddReportControllerImp>(
            builder: (controller) => HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      // spacing: 5,
                      runSpacing: 5,
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
                          onChange: (p0) => controller.selectedAssessment = p0,
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
                            cursorRadius: const Radius.circular(20),
                            cursorColor: AppColors.primaryColor,
                            strutStyle: const StrutStyle(),
                            controller: controller.noteController,
                            decoration: const InputDecoration(
                                labelText: '   اضغط لكتابة ملاحظة'),
                          ),
                        ),
                        Center(
                          child: Wrap(
                            runSpacing: 5,
                            spacing: 5,
                            direction: Axis.horizontal,
                            runAlignment: WrapAlignment.center,
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
                                    controller.stopRecording();
                                    controller.isRecording = false;
                                  } else {
                                    controller.startRecording();
                                    controller.isRecording = true;
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.cloud_upload_sharp),
                                style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                  AppColors.actionColor,
                                )),
                                color: AppColors.backgroundIDsColor,
                                iconSize: 30,
                                onPressed: () async {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.audio,
                                  );
                                  if (result != null) {
                                    String? filePath = result.files.single.path;
                                    if (filePath != null) {
                                      // await controller.submitReport(File(filePath));
                                      controller.audioFileSelected =
                                          File(filePath);
                                      log("مسار الملف :", error: " $filePath");
                                      Get.snackbar("مسار الملف : ", filePath,
                                          backgroundColor:
                                              AppColors.backgroundIDsColor,
                                          colorText: AppColors.primaryColor);
                                    } else {
                                      Get.snackbar(
                                          "خطأ!", "لم يتم تحديد اي ملف",
                                          backgroundColor:
                                              AppColors.backgroundIDsColor,
                                          colorText: AppColors.primaryColor);
                                      log("لم يتم تحديد اي ملف");
                                    }
                                  }
                                },
                                // child: const Text('رفع ملف صوتي'),
                              ),
                            ],
                          ),
                        ),
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
                        // const Spacer(),
                        // Container(
                        //   width: Get.width,
                        //   decoration: BoxDecoration(
                        //       color: AppColors.primaryColor,
                        //       borderRadius: BorderRadius.circular(20)),
                        //   child: TextButton(
                        //       onPressed: () async {
                        //         File? file = controller.recordedFilePath != null
                        //             ? File(controller.recordedFilePath!)
                        //             : null;
                        //         controller.submitReport(file);
                        //       },
                        //       child: const Text(
                        //         "حفظ التقرير",
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.bold,
                        //             color: AppColors.black),
                        //       )),
                        // ),
                      ],
                    ),
                  ),
                  // ),
                )));
  }
}
