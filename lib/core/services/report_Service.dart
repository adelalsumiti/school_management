import 'dart:async';
import 'dart:convert';
import 'dart:developer';
// import 'dart:io';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'package:school_management/data/model/report_Model.dart';
import 'package:school_management/linkapi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportService extends GetxService {
  late SharedPreferences prefs;
  Future<ReportService> init() async {
    prefs = await SharedPreferences.getInstance();

    await Firebase.initializeApp(
        // options: DefaultFirebaseOptions.currentPlatform,
        );
    RemoteMessage? remoteMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (remoteMessage != null) {
      log('${remoteMessage.data}', name: 'getInitialMessage');
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification?.android;
      if (android != null) {
        log('''

      notification.hashCode
      ${notification.hashCode},
      notification.title
      ${notification.title},
      notification.body
      ${notification.body},
            ''', name: 'notification');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // Navigator.pushNamed(context, '/message',
      //     arguments: MessageArguments(message, true));
    });
    return this;
  }

  initialServices() async {
    await Get.putAsync(() => ReportService().init());
  }

  Future<Map<String, dynamic>> sendReport(ReportModel reportModel) async {
    final url = Uri.parse(AppLink.addReport);

    var request = await retry(() => http.MultipartRequest('POST', url),
        // .timeout(
        // const Duration(seconds: 15),
        retryIf: (e) =>
            e is SocketException ||
            e is TimeoutException ||
            e is http.ClientException,
        onRetry: (e) {
          log("$e", name: 'onRetry');
        });
    // var request = http.MultipartRequest('POST', url);

    // إضافة الحقول من الكائن
    request.fields['student_id'] = reportModel.studentId.toString();
    request.fields['teacher_id'] = reportModel.teacherId.toString();
    request.fields['class_id'] = reportModel.classId.toString();
    request.fields['assessment'] = reportModel.assessment ?? '';
    request.fields['note'] = reportModel.note ?? '';
    request.fields['surah'] = reportModel.surah ?? '';
    request.fields['startVerse'] = reportModel.startVerse.toString();
    request.fields['endVerse'] = reportModel.endVerse.toString();
    request.fields['surahReview'] = reportModel.surahReview ?? '';
    request.fields['startVerseReview'] =
        reportModel.startVerseReview.toString();
    request.fields['endVerseReview'] = reportModel.endVerseReview.toString();

    if (reportModel.audioNotePath != null) {
      //

      // request.fields['audio_note_path'] = reportModel.audioNotePath.toString();
      // request.files.add(
      //   await http.MultipartFile.fromPath(
      //       'audio_note_path', reportModel.audioNotePath!.path),
      // );

      //
      request.files.add(await http.MultipartFile.fromPath(
        // 'audio_note',
        'audio_note_path',
        reportModel.audioNotePath!,
      ));
    }

    // إضافة الملفات إذا كانت موجودة
    if (reportModel.filePath != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'file_path',
        // reportModel.filePath!.path,
        reportModel.filePath!,
      ));
    }

    // if (reportModel.audioNotePath != null) {
    //   // request.files.add(await http.MultipartFile.fromPath(
    //   //   // 'audio_note',
    //   //   'audio_note_path',
    //   //   reportModel.audioNotePath!.path,
    //   //   // reportModel.audioNotePath!.path,
    //   // ));
    // }

    try {
      var response = await request.send();

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
