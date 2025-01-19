import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management/view/controller/controller_addReport.dart';

class StudentReportSavedQuranPage extends StatelessWidget {
  final List<Map<String, dynamic>> reportsSaved;
  const StudentReportSavedQuranPage({super.key, required this.reportsSaved});
  @override
  Widget build(BuildContext context) {
    Get.put(AddReportControllerImp());
    return
        // Scaffold(
        //   appBar: AppBar(
        //     title: const Text('تقرير الحفظ'),
        //   ),
        //   body:
        GetBuilder<AddReportControllerImp>(
      builder: (controller) => Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: reportsSaved.length,
              itemBuilder: (context, index) {
                final report = reportsSaved[index];
                final String surahName = report['surah'];
                final int startVerse = report['startVerse'];
                final int endVerse = report['endVerse'];

                final verses =
                    controller.getVerses(surahName, startVerse, endVerse);

                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'سورة : $surahName',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'الآيات: $startVerse - $endVerse',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8.0),
                        const Center(
                          child:
                              Text("بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ "),
                        ),
                        Text(
                          verses,
                          style: TextStyle(
                              fontFamily: " ${GoogleFonts.amiriQuran} ",
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0,
                              height: 1.8,
                              fontSize: 20),
                        ),
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
