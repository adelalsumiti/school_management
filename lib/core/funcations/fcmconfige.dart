// // ignore_for_file: avoid_print

// import 'package:school_management/view/controller/orders/ordersscreen_controller.dart';
// import 'package:school_management/core/constant/alldatafromsql.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
// import 'package:get/get.dart';

// requestPermissionNotification() async {
//   NotificationSettings settings =
//       await FirebaseMessaging.instance.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );
//   print("====Setting Notification ============$settings =====");
// }

// fcmconfig() {
//   FirebaseMessaging.onMessage.listen((message) async {
//     // print("================== Notification =================");
//     // print(message.notification!.title);
//     // print(message.notification!.body);
//     // print("===tablename=======${message.data["tablename"]}====");

//     if (message.notification!.title == "crud") {
//       if (message.data["tablename"] == "colors") {
//         if (message.data["operation"] == "add") {
//           await addNewColorFromSqlIntoShared(message.data["data"]);
//         } else if (message.data["operation"] == "edit") {
//           await editOneColorFromSqlIntoShared(message.data["data"]);
//         } else if (message.data["operation"] == "delete") {
//           await deleteOneColorFromSqlIntoShared(message.data["data"]);
//         }
//       } else if (message.data["tablename"] == "sizes") {
//         if (message.data["operation"] == "add") {
//           await addNewSizeFromSqlIntoShared(message.data["data"]);
//         } else if (message.data["operation"] == "edit") {
//           await editOneSizeFromSqlIntoShared(message.data["data"]);
//         } else if (message.data["operation"] == "delete") {
//           await deleteOneSizeFromSqlIntoShared(message.data["data"]);
//         }
//       }
//     } else {
//       FlutterRingtonePlayer().playNotification();
//       Get.snackbar(message.notification!.title!, message.notification!.body!);
//       refreshPageNotification(message.data);
//     }
//   });
// }

// refreshPageNotification(data) {
//   print("============================= page id ");
//   print(data['pageid']);
//   print("============================= page name ");
//   print(data['pagename']);
//   print("================== Current Route");
//   print(Get.currentRoute);

//   if (Get.currentRoute == "/orderspending" &&
//       data['pagename'] == "refreshorderpending") {
//     OrderScreenControllerImp controller = Get.find();
//     controller.refershOrders();
//   }
// }
