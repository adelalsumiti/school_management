// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:school_management/view/controller/controller_account.dart';

// class CustomContainer extends StatelessWidget {
//   const CustomContainer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // final controller = Get.put(ManageAccountsControllerImp());
//     Get.put(ManageAccountsControllerImp());

//     return GetBuilder<ManageAccountsControllerImp>(
//       builder: (controller) => ListView.builder(
//         itemCount: controller.accounts.length,
//         // itemCount: accounts.length,
//         itemBuilder: (
//           context,
//           index,
//         ) {
//           var account = controller.accounts[index];

//           // final account = accounts[index];
//           return ListTile(
//             leading: const Icon(Icons.person),
//             // title: Text(controller.accounts[index]['name']),
//             title: Text(account['name']),

//             subtitle: Text(account['email']),
//             // subtitle: Text(controller.accounts[index]['email']),
//             // subtitle: Text(accounts[index]['email']),
//             // subtitle: Text(accountData),
//             trailing: PopupMenuButton<String>(
//               // onSelected: (action) =>
//               //     _updateAccount(account['id'], action),
//               itemBuilder: (context) => [
//                 const PopupMenuItem(
//                   value: 'accept',
//                   child: Text('قبول'),
//                 ),
//                 const PopupMenuItem(
//                   value: 'delete',
//                   child: Text('حذف'),
//                 ),
//                 const PopupMenuItem(
//                   value: 'block',
//                   child: Text('حظر'),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
