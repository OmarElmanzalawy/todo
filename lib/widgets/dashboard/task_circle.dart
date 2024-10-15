import 'package:flutter/material.dart';
import 'package:todo/constants/app_colors.dart';

class TaskCircle extends StatelessWidget {
  const TaskCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        print('Task Done');
      },
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGreyBorder),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}