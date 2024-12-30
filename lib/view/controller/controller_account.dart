import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/linkapi.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class ManageAccountsController extends GetxController {
  // final String category;

  fetchAccounts();
  // updateAccounts();
  initialData();
}

class ManageAccountsControllerImp extends ManageAccountsController {
  // String category;

  // ManageAccountsControllerImp({required this.category});

  List<dynamic> accounts = [];
  bool isLoading = true;
  // String? selectedCategoryy;
  String selectedCategoryy = "admin";
  // String selectedCategoryy =
  //     ("admin" 'teacher' 'father' 'student'); // القسم الافتراضي

  @override
  fetchAccounts() async {
    isLoading = true; // تعيين حالة التحميل
    update();

    try {
      var response = await http.get(
        Uri.parse('${AppLink.getAccounts}?category=$selectedCategoryy'),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        debugPrint('Response data: $data'); // طباعة البيانات للمتابعة

        if (data['success']) {
          accounts = data['accounts'] ?? [];
          data = await SharedPreferences.getInstance();
          data = accounts;
        } else {
          accounts = [];
          throw Exception(data['message']);
        }
      } else {
        throw Exception('Failed to fetch accounts');
      }
    } catch (e) {
      debugPrint('Error fetching accounts: $e');
      Get.snackbar(
        'Error',
        'خطأ أثناء جلب الحسابات: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading = false; // إنهاء حالة التحميل
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    initialData();
  }

  @override
  initialData() async {
    await fetchAccounts();
    isLoading = true;
  }

  // تغيير الفئة الحالية وجلب البيانات الجديدة
  void changeCategory(String category) {
    selectedCategoryy = category;
    fetchAccounts();
  }

  Future<void> updateAccount(String accountId, String action) async {
    isLoading = true;
    try {
      final response = await http.post(
        Uri.parse(AppLink.updateAccountStatus),
        body: {
          'accountId': accountId,
          'action': action, // "accept" أو "delete" أو "block"
        },
      );

      final data = json.decode(response.body);
      if (data['success']) {
        isLoading = false;
        // ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message']));
        // );
        // _fetchAccounts(); // تحديث القائمة
      } else {
        throw Exception(data['message']);
      }
    } catch (e) {
      // debugPrint('Error updating account: $e');
      // ScaffoldMessenger.of(context).showSnackBar(
      // SnackBar(content: Text('خطأ أثناء تحديث الحساب: $e'));
      // );
    }
  }
}
