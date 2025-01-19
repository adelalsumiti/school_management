import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/view/screen/admin/fathers/home_RoleFather.dart';
import 'package:school_management/view/screen/admin/home_RoleAdmin.dart';
import 'package:school_management/view/screen/admin/students/home_RoleStudent.dart';
import 'package:school_management/view/screen/teacher/home_RoleTeacher.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

abstract class ControllerRolesHome extends GetxController {
  widgetAdmin();
  widgetTeacher();
  widgetStudent();
  widgetFather();
  void initState();
}

class ControllerRolesHomeImp extends ControllerRolesHome {
  String? userRole;
  Future<void> fetchUserRole(String userId) async {
    // String? role = await getUserRole(userId);
    //  void setState({
    // userRole = role;
    // });
  }

  @override
  void initState() {
    // يجب استدعاء `fetchUserRole` هنا أو عند الحاجة
    const userId = "1"; // معرف المستخدم
    fetchUserRole(userId);
    //  super.initState();
  }

  //
  //
  Widget buildRoleSpecificUI() {
    switch (userRole) {
      case 'admin':
        return widgetAdmin();
      case 'teacher':
        return widgetTeacher();
      case 'father':
        return widgetFather();
      // case 'parent':
      case 'student':
        return widgetStudent();
      default:
        // return const LoginPage();
        return const Center(child: Text('دور المستخدم غير معروف.'));
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
