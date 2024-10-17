import 'package:flutter/material.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/constants/app_constants.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/widgets/dashboard/task_circle.dart';

class TaskWidget extends StatelessWidget {

  final TaskModel taskModel;

  const TaskWidget({required this.taskModel});


  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 75),
      //height: 75,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.primaryText,
          border: Border.symmetric(horizontal: BorderSide(color: AppColors.lightGreyBorder,width: 1),vertical:BorderSide(color: AppColors.lightGreyBorder,style: BorderStyle.none) ),
          
),
      child: Padding(
        padding: const EdgeInsets.only(top: 7.0,left: 12,right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(taskModel.title,style: AppConstants.taskTitleStyle.copyWith(fontWeight: FontWeight.normal,fontSize: 18),),
                TaskCircle()
              ],
            ),
            taskModel.description != null ? Text(
              taskModel.description!,
              style: TextStyle(fontSize: 14,color: AppColors.subtitleText),
              ) : SizedBox(),
              taskModel.deadline != null 
              ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(color: AppColors.subtitleText,indent: 0,endIndent: 0,),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: 'Deadline:\t\t',style: TextStyle(color: Colors.grey.shade700,fontWeight: FontWeight.w500)),
                          TextSpan(text: taskModel.deadline.toString(),style: AppConstants.thinText.copyWith(fontSize: 14,),)
                        ],
                        
                        )
                      
                      )
                  ],
                ),
              ) : SizedBox()
          ],
        ),
      ),
    );
  }
}