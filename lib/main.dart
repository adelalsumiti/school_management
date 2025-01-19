// import 'dart:async';
// import 'dart:io';
// import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:school_management/bindings/initialbinding.dart';
// import 'package:school_management/addStudentPage.dart';
// import 'package:school_management/addTeacher.dart';
// import 'package:school_management/core/class/curd.dart';
// import 'package:school_management/core/services/report_Service.dart';
import 'package:school_management/core/services/services.dart';
import 'package:school_management/routes.dart';
// import 'package:school_management/view/screen/teacher/test_Package.dart';
// import 'package:sound_recording/sound_recording.dart';

void main() async {
  // Isolate.spawn(processRecordingData, receivePort.sendPort);
  WidgetsFlutterBinding.ensureInitialized();
  // HttpOverrides.global = MyHttpOverrides();

  await Firebase.initializeApp();
  print("---------Main------");
  WidgetsFlutterBinding.ensureInitialized();
  print("---------ensureInitialized------");

  await initialServices();
  print("---------initialServices------");
  // Get.put(Crud());
  // Get.put(ReportService());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBinding(),
      theme: ThemeData(fontFamily: "Cairo"),
      locale: const Locale("ar"),
      debugShowCheckedModeBanner: false,
      getPages: routes,
      builder: FlutterSmartDialog.init(),
    );
  }
}
