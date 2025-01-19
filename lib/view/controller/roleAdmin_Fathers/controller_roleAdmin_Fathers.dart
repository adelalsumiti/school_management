import 'dart:developer';
import 'package:get/get.dart';
import 'package:school_management/core/class/statusrequest.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/constant/routes.dart';
import 'package:school_management/core/funcations/handlinfdatacontroller.dart';
import 'package:school_management/data/dataSource/remote/roleAdmin/fathers_data.dart';

abstract class FathersController extends GetxController {
  fetchFathersWithStudents();
  deleteFather(String studentIdd);
  addFatherToStudent();
  fetchRelationShips();
  initialData();
}

class FathersControllerImp extends FathersController {
  FathersData fathersData = FathersData(Get.find());
  late StatusRequest statusRequest;
  List<dynamic> relationships = [];
  List<dynamic> filteredParents = [];
  List<dynamic> originalParents = [];
  List<dynamic> parents = [];
  List<dynamic> students = [];
  String? selectedParent;
  String? selectedStudent;

  //
//
  @override
  fetchRelationShips() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await fathersData.getDataRelationships();
    statusRequest = await handlingData(response);
    update();
    if (StatusRequest.success == statusRequest) {
      if (response['success'] == true) {
        update();

        relationships = response['relationships'];
        filteredParents = relationships;
        originalParents = filteredParents;
        update();

        log("$relationships", name: 'relationships');
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
    update();
  }

  //
  @override
  fetchFathersWithStudents() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await fathersData.getDataFathersWithStudents();
    statusRequest = await handlingData(response);
    update();
    if (StatusRequest.success == statusRequest) {
      if (response['success'] == true) {
        parents = response['parents'];
        update();

        students = response['students'];
        update();

        log("$response", name: 'Father And Student');
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
    update();
  }

  //
  @override
  addFatherToStudent() async {
    if (selectedParent == null || selectedStudent == null) {
      Get.snackbar("تنبيه", 'يرجى اختيار ولي أمر وطالب',
          backgroundColor: AppColors.primaryColor,
          colorText: AppColors.backgroundIDsColor,
          animationDuration: const Duration(seconds: 5));
      return;
    }
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await fathersData.addFatherToStudent(selectedStudent, selectedParent);
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

        update();

        // Get.back();
        Get.snackbar("نجاح", 'تمت إضافة الأب بنجاح!',
            backgroundColor: AppColors.primaryColor,
            colorText: AppColors.backgroundIDsColor,
            animationDuration: const Duration(seconds: 5));
        update();

        await fetchRelationShips();
        update();
      } else {
        statusRequest = StatusRequest.none;
        Get.snackbar("تنبيه", 'الاسم موجود من قبل',
            backgroundColor: AppColors.primaryColor,
            colorText: AppColors.backgroundIDsColor,
            animationDuration: const Duration(seconds: 5));
        update();

        throw Exception(response['message'] ?? 'فشل في إضافة الأب');
      }
    }
    update();
  }

  @override
  deleteFather(String studentIdd) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await fathersData.deleteFather(studentIdd);
    statusRequest = await handlingData(response);
    update();
    if (StatusRequest.success == statusRequest) {
      if (response['success']) {
        Get.snackbar("نجاح", 'تم حذف الأب بنجاح!');
        await fetchRelationShips();
        update();
      } else {
        statusRequest = StatusRequest.none;
        update();
        throw Exception(response['message'] ?? 'فشل في حذف الأب');
      }
    } else {
      statusRequest = StatusRequest.none;
      update();
      Get.snackbar("تنبيه", 'الأب مرتبط ببيانات أخرى',
          backgroundColor: AppColors.primaryColor,
          colorText: AppColors.backgroundIDsColor,
          animationDuration: const Duration(seconds: 5));
    }
  }

  //

  /// تصفية قائمة ولي الأمرين بناءً على النص المدخل
  void filterParents(String query) async {
    if (query.isEmpty) {
      // إذا كان النص فارغًا، عرض القائمة الأصلية
      filteredParents = originalParents;
    } else {
      // تصفية ولي الأمرين بناءً على النص المدخل
      filteredParents = originalParents.where((parent) {
        final name = parent['parent_name']?.toLowerCase() ?? '';
        final studentName = parent['student_name']?.toLowerCase() ?? '';
        return name.contains(query.toLowerCase()) ||
            studentName.contains(query.toLowerCase());
      }).toList();
    }
    update();
  }

  /// الانتقال إلى صفحة إضافة طالب جديد
  void navigateToAddStudent() async {
    Get.toNamed(AppRoute.addParentPage)?.then((_) {
      fetchRelationShips();
    });
  }

  //

  @override
  void onInit() async {
    statusRequest = StatusRequest.none;
    initialData();
    selectedParent = null;
    selectedStudent = null;
    update();

    super.onInit();
  }

  //
  @override
  initialData() {
    statusRequest = StatusRequest.none;
    update();
    fetchFathersWithStudents();
    fetchRelationShips();
  }
}
