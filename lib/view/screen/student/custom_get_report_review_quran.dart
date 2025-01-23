import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management/view/controller/controller_addReport.dart';

class StudentReportReviewQuranPage extends StatelessWidget {
  final List<Map<String, dynamic>> reportsReview;
  const StudentReportReviewQuranPage({super.key, required this.reportsReview});
  @override
  Widget build(BuildContext context) {
    Get.put(AddReportControllerImp());
    return GetBuilder<AddReportControllerImp>(
      builder: (controller) => Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: reportsReview.length,
              itemBuilder: (context, index) {
                final report = reportsReview[index];
                final String surahReviewName = report['surahReview'];
                final int startVerseReview = report['startVerseReview'];
                final int endVerseReview = report['endVerseReview'];

                final verses = controller.getVerses(
                    surahReviewName, startVerseReview, endVerseReview);

                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'سورة : $surahReviewName',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'الآيات: $startVerseReview - $endVerseReview',
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
