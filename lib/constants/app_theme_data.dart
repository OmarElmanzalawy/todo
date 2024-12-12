import 'package:flutter/material.dart';
import 'package:todo/constants/app_colors.dart';

class AppThemeData{

static final ThemeData mainTheme = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.primaryText,
      iconTheme: IconThemeData(color: AppColors.primaryText)
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: Colors.white,
      dialBackgroundColor: AppColors.darkGreen,
      dialHandColor: AppColors.lightGreen,
      dialTextColor: AppColors.primaryText,

      confirmButtonStyle: ButtonStyle(foregroundColor: WidgetStatePropertyAll(AppColors.darkGreen)),
      cancelButtonStyle: ButtonStyle(foregroundColor: WidgetStatePropertyAll(AppColors.darkGreen)),

      hourMinuteColor: AppColors.darkGreen,
      hourMinuteTextColor: AppColors.primaryText,
      
      dayPeriodColor: AppColors.darkestGreen,
      dayPeriodTextColor: Colors.grey.shade500,
      //dayPeriodShape: RoundedRectangleBorder(side: BorderSide.none)
      
    ),
    scaffoldBackgroundColor: AppColors.primaryText,
    colorScheme: ColorScheme.light(surface: Color.fromARGB(26, 13, 184, 247)),
    textButtonTheme: TextButtonThemeData(style: ButtonStyle(
      splashFactory: NoSplash.splashFactory,
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      foregroundColor: WidgetStatePropertyAll(Colors.blue.shade700 ) 
    ))
  );

  static final ThemeData greenTheme = ThemeData.dark().copyWith(
    
    appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
    primaryColor: Colors.white
  );

}