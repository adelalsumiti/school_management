import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:school_management/linkapi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class TeachersController extends GetxController {
  fetchTeacherStudents();
  initialData();
}

class TeachersControllerImp extends TeachersController {
  // late Future<List<Map<String, dynamic>>> teacherStudents;
  List<dynamic> teacherStudents = [];
  List<dynamic> responsev = [];
  bool isLoading = true;
  SharedPreferences? prefs;

  int? userId;
  int? studentId;
  int? classId;

  @override
  fetchTeacherStudents() async {
    isLoading = true;
    update();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt("id");
    final url =
        '${AppLink.fetchTeacherStudents}?teacher_id=$userId'; // ضع الرابط الصحيح هنا
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      isLoading = false;
      update();

      final data = json.decode(response.body);
      if (data['success']) {
        teacherStudents = data['data'];
        log("studentId", error: studentId);
        print('Data received teacherStudents: $teacherStudents');
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception('Failed to load teacher students');
    }
  }

  //
  @override
  void onInit() {
    super.onInit();
    initialData();
    isLoading;
  }

  @override
  initialData() async {
    fetchTeacherStudents();
  }
  //
}
