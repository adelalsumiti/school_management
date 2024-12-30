// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:school_management/core/constant/colors.dart';
import 'package:school_management/core/constant/imageAssets.dart';

class LogoAuth extends StatelessWidget {
  const LogoAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryColor,
        boxShadow: [
          BoxShadow(blurRadius: 5, spreadRadius: 1, color: AppColors.black)
        ],
      ),
      child: CircleAvatar(
        foregroundColor: AppColors.primaryColor,
        radius: 80,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: ClipOval(child: Image.asset(AppImageAsset.logo)),
        ),
      ),
    );
  }
}
