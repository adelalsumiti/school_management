import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/constant/routes.dart';
import 'package:school_management/view/controller/controller_addReport.dart';
import 'package:school_management/view/screen/student/custom_get_report_quran.dart';
import 'package:school_management/view/widgets/custom_IconButton_Delete.dart';
import 'package:school_management/view/widgets/custom_TextButton_Delete.dart';

class DetailReport extends StatelessWidget {
  DetailReport({super.key});
  final control = AddReportControllerImp();
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
          builder: (controller) => controller.isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
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
                              final item =
                                  controller.reportStudentForRoleTeacher[index];

                              return Container(
                                clipBehavior: Clip.none,
                                // height: Get.height,
                                // height:
                                //     Get.height / Get.width + Get.height / 2,
                                // height: 150,
                                // width: Get.height,
                                // height: Get.width,
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 30, right: 2, left: 2),

                                // padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(
                                    top: 8, bottom: 10, right: 2, left: 2),
                                decoration: BoxDecoration(
                                    color: AppColors.backgroundIDsColor,
                                    boxShadow: const [
                                      BoxShadow(blurRadius: 3, spreadRadius: 2)
                                    ],
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ListTile(
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
                                      // dense: true,
                                      // leading: Text('التاريخ: ${item['date']}'),
                                      // visualDensity: const VisualDensity(
                                      //     vertical: 4, horizontal: 4),
                                      // horizontalTitleGap: 5,
                                      leading: Text(
                                        ' ${item['date']}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        children: [
                                          Column(
                                            // verticalDirection:
                                            //     VerticalDirection.down,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            //
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                // padding: const EdgeInsets.only(
                                                //   bottom: 5,
                                                //   top: 5,
                                                // ),
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
                                                height: 35,
                                                width: 110,
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
                                                            StudentReportQuranPage(
                                                          reports: [
                                                            {
                                                              "surah":
                                                                  item['surah'],
                                                              "startVerse": item[
                                                                  'startVerse'],
                                                              "endVerse": item[
                                                                  'endVerse'],
                                                            }
                                                          ],
                                                        )));
                                                  },
                                                ),
                                              ),
                                              // const SizedBox(
                                              //   height: 5,
                                              // ),
                                              CustomTextButtonDelete(
                                                  nameButton: 'حذف',
                                                  titileMessage: "تأكيد الحذف",
                                                  bodyMessage:
                                                      'هل أنت متأكد من حذف هذا التقرير ؟',
                                                  onPressedCancel: () =>
                                                      Get.back(),
                                                  onPressedYes: () {
                                                    controller.deleteReport(
                                                        item['id']);
                                                  }),

                                     
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    // const SizedBox(width: 3)
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                    // const SizedBox(height: 40)
                  ],
                ),
        ));
  }
}
