// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:school_management/core/constant/colors.dart';

class CustomTextButtonDelete extends StatelessWidget {
  void Function()? onPressedCancel;
  void Function()? onPressedYes;
  String? titileMessage;
  String? bodyMessage;
  String? nameButton;
  CustomTextButtonDelete({
    super.key,
    this.bodyMessage,
    this.nameButton,
    this.titileMessage,
    this.onPressedCancel,
    this.onPressedYes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 35,
      // width: 110,
      // padding: const EdgeInsets.only(
      //   bottom: 5,
      //   top: 5,
      // ),
      margin: const EdgeInsets.only(
        // bottom: 15,
        bottom: 5,
        left: 10,
        top: 5,
      ),
      decoration: BoxDecoration(
        // shape: BoxShape.circle,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [BoxShadow(spreadRadius: 0.5, blurRadius: 4)],
        color: AppColors.actionColor,
        // border: Border.symmetric(
        //     horizontal: BorderSide(), vertical: BorderSide())
      ),
      child: TextButton(
        child: Text(
          nameButton!,
          style: const TextStyle(
              fontSize: 17,
              color: AppColors.backgroundIDsColor,
              fontWeight: FontWeight.bold),
        ),
        // color: Colors.red[700],
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(titileMessage!),
              content: Text(bodyMessage!),
              actions: [
                TextButton(
                  onPressed: onPressedCancel,
                  child: const Text('إلغاء'),
                ),
                TextButton(
                  onPressed: onPressedYes,
                  child: const Text(
                    'حذف',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
