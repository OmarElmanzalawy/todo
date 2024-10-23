import 'package:flutter/material.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/constants/app_icons.dart';

class ConfirmBox extends StatelessWidget {
  const ConfirmBox({super.key,this.ontap});
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return Container(  
      decoration: BoxDecoration(
        color: AppColors.floatingButton,
        borderRadius: BorderRadius.circular(12)
      ),
      child: IconButton(onPressed:ontap ?? (){
        
      }, 
      icon: Icon(AppIcons.tick,color: AppColors.primaryText,)),
    );
  }
}