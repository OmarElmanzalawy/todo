import 'package:flutter/material.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/constants/app_icons.dart';

class ConfirmBox extends StatelessWidget {
  const ConfirmBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(  
      decoration: BoxDecoration(
        color: AppColors.floatingButton,
        borderRadius: BorderRadius.circular(12)
      ),
      child: IconButton(onPressed: (){

      }, 
      icon: Icon(AppIcons.tick,color: AppColors.primaryText,)),
    );
  }
}