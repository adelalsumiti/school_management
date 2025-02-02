// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:school_management/core/constant/colors.dart';

class CustomButtonDelete extends StatelessWidget {
  void Function()? onPressedCancel;
  void Function()? onPressedYes;
  String? titileMessage;
  String? bodyMessage;
  CustomButtonDelete({
    super.key,
    this.bodyMessage,
    this.titileMessage,
    this.onPressedCancel,
    this.onPressedYes,
  });

  @override
  Widget build(BuildContext context) {
    return
        // Container(
        //   // height: 30,
        //   // width: 30,
        //   decoration: const BoxDecoration(
        //     color: AppColors.actionColor,
        //     shape: BoxShape.circle,
        //     boxShadow: [BoxShadow(spreadRadius: 0.5, blurRadius: 4)],
        //     // color: Color.fromARGB(248, 255, 255, 255),
        //     // border: Border.symmetric(
        //     //     horizontal: BorderSide(), vertical: BorderSide())
        //   ),
        //   child:
        CircleAvatar(
      maxRadius: 17,
      backgroundColor: AppColors.actionColor,
      child: MaterialButton(
        padding: const EdgeInsets.all(1),

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
        height: 20,
        minWidth: 20,
        elevation: 50,
        textColor: AppColors.backgroundIDsColor,
        child: const Icon(
          Icons.delete,
          size: 23,
        ),
        // ),
      ),
    );
  }
}
