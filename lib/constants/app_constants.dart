import 'package:flutter/material.dart';
import 'package:todo/constants/app_colors.dart';

class AppConstants {
  static const TextStyle h1Text = TextStyle(
    color: AppColors.primaryText,
    fontWeight: FontWeight.w500,
    fontSize: 40,
  );
  static const TextStyle thinText = TextStyle(
      fontWeight: FontWeight.w300,
      color: AppColors.fadedBlack,
      fontSize: 16,
      letterSpacing: 1);

  static const TextStyle taskTitleStyle = TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 22);

}

