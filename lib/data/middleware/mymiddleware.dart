import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:school_management/core/constant/routes.dart';
import 'package:school_management/core/services/services.dart';

class MyMiddleWare extends GetMiddleware {
  MyServices myServices = Get.find();

  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    if (myServices.sharedPreferences.getString("homePage") == "2") {
      return RouteSettings(name: AppRoute.homePage);
    }
    if (myServices.sharedPreferences.getString("loginPage") == "1") {
      //   // return  DrawerScreen();
      return RouteSettings(name: AppRoute.loginPage
          //       // name: AppRoute.home
          );
    } else {
      return RouteSettings(name: AppRoute.loginPage);
    }
  }
}
