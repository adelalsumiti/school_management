// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:school_management/linkapi.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:school_management/view/controller/controller_addReport.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:quran/quran.dart' as quran;

class AddReportPage extends StatefulWidget {
  // final int studentId;
  // final int teacherId;

  const AddReportPage({
    super.key,
    // required this.studentId, required this.teacherId
  });

  @override
  _AddReportPageState createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage> {
  @override
  Widget build(BuildContext context) {
    Get.put(AddReportControllerImp());
    // Get.arguments({studentId: "studentId", teacherId: "id"});
    return Scaffold(
        appBar: AppBar(title: const Text('إضافة تقرير')),
        body: GetBuilder<AddReportControllerImp>(
          builder: (controller) => controller.isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        items: controller.items
                            // items: ['ممتاز', 'جيد', 'متوسط', 'ضعيف']
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        // onChanged: (value) =>
                        onChanged: (value) async {
                          controller.selectedAssessment = value;
                        },
                        decoration: const InputDecoration(labelText: 'التقييم'),
                      ),
                      TextField(
                        controller: controller.noteController,
                        decoration: const InputDecoration(labelText: 'ملاحظة'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await controller.pickFile();
                        },
                        child: const Text('تحميل ملف'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await controller.recordAudio();
                        },
                        child: const Text('تسجيل ملاحظة صوتية'),
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            controller.showQuranSelectionDialog(context),
                        child: const Text('اختيار الحفظ'),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () async {
                          await controller.submitReport();
                        },
                        child: const Text('حفظ التقرير'),
                      ),
                    ],
                  ),
                ),
        ));
  }
}
