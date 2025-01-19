import 'package:school_management/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CustomIconButtonWithTitle extends StatelessWidget {
  final IconData? icon;
  Function()? onPressed;
  final Color? iconColor;
  final String? title;
  CustomIconButtonWithTitle(
      {super.key, this.icon, this.onPressed, this.iconColor, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 120,
      width: 65,
      margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [BoxShadow(blurRadius: .5, spreadRadius: .5)],
          color: AppColors.backgroundIDsColor),
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: InkWell(
          onTap: onPressed,
          child: Column(
            children: [
              Expanded(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    icon ?? Icons.hourglass_empty_rounded,
                    color: iconColor ?? Colors.black,
                  ),
                ),
              ),
              const Spacer(),
              Expanded(
                child: Center(
                  child: Text(
                    title ?? "164".tr,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        height: 1),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
