// import 'dart:convert';
// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/constant/routes.dart';
// import 'package:school_management/linkapi.dart';
import 'package:school_management/view/controller/controller_addReport.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

class DetailReport extends StatelessWidget {
  const DetailReport({super.key});

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
          builder: (controller) => controller.isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
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
                              final item =
                                  controller.reportStudentForRoleTeacher[index];

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
                                  selected: true,
                                  selectedColor: AppColors.black,

                                  title: Text(
                                    'التقييم: ${item['assessment']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'الملاحظة: ${item['note']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // leading: Text('التاريخ: ${item['date']}'),
                                  leading: Text(
                                    ' ${item['date']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    const SizedBox(height: 40)
                  ],
                ),
        ));
  }
}
