// ignore_for_file: public_member_api_docs, sort_constructors_first
//ignore_for_file: file_names

// ignore_for_file: unused_import

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:school_management/core/constant/routes.dart';

// import 'package:school_management/linkapi.dart';
import 'package:school_management/view/controller/controller_account.dart';
// import 'package:school_management/view/screen/accounts/manageAccountsPage.dart';

class AccountsList extends StatefulWidget {
  // final String category;

  const AccountsList({
    super.key,
    // required this.category,
  });

  @override
  State<AccountsList> createState() => _AccountsListState();
}

class _AccountsListState extends State<AccountsList> {
  @override
  Widget build(BuildContext context) {
    // Get.put(ManageAccountsControllerImp(category: category));
    Get.put(ManageAccountsControllerImp());
    return GetBuilder<ManageAccountsControllerImp>(
        builder: (controller) => controller.isLoading

            // return isLoading
            ? const Center(child: CircularProgressIndicator())
            : controller.accounts.isEmpty
                // : accounts.isEmpty
                ? const Center(child: Text('لا توجد حسابات لعرضها'))
                : ListView.builder(
                    itemCount: controller.accounts.length,
                    // itemCount: accounts.length,
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      var account = controller.accounts[index];
                      controller.isLoading = true;

                      // final account = accounts[index];
                      return Wrap(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.person),
                            // title: Text(controller.accounts[index]['name']),
                            title: Text("${account['name']}  "
                                "${account['status'].toString()}"),

                            subtitle: Text(account['email']),

                            trailing: PopupMenuButton<String>(
                              onSelected: (action) {
                                controller.changeCategory("admin");
                                controller.updateAccount(account['id'], action);
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'accept',
                                  child: Text('قبول'),
                                ),
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Text('حذف'),
                                ),
                                const PopupMenuItem(
                                  value: 'block',
                                  child: Text('حظر'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ));
  }
}
