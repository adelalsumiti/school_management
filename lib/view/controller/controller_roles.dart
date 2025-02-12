import 'dart:developer';
import 'package:get/get.dart';
import 'package:school_management/core/class/statusrequest.dart';
import 'package:school_management/core/constant/routes.dart';
import 'package:school_management/core/services/services.dart';
import 'package:school_management/view/screen/admin/fathers/home_RoleFather.dart';
import 'package:school_management/view/screen/admin/home_RoleAdmin.dart';
import 'package:school_management/view/screen/admin/students/home_RoleStudent.dart';
import 'package:school_management/view/screen/teacher/home_RoleTeacher.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ControllerRolesHome extends GetxController {
  widgetAdmin();
  widgetTeacher();
  widgetStudent();
  widgetFather();
  initialData();
}

class ControllerRolesHomeImp extends ControllerRolesHome {
  String? userRole;
  MyServices myServices = Get.find();
  late SharedPreferences prefs;
  StatusRequest statusRequest = StatusRequest.none;
  String? userEmail;
  String? userName;
  int? userId;
  String? role;

  Future<void> getEmail() async {
    statusRequest = StatusRequest.loading;
    update();
    prefs = await SharedPreferences.getInstance();

    log("$prefs", name: 'predfs', error: prefs);
    userId = prefs.getInt("id");
    update();
    userEmail = prefs.getString('email') ?? 'غير معروف'; // البريد الإلكتروني
    update();
    userName = prefs.getString('name') ?? 'ضيف';
    update();

    role = prefs.getString('role') ?? 'ضيف';

    log("$userId", name: 'userId', error: userId);
    log("$role", name: 'role', error: role);
    log("$userName", name: 'userName', error: userName);
    update();
    statusRequest = StatusRequest.none;
    update();
  }

  Future<void> logoutUser() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('name');
    await prefs.remove('role');
    await prefs.remove('id');
    update();
    log("$prefs", name: 'predfs', error: prefs);
    Get.offAllNamed(AppRoute.loginPage); // العودة إلى صفحة تسجيل الدخول
  }

  @override
  void onInit() async {
    super.onInit();
    statusRequest = StatusRequest.none;
    update();
    await initialData();
    prefs = await SharedPreferences.getInstance();
  }

  @override
  initialData() async {
    statusRequest = StatusRequest.none;
    update();
    await getEmail();
  }

  //
  Future buildRoleSpecificUI() async {
    // Future<Widget> buildRoleSpecificUI() async {
    // Widget buildRoleSpecificUI() {
    switch (userRole) {
      case 'admin':
        return await widgetAdmin();
      case 'teacher':
        return await widgetTeacher();
      case 'father':
        return await widgetFather();
      // case 'parent':
      case 'student':
        return await widgetStudent();
      default:
        // return const LoginPage();
        // return const Center(child: Text('دور المستخدم غير معروف.'));
        return this;
    }
  }

  @override
  widgetAdmin() {
    return const HomeRoleAdmin();
  }

  @override
  widgetFather() {
    return const HomeRoleFather();
  }

  @override
  widgetStudent() {
    return const HomeRoleStudent();
  }

  @override
  widgetTeacher() {
    return const HomeRoleTeacher();
  }
}
