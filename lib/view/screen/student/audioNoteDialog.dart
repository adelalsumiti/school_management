// import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'dart:developer';
import 'package:path/path.dart';

// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:school_management/view/screen/student/sqlDb.dart';
// import 'package:sqflite/sqflite.dart';

class AudioNoteDialog extends StatefulWidget {
  final Function(File) onSubmit;

  const AudioNoteDialog({super.key, required this.onSubmit});

  @override
  _AudioNoteDialogState createState() => _AudioNoteDialogState();
}

class _AudioNoteDialogState extends State<AudioNoteDialog> {
  bool isRecording = false;
  File? recordedFile;

  void startRecording() async {
    // قم بإعداد التسجيل هنا (تأكد من إضافة مكتبة للتسجيل مثل `flutter_sound`)
    setState(() {
      isRecording = true;
    });
  }

  // Future<String> getDatabasePath() async {
  //   // طلب إذن الوصول إلى وحدة التخزين
  //   var status = await Permission.storage.request();
  //   if (!status.isGranted) {
  //     throw Exception("Permission denied");
  //   }
  //   // إذا كان النظام Android 11 أو أعلى، احصل على مسار "Downloads"
  //   if (Platform.isAndroid && (await getAndroidVersion()) >= 30) {
  //     Directory downloadsDir = Directory('/storage/emulated/0/Download');

  //     // تأكد من وجود مجلد FatortyDB داخل مجلد Downloads
  //     String dbFolderPath = join(downloadsDir.path, 'School_Management');
  //     if (!await Directory(dbFolderPath).exists()) {
  //       await Directory(dbFolderPath).create(recursive: true);
  //     }
  //     // المسار النهائي للملف
  //     String dbPath = join(dbFolderPath, 'audioFile.acc');
  //     log(dbPath, error: dbPath);
  //     return dbPath;
  //   }

  //   // إذا كان الإصدار أقل من Android 11
  //   Directory? externalDir = await getExternalStorageDirectory();
  //   if (externalDir == null) {
  //     throw Exception("Unable to access external storage");
  //   }

  //   String dbFolderPath = join(externalDir.path, 'School_Management');
  //   if (!await Directory(dbFolderPath).exists()) {
  //     await Directory(dbFolderPath).create(recursive: true);
  //   }

  //   String dbPath = join(dbFolderPath, 'audioFile.acc');

  //   return dbPath;
  // }

// دالة الحصول على إصدار Android
  // Future<int> getAndroidVersion() async {
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //   return androidInfo.version.sdkInt; // هذا يعيد رقم SDK الخاص بإصدار Android
  // }
  // Future<String> getAudioFilePath() async {
  //   Directory downloadsDir = Directory('/storage/emulated/0/Download');

  //   final directory = await getApplicationDocumentsDirectory();
  //   return '${directory.path}/audio_note.aac';
  // }
  // SqlDb sqlDb = SqlDb();

//
  void stopRecording() async {
    //
    Directory downloadsDir = Directory('/storage/emulated/0/Download');

    // تأكد من وجود مجلد FatortyDB داخل مجلد Downloads
    String dbFolderPath = join(downloadsDir.path, 'School_Management');
    if (!await Directory(dbFolderPath).exists()) {
      await Directory(dbFolderPath).create(recursive: true);
    }
    // المسار النهائي للملف
    // String dbPath = join(dbFolderPath, 'audioFile.aac');
    String path = join(dbFolderPath, 'audioFile.aac');
    log(path, error: path);
    // return path;
    //

    // قم بإيقاف التسجيل هنا وحفظ الملف في `recordedFile`
    // مثال:
    // final directory = await getApplicationDocumentsDirectory();
    // final path = '${directory.path}/audio_note.aac';
    // String path = await getAudioFilePath();
    // String path = await getDatabasePath();
// استخدم هذا المسار لحفظ الملف

    setState(() {
      isRecording = false;
      recordedFile = File(path); // تحديث المسار بالملف المسجل
    });
  }

  void submitAudioNote() {
    if (recordedFile != null) {
      widget.onSubmit(recordedFile!);
      Get.back();
      // Navigator.of(context).pop();
    } else {
      Get.snackbar("المعذرة", "'يرجى تسجيل ملاحظة صوتية أولاً'");
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('يرجى تسجيل ملاحظة صوتية أولاً')),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('تسجيل ملاحظة صوتية'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isRecording ? Icons.mic : Icons.mic_off,
            color: isRecording ? Colors.red : Colors.grey,
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(isRecording
              ? 'جاري التسجيل...'
              : recordedFile != null
                  ? 'تم تسجيل الملاحظة الصوتية'
                  : 'اضغط للتسجيل'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: isRecording ? stopRecording : startRecording,
          child: Text(isRecording ? 'إيقاف التسجيل' : 'بدء التسجيل'),
        ),
        TextButton(
          onPressed: submitAudioNote,
          child: const Text('إرسال'),
        ),
      ],
    );
  }
}
