// // import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get.dart';
// // import 'package:school_management/firebase_options.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MyServices extends GetxService {
//   late SharedPreferences sharedPreferences;

//   Future<MyServices> init() async {
//     // await Firebase.initializeApp(
//     //   options: DefaultFirebaseOptions.currentPlatform,
//     // );
//     FirebaseMessaging.instance.getToken().then((value) {
//       String? token = value;
//       print("=====Get_Token_===============$value==========\n");
//       print("\n=====Get_Token_===============$token==========");
//     });
//     sharedPreferences = await SharedPreferences.getInstance();
//     return this;
//   }
// }

// initialServices() async {
//   await Get.putAsync(() => MyServices().init());
// }

// ignore: depend_on_referenced_packages
import 'dart:developer';

// import 'package:adminkingfashion/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;

  Future<MyServices> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    // await Firebase.initializeApp();
    await Firebase.initializeApp(
        // options: DefaultFirebaseOptions.currentPlatform,
        );
    RemoteMessage? remoteMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (remoteMessage != null) {
      log('${remoteMessage.data}', name: 'getInitialMessage');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification?.android;

      if (android != null) {
        log('''
notification.hashCode
${notification.hashCode},
             notification.title
              ${notification.title},
            notification.body
             ${notification.body},
''', name: 'notification');
//         flutterLocalNotificationsPlugin.show(
//             notification.hashCode,
//             notification.title,
//             notification.body,
//             NotificationDetails(
//               android: AndroidNotificationDetails(
//                 'id',
//                 'name',
// channelDescription: 'description'                ,

//                 // TODO add a proper drawable resource to android, for now using
//                 //      one that already exists in example app.
//                 icon: 'launch_background',
//               ),
//             ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // Navigator.pushNamed(context, '/message',
      //     arguments: MessageArguments(message, true));
    });
    return this;
  }
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
}
