import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomIconButton extends StatelessWidget {
  final IconData? icon;
  Function()? onPressed;
  final Color? iconColor;
  CustomIconButton({super.key, this.icon, this.onPressed, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 3, right: 3, bottom: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey.shade400),
      child: Container(
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            boxShadow: const [BoxShadow(blurRadius: .5)],
            borderRadius: BorderRadius.circular(10),
            color: Colors.white),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon ?? Icons.hourglass_empty_rounded,
            color: iconColor ?? Colors.black,
          ),
        ),
      ),
    );
  }
}
