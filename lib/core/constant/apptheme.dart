import 'package:school_management/core/constant/colors.dart';
import 'package:flutter/material.dart';

ThemeData themeEnglish = ThemeData(
  fontFamily: "PlayfairDisplay",
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 22, color: AppColors.black),
    headlineMedium: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 26, color: AppColors.black),
    bodyLarge: TextStyle(
      height: 2,
      color: AppColors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    bodyMedium: TextStyle(
      height: 2,
      color: AppColors.grey,
      // fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
  ),
  primarySwatch: Colors.blue,
);

ThemeData themeArabic = ThemeData(
  fontFamily: "Cairo",
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 22, color: AppColors.black),
    headlineMedium: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 26, color: AppColors.black),
    bodyLarge: TextStyle(
      height: 2,
      color: AppColors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    bodyMedium: TextStyle(
      height: 2,
      color: AppColors.grey,
      // fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
  ),
  primarySwatch: Colors.blue,
);
