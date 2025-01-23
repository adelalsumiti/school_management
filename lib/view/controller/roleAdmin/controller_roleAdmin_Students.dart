import 'dart:developer';
import 'package:get/get.dart';
import 'package:school_management/core/class/statusrequest.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/constant/routes.dart';
import 'package:school_management/core/funcations/handlinfdatacontroller.dart';
import 'package:school_management/data/dataSource/remote/roleAdmin/students_data.dart';

abstract class StudentsController extends GetxController {
  fetchStudentsWithClasses();
  fetchStudentsAndClasses();
  deleteStudent(String studentIdd);
  addStudentToClass();
  initialData();
}

class StudentsControllerImp extends StudentsController {
  StudentsData studentsData = StudentsData(Get.find());
  late StatusRequest statusRequest;
  List<dynamic> studentsWithClasses = [];
  List<dynamic> originalStudents = []; // قائمة الطلاب الأصلية
  List<dynamic> filteredStudents = []; // قائمة الطلاب المفلترة
  List<dynamic> students = [];
  List<dynamic> classes = [];
  String? selectedStudent;
  String? selectedClass;
  //
  //
  @override
  fetchStudentsAndClasses() async {
    statusRequest = StatusRequest.loading;
    update();
    var studentResponse = await studentsData.getDataStudents();
    var classResponse = await studentsData.getDataSClasses();
    statusRequest = handlingData(studentResponse);
    statusRequest = handlingData(classResponse);
    studentResponse is Map<String, dynamic>;
    classResponse is Map<String, dynamic>;
    // statusRequest = handlingData(studentResponse && classResponse);
    update();

    if (StatusRequest.success == statusRequest) {
      if (studentResponse['success'] == true &&
          classResponse['success'] == true) {
        students = await studentResponse['students'];
        update();

        classes = await classResponse['classes'];
        update();
        statusRequest = StatusRequest.none;
        update();
      }
    }
  }

  //

  @override
  fetchStudentsWithClasses() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await studentsData.getDataStudentsWithClasses();
    statusRequest = await handlingData(response);
    update();
    if (StatusRequest.success == statusRequest) {
      if (response['success'] == true) {
        studentsWithClasses = response['data'];
        log("$studentsWithClasses", name: 'studentsWithClasses');

        originalStudents = studentsWithClasses;
        filteredStudents = originalStudents;
        update();
      } else {
        statusRequest = StatusRequest.failure;
        Get.snackbar("خطأ", response['message'],
            backgroundColor: AppColors.primaryColor,
            colorText: AppColors.backgroundIDsColor,
            duration: const Duration(seconds: 5));

        throw Exception('فشل في جلب البيانات');
      }
    } else {
      statusRequest = StatusRequest.serverfailure;
      throw Exception('فشل في الاتصال بالخادم');
    }
  }

  //
  @override
  addStudentToClass() async {
    if (selectedStudent == null || selectedClass == null) {
      Get.snackbar("تنبيه", 'يجب اختيار الطالب والصف.',
          backgroundColor: AppColors.primaryColor,
          colorText: AppColors.backgroundIDsColor,
          animationDuration: const Duration(seconds: 5));
      return;
    }
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await studentsData.addStudentToClass(selectedStudent, selectedClass);
    statusRequest = await handlingData(response);
    update();
    // final data = json.decode(response.body);
    Get.snackbar("تنبيه", response['message'],
        backgroundColor: AppColors.primaryColor,
        colorText: AppColors.backgroundIDsColor,
        animationDuration: const Duration(seconds: 5));
    Get.back();
    update();
    if (StatusRequest.success == statusRequest) {
      // Get.back();
      // update();
      if (response['success']) {
        Get.back();
        update();
        selectedStudent = null;
        selectedClass = null;
        // Get.back();
        Get.snackbar("نجاح", 'تمت إضافة الطالب بنجاح!');

        await fetchStudentsWithClasses();
        update();
      } else {
        statusRequest = StatusRequest.none;
        Get.snackbar("تنبيه", 'الاسم موجود من قبل',
            backgroundColor: AppColors.primaryColor,
            colorText: AppColors.backgroundIDsColor,
            animationDuration: const Duration(seconds: 5));
        update();

        throw Exception(response['message'] ?? 'فشل في إضافة الطالب');
      }
    }
  }

  @override
  deleteStudent(String studentIdd) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await studentsData.deleteStudent(studentIdd);
    statusRequest = await handlingData(response);
    update();
    if (StatusRequest.success == statusRequest) {
      if (response['success']) {
        Get.snackbar("نجاح", 'تم حذف الطالب بنجاح!');
        await fetchStudentsWithClasses();
        update();
      } else {
        statusRequest = StatusRequest.none;
        update();
        throw Exception(response['message'] ?? 'فشل في حذف الطالب');
      }
    } else {
      statusRequest = StatusRequest.none;
      update();
      Get.snackbar("تنبيه", 'الطالب مرتبط ببيانات أخرى',
          backgroundColor: AppColors.primaryColor,
          colorText: AppColors.backgroundIDsColor,
          animationDuration: const Duration(seconds: 5));
    }
  }

  //

  /// تصفية قائمة الطلاب بناءً على النص المدخل
  void filterStudents(String query) async {
    if (query.isEmpty) {
      // إذا كان النص فارغًا، عرض القائمة الأصلية
      filteredStudents = originalStudents;
    } else {
      // تصفية الطلاب بناءً على النص المدخل
      filteredStudents = originalStudents.where((student) {
        final name = student['student_name']?.toLowerCase() ?? '';
        final className = student['class_name']?.toLowerCase() ?? '';
        return name.contains(query.toLowerCase()) ||
            className.contains(query.toLowerCase());
      }).toList();
      update();
    }
    update();
  }

  /// الانتقال إلى صفحة إضافة طالب جديد
  void navigateToAddStudent() async {
    Get.toNamed(AppRoute.addStudentPage)?.then((_) {
      fetchStudentsWithClasses();
    });
  }

  //

  @override
  void onInit() async {
    statusRequest = StatusRequest.none;
    initialData();
    selectedStudent = null;
    selectedClass = null;
    super.onInit();
  }

  //
  @override
  initialData() {
    statusRequest = StatusRequest.none;
    update();
    fetchStudentsAndClasses();

    fetchStudentsWithClasses();
  }
}
