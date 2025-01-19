import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management/core/class/handlingdataview.dart';
import 'package:school_management/view/controller/controller_account.dart';

class AccountsList extends StatelessWidget {
  const AccountsList({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    Get.put(ManageAccountsControllerImp());
    return GetBuilder<ManageAccountsControllerImp>(
        builder: (controller) => HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: ListView.builder(
              itemCount: controller.accounts.length,
              // itemCount: accounts.length,
              itemBuilder: (
                context,
                index,
              ) {
                var account = controller.accounts[index];

                return Wrap(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person),
                      // title: Text(controller.accounts[index]['name']),
                      title: Text("${account['name']}  "
                          "${account['status'].toString()}"),

                      subtitle: Text(account['email']),

                      trailing: PopupMenuButton<String>(
                        onSelected: (action) async {
                          int accountId = int.parse(account['id'].toString());
                          await controller.updateAccount(accountId, action);
                          // controller.changeCategory("admin");
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
            )));
  }
}
