import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/funcations/alertcheckpublic.dart';
// import 'package:adminkingfashion/core/funcations/translatefatabase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showDialogCanNotDelete(String pageName) async {
  var ret = await showDialogNotify(
    title: "156".tr,
    middleText: "$pageName${"157".tr}",
  );

  Future(() => ret);
}

showDialogNameExists() async {
  var ret = await showDialogNotify(
      title: "existsname1".tr, middleText: "existsname2".tr);

  Future(() => ret);
}

showDialogErrorOnAdd(var response) async {
  await showDialogNotify(
    title: "83".tr,
    middleText: "${"158".tr} => \n ($response)",
  );
}

bool isAddagain = false;
Future<bool> showDialogAddAgain(String pageName) async {
  bool add = false;
  if (isAddagain) {
    await alertCheckPublic(
      title: "159".tr,
      middleText: "$pageName ${"270".tr} \n ${"268".tr} $pageName ${"269".tr}",
      onPressedYes: () {
        add = true;
        // Get.back();
      },
      onPressedNo: () {
        add = false;
        // Get.back();
      },
    );
  }

  return Future(() => add);
}

Future<bool> showDialogAddAccount(String pageName) async {
  bool add = false;
  await alertCheckPublic(
    title: "159".tr,
    middleText: "${"271".tr} $pageName \n ${"268".tr} $pageName ${"269".tr}",
    onPressedYes: () {
      add = true;
      Get.back(closeOverlays: true);
    },
    onPressedNo: () {
      add = false;
      Get.back(closeOverlays: true);
    },
  );

  return Future(() => add);
}

Future<bool> showDialogCustom(String middleText) async {
  bool isEdit = false;
  await Get.defaultDialog(
      onWillPop: () => Future(() => false),
      title: "155".tr,
      titleStyle: const TextStyle(
          color: AppColors.primaryColor, fontWeight: FontWeight.bold),
      middleText: middleText,
      actions: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(AppColors.primaryColor)),
            onPressed: () {
              isEdit = true;
              Get.back(closeOverlays: false);
            },
            child: Text("48".tr)),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(AppColors.primaryColor)),
            onPressed: () {
              isEdit = false;
              Get.back(closeOverlays: false);
            },
            child: Text("49".tr))
      ]);

  return Future(() => isEdit);
}

Future<bool> showDialogNeddEdit(String pageName) async {
  bool isEdit = false;
  await Get.defaultDialog(
      onWillPop: () => Future(() => false),
      title: "155".tr,
      titleStyle: const TextStyle(
          color: AppColors.primaryColor, fontWeight: FontWeight.bold),
      middleText: "${"239".tr} $pageName ${"240".tr}",
      actions: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(AppColors.primaryColor)),
            onPressed: () {
              isEdit = true;
              Get.back();
            },
            child: Text("48".tr)),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(AppColors.primaryColor)),
            onPressed: () {
              isEdit = false;
              Get.back();
            },
            child: Text("49".tr))
      ]);

  return Future(() => isEdit);
}

Future<bool> showDialogNeddDelete(String pageName) async {
  bool isDelete = false;
  await Get.defaultDialog(
      onWillPop: () => Future(() => false),
      title: "155".tr,
      titleStyle: const TextStyle(
          color: AppColors.primaryColor, fontWeight: FontWeight.bold),
      middleText: "${"237".tr} $pageName ${"238".tr}",
      actions: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(AppColors.primaryColor)),
            onPressed: () {
              isDelete = true;
              Get.back();
            },
            child: Text("48".tr)),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(AppColors.primaryColor)),
            onPressed: () {
              isDelete = false;
              Get.back();
            },
            child: Text("49".tr))
      ]);

  return Future(() => isDelete);
}

Future<bool> showDialogNotify({
  String title = "",
  String middleText = "",
}) async {
  await Get.defaultDialog(
      backgroundColor: AppColors.backgroundIDsColor,
      title: title,
      titleStyle: const TextStyle(
          color: AppColors.primaryColor, fontWeight: FontWeight.bold),
      middleText: middleText,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(AppColors.primaryColor)),
                onPressed: () {
                  Get.back();
                },
                child: Text("74".tr)),
          ],
        ),
      ]);

  return Future.value(true);
}
