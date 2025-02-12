import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quran;
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/view/controller/controller_addReport.dart';

class StudentReportSavedQuranPage extends StatelessWidget {
  final List<Map<String, dynamic>> reportsSaved;
  const StudentReportSavedQuranPage({super.key, required this.reportsSaved});
  @override
  Widget build(BuildContext context) {
    Get.put(AddReportControllerImp());
    return GetBuilder<AddReportControllerImp>(
      builder: (controller) => Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: reportsSaved.length,
              itemBuilder: (context, index) {
                final report = reportsSaved[index];
                final int surahName = int.parse(report['surah']);
                final int startVerse = report['startVerse'];
                final int endVerse = report['endVerse'];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'سورة : ${quran.getSurahNameArabic(surahName)}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: DropdownButton<Map<String, dynamic>>(
                                  alignment: Alignment.center,
                                  isExpanded: false,
                                  // isDense: true,
                                  value: controller.selectedNameMoqra,
                                  hint: Text(
                                    controller.selectedNameMoqra == null
                                        ? 'ناصر القطامي'
                                        : 'القراء',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  items: controller.nameMoqra
                                      .map((Map<String, dynamic> item) {
                                    return DropdownMenuItem<
                                        Map<String, dynamic>>(
                                      value: item,
                                      child: Text(item['name']),
                                    );
                                  }).toList(),
                                  onChanged:
                                      (Map<String, dynamic>? newValue) async {
                                    controller.selectedNameMoqra = newValue;
                                    controller.moqra = newValue?['value'];
                                    log(
                                      "controller.moqra ${controller.moqra}",
                                    );
                                    log(
                                      "selectedNameMoqra $newValue",
                                    );
                                    controller.update();
                                  },
                                ),
                              ),
                            ]),
                        const SizedBox(height: 8.0),
                        Text(
                          'الآيات: $startVerse - $endVerse',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8.0),
                        controller.isLoading == true
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.black,
                                  strokeWidth: 5,
                                  strokeAlign: 1,
                                ),
                              )
                            : Wrap(spacing: 10, runSpacing: 10, children: [
                                const Center(
                                  child: Text(
                                      "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ "),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                      endVerse - startVerse + 1, (i) {
                                    int verseNumber = startVerse + i;
                                    return GestureDetector(
                                      onTap: () => controller.playAyahAudio(
                                          // surahName.compareTo(surahName), verseNumber),
                                          surahName,
                                          verseNumber),
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: controller.playingAyah ==
                                                  "$surahName:$verseNumber"
                                              ? Colors.green[100]
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border:
                                              Border.all(color: Colors.grey),
                                        ),
                                        child: Wrap(
                                            runAlignment: WrapAlignment.start,
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            direction: Axis.horizontal,
                                            alignment:
                                                WrapAlignment.spaceBetween,
                                            textDirection: TextDirection.ltr,
                                            children: [
                                              if (controller.isPlayinggAyah &&
                                                  controller.playingAyah !=
                                                      null)
                                                FilledButton.tonalIcon(
                                                  style: const ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStatePropertyAll(
                                                              AppColors
                                                                  .appBarColor)),
                                                  onPressed: () async {
                                                    await controller
                                                        .audioPlayerAyah
                                                        .closePlayer();
                                                    controller.isPlayinggAyah =
                                                        false;
                                                    controller.playingAyah =
                                                        null;
                                                    controller.update();
                                                  },
                                                  label: const Icon(
                                                    Icons
                                                        .pause_circle_outline_rounded,
                                                    size: 30,
                                                  ),
                                                ),
                                              Text(
                                                // verses,
                                                '${quran.getVerse(surahName.toInt(), verseNumber)} ﴿$verseNumber﴾',
                                                // '${quran.getVerse(surahName.toInt(), verseNumber)}  [$verseNumber]',
                                                // style: const TextStyle(fontSize: 14),
                                                style: TextStyle(
                                                    fontFamily:
                                                        " ${GoogleFonts.amiriQuran} ",
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 0,
                                                    height: 1.4,
                                                    fontSize: 20),
                                              ),
                                              // Text(" ﴿$verseNumber﴾")
                                            ]),
                                      ),
                                    );
                                  }),
                                ),
                              ]),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
