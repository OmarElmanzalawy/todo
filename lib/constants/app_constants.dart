import 'package:flutter/material.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/screens/dashboard.dart';
import 'package:todo/screens/rewards_screen.dart';
import 'package:todo/screens/todo.dart';

  Map<int,Widget> pages ={
    0: DashBoardScreen(),
    1: TodoScreen(),
    2: RewardsScreen(),
    3: Text('Profile Screen'),
  };

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
      color: AppColors.black, fontWeight: FontWeight.w500, fontSize: 22);

  static const TextStyle taskCircleCounterStyle = TextStyle(
      fontSize: 45, color: AppColors.primaryText, fontWeight: FontWeight.bold);

  static const TextStyle splashItemTitleStyle = TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: AppColors.black,); 

}

  enum TaskStatus{
    finished,
    unfinished
  }
