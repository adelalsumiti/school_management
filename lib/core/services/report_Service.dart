import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_management/data/model/report_Model.dart';
import 'package:school_management/linkapi.dart';

class ReportService extends GetxService {
  // ReportModel reportModel = ReportModel();
  // Future<Map<String, dynamic>> sendReport(ReportModel reportModel) async {
  // Future<ReportService> init() async {
  //   // sendReport;
  //   return this;
  // }

  Future<Map<String, dynamic>> sendReport(ReportModel reportModel) async {
    final url = Uri.parse(AppLink.addReport);

    var request = http.MultipartRequest('POST', url);

    // إضافة الحقول من الكائن
    request.fields['student_id'] = reportModel.studentId.toString();
    request.fields['teacher_id'] = reportModel.teacherId.toString();
    request.fields['class_id'] = reportModel.classId.toString();
    request.fields['assessment'] = reportModel.assessment ?? '';
    request.fields['note'] = reportModel.note ?? '';
    request.fields['surah'] = reportModel.surah ?? '';
    request.fields['startVerse'] = reportModel.startVerse.toString();
    request.fields['endVerse'] = reportModel.endVerse.toString();

    // إضافة الملفات إذا كانت موجودة
    if (reportModel.filePath != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        // reportModel.filePath!.path,
        reportModel.filePath!.path,
      ));
    }

    if (reportModel.audioNotePath != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'audio_note',
        reportModel.audioNotePath!.path,
        // reportModel.audioNotePath!.path,
      ));
    }

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        return json.decode(responseBody);
      } else {
        return {
          'success': false,
          'message':
              'فشل في الاتصال بالخادم. رمز الخطأ: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'حدث خطأ أثناء الإرسال: $e',
      };
    }
  }
}
