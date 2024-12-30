import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
// import 'package:school_management/addStudentPage.dart';
// import 'package:school_management/addTeacher.dart';
import 'package:school_management/core/class/crud.dart';
import 'package:school_management/core/services/services.dart';
import 'package:school_management/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print("---------Main------");
  WidgetsFlutterBinding.ensureInitialized();
  print("---------ensureInitialized------");

  await initialServices();
  print("---------initialServices------");
  Get.put(Crud());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: "Cairo"),
      locale: const Locale("ar"),
      debugShowCheckedModeBanner: false,
      getPages: routes,
    );
  }
}
