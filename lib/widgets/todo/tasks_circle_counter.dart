import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Providers/tasks_provider.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/constants/app_constants.dart';

class TasksCircleCounter extends ConsumerWidget {
  const TasksCircleCounter({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Column(
        children: [
          Stack(
                    alignment: Alignment.center,
                    children: [
                      DottedBorder(
                        padding: EdgeInsets.all(0),
                        borderType: BorderType.Circle,
                        strokeCap: StrokeCap.square,
                        strokeWidth: 5,
                        color: AppColors.primaryText,
                        child: Container(
                          height: 220,
                          width: 220,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('7',style: AppConstants.taskCircleCounterStyle),
                              Divider(thickness: 2,color: AppColors.primaryText,indent: 25,endIndent: 25,),
                              Text(
                                  '12',
                                  //ref.read(tasksProvider).tasksList.length.toString(),
                                  style: AppConstants.taskCircleCounterStyle,
                                  )
                            ],
                          ),
                        ),
                      ),
                    ]
                  ),
                  SizedBox(height: 30,),
                  Center(
                    child: Text('Amost There!',style: AppConstants.thinText.copyWith(color: AppColors.primaryText,fontSize: 20),),
                  )
        ],
      ),
    );
          
  }
}