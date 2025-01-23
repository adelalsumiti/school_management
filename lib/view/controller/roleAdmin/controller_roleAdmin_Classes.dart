import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/core/class/statusrequest.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/funcations/handlinfdatacontroller.dart';
import 'package:school_management/data/dataSource/remote/roleAdmin/classes_data.dart';

abstract class ClassesController extends GetxController {
  fetchClasses();
  deleteClass(String classIdd);
  addClass();
  updateClass();
  initialData();
}

class ClassesControllerImp extends ClassesController {
  ClassData classData = ClassData(Get.find());
  late StatusRequest statusRequest;
  TextEditingController classNameController = TextEditingController();
  List<dynamic> originalClasses = []; // قائمة المعلمين الأصلية
  List<dynamic> filteredClasses = []; // قائمة المعلمين المفلترة
  TextEditingController nameController = TextEditingController();
  late String? classId;

  //

  @override
  fetchClasses() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await classData.getDataClasses();
    statusRequest = await handlingData(response);
    update();
    if (StatusRequest.success == statusRequest) {
      if (response['success'] == true) {
        originalClasses = response['classes'];
        update();
        filteredClasses = originalClasses; // نسخ البيانات إلى قائمة البحث
        update();
      } else {
        statusRequest = StatusRequest.failure;
        throw Exception('فشل في جلب البيانات');
      }
    } else {
      statusRequest = StatusRequest.serverfailure;
      throw Exception('فشل في الاتصال بالخادم');
    }
  }

  //
  @override
  addClass() async {
    if (classNameController.text.isEmpty) {
      Get.snackbar("خطأ", 'يرجى إدخال اسم الصف');
      return this;
    }
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await classData.addClass(classNameController.text.trim());
      statusRequest = await handlingData(response);
      update();
      if (StatusRequest.success == statusRequest) {
        if (response['success'] == true) {
          Get.snackbar("نجاح", 'تمت إضافة الصف بنجاح!');
          classNameController.clear();
          await fetchClasses();
          update();
        } else {
          statusRequest = StatusRequest.none;
          Get.snackbar("تنبيه", 'الاسم موجود من قبل');

          throw Exception(response['message'] ?? 'فشل في إضافة الصف');
        }
      } else {
        statusRequest = StatusRequest.none;
        update();
        Get.snackbar("تنبيه", 'الاسم موجود من قبل',
            backgroundColor: AppColors.primaryColor,
            colorText: AppColors.backgroundIDsColor,
            animationDuration: const Duration(seconds: 5));
        update();
      }
    } catch (e) {
      statusRequest = StatusRequest.none;

      Get.snackbar("تنبيه", 'الاسم موجود من قبل',
          backgroundColor: AppColors.primaryColor,
          colorText: AppColors.backgroundIDsColor,
          animationDuration: const Duration(seconds: 5));
    }
  }

  @override
  deleteClass(String classIdd) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await classData.deleteClass(classIdd);
    statusRequest = await handlingData(response);
    update();
    if (StatusRequest.success == statusRequest) {
      if (response['success']) {
        Get.snackbar("نجاح", 'تم حذف الصف بنجاح!');
        await fetchClasses();
        update();
      } else {
        statusRequest = StatusRequest.none;
        update();
        throw Exception(response['message'] ?? 'فشل في حذف الصف');
      }
    } else {
      statusRequest = StatusRequest.none;
      update();
      Get.snackbar("تنبيه", 'الصف مرتبط ببيانات أخرى',
          backgroundColor: AppColors.primaryColor,
          colorText: AppColors.backgroundIDsColor,
          animationDuration: const Duration(seconds: 5));
    }
  }

  //

  /// تصفية قائمة المعلمين بناءً على النص المدخل
  void filterClasses(String query) async {
    if (query.isEmpty) {
      // إذا كان النص فارغًا، عرض القائمة الأصلية
      filteredClasses = originalClasses;
      // update();
    } else {
      // تصفية المعلمين بناءً على النص المدخل
      filteredClasses = originalClasses.where((classId) {
        final className = classId['className']?.toLowerCase() ?? '';
        return className.contains(query.toLowerCase());
      }).toList();
      update();
    }
    update();
  }

  //
  @override
  updateClass() async {
    log("nameController", error: nameController.text);
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await classData.editClass(nameController.text, classId);
      statusRequest = await handlingData(response);
      update();
      Get.back();
      Get.snackbar("نجاح", response['message'],
          backgroundColor: AppColors.primaryColor,
          colorText: AppColors.backgroundIDsColor,
          animationDuration: const Duration(seconds: 5));

      update();

      if (response['success']) {
        Get.snackbar("نجاح", response['message'],
            backgroundColor: AppColors.primaryColor,
            colorText: AppColors.backgroundIDsColor,
            animationDuration: const Duration(seconds: 5));
        // Get.back();
        update();
      } else {
        statusRequest = StatusRequest.none;
        update();

        throw Exception(response['message']);
      }
    } catch (e) {
      debugPrint('Error updating class: $e');
      statusRequest = StatusRequest.none;
      update();

      Get.snackbar("تنبيه", 'هذا الاسم موجود من قبل',
          backgroundColor: AppColors.primaryColor,
          colorText: AppColors.backgroundIDsColor,
          animationDuration: const Duration(seconds: 5));
    }
  }

  //

  @override
  void onInit() async {
    statusRequest = StatusRequest.none;
    initialData();
    super.onInit();
  }

  //
  @override
  initialData() {
    statusRequest = StatusRequest.none;
    update();
    fetchClasses();
  }
}
