import 'package:flutter/material.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/constants/app_constants.dart';
import 'package:todo/widgets/dashboard/task_circle.dart';

class DashTask extends StatelessWidget {
  const DashTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 170,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.primaryText,
          border: Border.all(color: AppColors.lightGreyBorder),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1))
          ]),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Continue Flutter Course For 2 Hours',
              style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 22),
            ),
            SizedBox(height: 35,),
            Align(
              alignment: Alignment.bottomRight,
              child: TaskCircle(),
            ),
          ],
        ),
      ),
    );
  }
}
