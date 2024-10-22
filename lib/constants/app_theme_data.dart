import 'package:flutter/material.dart';
import 'package:todo/constants/app_colors.dart';

class AppThemeData{

static final ThemeData mainTheme = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(
      elevation: 1,
    ),
    scaffoldBackgroundColor: AppColors.primaryText,
    colorScheme: ColorScheme.light(surface: Color.fromARGB(26, 13, 184, 247))
  );

  static final ThemeData greenTheme = ThemeData.dark().copyWith(
    
    appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
    primaryColor: Colors.white
  );

}