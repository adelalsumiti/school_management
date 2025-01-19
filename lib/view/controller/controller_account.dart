import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/core/class/statusrequest.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/funcations/handlinfdatacontroller.dart';
import 'package:school_management/data/dataSource/remote/roleAdmin/account_data.dart';

abstract class ManageAccountsController extends GetxController {
  // final String category;

  fetchAccounts();
  updateAccount(int accountId, String action);
  initialData();
}

class ManageAccountsControllerImp extends ManageAccountsController {
  // String category;
  List accounts = [];
  // String? selectedCategoryy;
  String selectedCategoryy = "admin";
  AccountsData accountsData = AccountsData(Get.find());
  late StatusRequest statusRequest;
  // String selectedCategoryy =
  //     ("admin" 'teacher' 'father' 'student'); // القسم الافتراضي

  @override
  fetchAccounts() async {
    // isLoading = true; // تعيين حالة التحميل
    statusRequest = StatusRequest.loading;
    update();

    // try {
    var response = await accountsData.getDataAccounts(selectedCategoryy);
    statusRequest = handlingData(response);
    update();

    if (StatusRequest.success == statusRequest) {
      // if (response.statusCode == 200) {
      // var data = json.decode(response.body);
      // response is Map<String, dynamic>;
      update();
      debugPrint('Response data: $response'); // طباعة البيانات للمتابعة
      // log(
      //   "accounttt ====> "
      //   "${response['accounts']['id']}",
      // );

      if (response['success'] == true) {
        accounts = response['accounts'] ?? [];
        log("accounttt ====> ");
        update();
        // response = await SharedPreferences.getInstance();
        // response = accounts;
        // update();
      } else if (response['success'] == false) {
        statusRequest = StatusRequest.none;
        update();

        accounts = [];
        throw Exception(response['message']);
      }
      // }
      // else {
      //   statusRequest = StatusRequest.serverfailure;
      //   update();

      //   throw Exception('Failed to fetch accounts');
      // }
    }
    // catch (e) {
    //   statusRequest = StatusRequest.serverfailure;

    //   debugPrint('Error fetching accounts: ');
    //   // Get.snackbar(
    //   //   'Error',
    //   //   'خطأ أثناء جلب الحسابات: $e',
    //   //   snackPosition: SnackPosition.BOTTOM,
    //   // );
    // } finally {
    //   statusRequest = StatusRequest.none;
    // update();
    // }
  }
  //

  @override
  updateAccount(int accountId, String action) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await accountsData.updateAccount(accountId, action);
    statusRequest = await handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // if (response is Map<String, dynamic>) {
      if (response['success']) {
        Get.snackbar(
          "نجاح",
          " تم تحديث الحساب بنجاح",
          backgroundColor: AppColors.primaryColor,
          colorText: AppColors.backgroundIDsColor,
          barBlur: 4,
          animationDuration: const Duration(seconds: 5),
        );
        update();

        changeCategory("admin");

        update();

        statusRequest = StatusRequest.loading;
        update();
      }
      // }
    }
  }

  //

  @override
  void onInit() async {
    statusRequest = StatusRequest.none;

    await initialData();
    super.onInit();
  }

  @override
  initialData() {
    statusRequest = StatusRequest.none;

    fetchAccounts();
  }

  // تغيير الفئة الحالية وجلب البيانات الجديدة
  void changeCategory(String category) {
    selectedCategoryy = category;
    fetchAccounts();
  }
}
