import 'dart:developer';
import 'package:get/get.dart';
import 'package:school_management/core/class/statusrequest.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/funcations/handlinfdatacontroller.dart';
import 'package:school_management/data/dataSource/remote/roleAdmin/teachers_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TeachersController extends GetxController {
  fetchTeachers();
  deleteTeacher(int teacherId);
  fetchTeachersAndClasses();
  addTeacherToClass();
  initialData();
}

class TeachersControllerImp extends TeachersController {
  TeacherData teacherData = TeacherData(Get.find());
  late SharedPreferences prefs;
  late StatusRequest statusRequest;
  List teachers = [];
  List<dynamic> originalTeachers = [];
  List<dynamic> filteredTeachers = [];
  List<dynamic> addTeachers = [];
  List<dynamic> classes = [];
  String? selectedTeacher;
  String? selectedClass;

  @override
  fetchTeachers() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await teacherData.getDataTeacheres();
    statusRequest = await handlingData(response);
    update();
    if (StatusRequest.success == statusRequest) {
      if (response['success']) {
        teachers = response['teachers'];
        originalTeachers = teachers;
        filteredTeachers = originalTeachers;
        update();
        log("$teachers", name: 'teachers');
      } else {
        statusRequest = StatusRequest.none;
        throw Exception("Data is False");
      }
    }
  }

  @override
  deleteTeacher(int teacherId) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await teacherData.deleteTeacher(teacherId);
    statusRequest = await handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['success']) {
        Get.snackbar(
          "نجاح",
          "تم حذف المعلم بنجاح",
          backgroundColor: AppColors.primaryColor,
          colorText: AppColors.backgroundIDsColor,
          barBlur: 4,
          animationDuration: const Duration(seconds: 5),
        );
        await fetchTeachers();
        update();
      } else {
        statusRequest = StatusRequest.serverfailure;
        update();
        Get.snackbar("خطأ", response['message']);
      }
    }
  }

  void filterTeachers(String query) {
    if (query.isEmpty) {
      filteredTeachers = originalTeachers;
    } else {
      filteredTeachers = originalTeachers.where((teacher) {
        final name = teacher['teacher_name']?.toLowerCase() ?? '';
        final className = teacher['class_name']?.toLowerCase() ?? '';
        return name.contains(query.toLowerCase()) ||
            className.contains(query.toLowerCase());
      }).toList();
    }
    update();
  }

  @override
  fetchTeachersAndClasses() async {
    statusRequest = StatusRequest.loading;
    update();

    final teacherResponse = await teacherData.getDataNamesTeacheres();
    final classResponse = await teacherData.getDataNamesClasses();

    if (teacherResponse['success'] && classResponse['success']) {
      teachers = teacherResponse['teachers'];
      classes = classResponse['classes'];
      statusRequest = StatusRequest.success;
    } else {
      statusRequest = StatusRequest.serverfailure;
    }
    update();
  }

  @override
  addTeacherToClass() async {
    await fetchTeachers();
    if (selectedTeacher == null || selectedClass == null) {
      Get.snackbar(
        "خطأ",
        "الرجاء اختيار المعلم والصف",
        backgroundColor: AppColors.primaryColor,
        colorText: AppColors.backgroundIDsColor,
      );
      return;
    }

    statusRequest = StatusRequest.loading;
    update();
    var response =
        await teacherData.addTeacherToClass(selectedTeacher, selectedClass);
    statusRequest = await handlingData(response);
    update();

    if (StatusRequest.success == statusRequest) {
      if (response['success']) {
        Get.snackbar(
          "نجاح",
          'تم إضافة المعلم بنجاح',
          backgroundColor: AppColors.primaryColor,
          colorText: AppColors.backgroundIDsColor,
          animationDuration: const Duration(seconds: 5),
        );
        Get.back();
      } else {
        Get.snackbar(
          "خطأ",
          response['message'],
          backgroundColor: AppColors.primaryColor,
          colorText: AppColors.backgroundIDsColor,
        );
      }
    } else {
      Get.snackbar(
        "خطأ",
        "فشل في الاتصال بالخادم",
        backgroundColor: AppColors.primaryColor,
        colorText: AppColors.backgroundIDsColor,
      );
    }
    update();
  }

  @override
  void onInit() {
    statusRequest = StatusRequest.none;
    initialData();
    selectedTeacher = null;
    selectedClass = null;
    super.onInit();
  }

  @override
  initialData() {
    fetchTeachers();
    fetchTeachersAndClasses();
  }
}
