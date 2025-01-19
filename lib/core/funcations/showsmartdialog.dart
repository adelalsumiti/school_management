import 'package:school_management/core/funcations/translatefatabase.dart';
import 'package:school_management/core/shaerd/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

showSmartDialogLoading([bool allowBack = false]) async {
  await SmartDialog.showLoading(
      backDismiss: false,
      // maskColor: Colors.black38,
      builder: (context) {
        return Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.black),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                  flex: 5,
                  child: Center(
                      child: CircularProgressIndicator(color: Colors.white))),
              Expanded(
                flex: 2,
                child: Text(
                  "160".tr,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const Divider(height: .5, thickness: .5, color: Colors.white),
              Expanded(
                flex: 3,
                child: TextButton(
                    onPressed: () {
                      if (allowBack) {
                        hideSmartDialog();
                      } else {
                        Get.back();
                      }
                    },
                    child: Text(
                      "161".tr,
                      style: const TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
        );
      },
      msg: "160".tr);

  return Future(() => true);
}

hideSmartDialog({String? tag}) async {
  await SmartDialog.dismiss(tag: tag, force: true);
}

showSmartDialogCustom(
    {String title = "Dialog",
    String message = "Dialog Message",
    String? tag}) async {
  await SmartDialog.showToast(
    message,
    displayType: SmartToastType.normal,
    // tag: tag,
    builder: (context) {
      return Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
          ),
          Text(
            message,
            textAlign: translateDatabase(TextAlign.right, TextAlign.left),
          ),
          const SizedBox(
            height: 15,
          ),
          CustomButton(
              textbutton: "",
              onPressed: () {
                hideSmartDialog(tag: tag);
              }),
        ],
      );
    },
  );
  return Future(() => true);
}
