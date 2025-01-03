// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

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
    return Container(
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(spreadRadius: 0.5, blurRadius: 4)],
          color: Color.fromARGB(248, 255, 255, 255),
          border: Border.symmetric(
              horizontal: BorderSide(), vertical: BorderSide())),
      child: IconButton(
        icon: const Icon(Icons.delete),
        color: Colors.red[700],
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
