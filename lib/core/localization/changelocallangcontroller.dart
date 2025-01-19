// import 'dart:io';

// import 'package:adminkingfashion/core/constant/apptheme.dart';
// import 'package:adminkingfashion/core/funcations/fcmconfige.dart';
// import 'package:adminkingfashion/core/services/services.dart';
// import 'package:flutter/material.dart';

// // ignore: depend_on_referenced_packages
// import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';

// class LocaleController extends GetxController {
//   Locale? language;

//   MyServices myServices = Get.find();

//   ThemeData apptheme = themeEnglish;

//   String langcode = "en";

//   changeLang(String langcode) {
//     Locale locale = Locale(langcode);

//     myServices.sharedPreferences.setString("lang", langcode);
//     apptheme = themeEnglish;
//     Get.changeTheme(apptheme);
//     Get.updateLocale(locale);
//   }

//   createFolderinPath() async {
//     final Directory? directory = await getExternalStorageDirectory();

//     String path = "${directory!.path}/invoices";

//     await Directory(path).create(recursive: false);
//   }
//   // _checkInternetStatus()async{
//   //     subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//   //   // Got a new connectivity status!
//   // });
//   // }

//   @override
//   void onInit() async {
//     requestPermissionNotification();
//     fcmconfig();

//     createFolderinPath();
//     String? sharedprefLang = myServices.sharedPreferences.getString("lang");

//     if (sharedprefLang == "ar") {
//       language = const Locale("en");
//       apptheme = themeEnglish;
//     } else if (sharedprefLang == "en") {
//       language = const Locale("en");
//       apptheme = themeEnglish;
//     } else {
//       language = const Locale("en");
//       apptheme = themeEnglish;
//     }

//     super.onInit();
//   }
// }

//

//
//

//
import 'package:school_management/core/constant/apptheme.dart';
import 'package:school_management/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleController extends GetxController {
  Locale? language;

  MyServices myServices = Get.find();

  ThemeData appTheme = themeArabic;

  // String langcode = "ar";

  changeLang(String langcode) {
    Locale locale = Locale(langcode);

    myServices.sharedPreferences.setString("lang", langcode);
    appTheme = langcode == "ar" ? themeArabic : themeEnglish;
    Get.changeTheme(appTheme);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    String? sharedprefLang = myServices.sharedPreferences.getString("lang");
    if (sharedprefLang == "ar") {
      language = const Locale("ar");
      appTheme = themeArabic;
    } else if (sharedprefLang == "en") {
      language = const Locale("en");
      appTheme = themeEnglish;
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
      appTheme = themeEnglish;
    }
    super.onInit();
  }
}
