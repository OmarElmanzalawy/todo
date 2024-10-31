import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Providers/tasks_provider.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/constants/app_constants.dart';
import 'package:todo/constants/app_icons.dart';
import 'package:todo/models/task_model.dart';

class TaskCircle extends ConsumerWidget {
  const TaskCircle({super.key,required this.taskmodel});

  //TODO MAKE IT REQUIRED LATER
  final TaskModel taskmodel;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final provider = ref.watch(tasksProvider);
    return InkWell(
      onTap: ()async{
        ref.read(tasksProvider.notifier).completeTask(taskmodel);
        Future.delayed(const Duration(seconds: 2),(){
          //IMPLEMENT ANIMATION THEN DELETE TASK
          print('deleted after 2 seconds');
          ref.read(tasksProvider.notifier).deleteTask(taskmodel);
        });
      },
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGreyBorder),
          shape: BoxShape.circle,
          color: taskmodel.status == TaskStatus.finished ? AppColors.darkGreen : AppColors.primaryText
        ),
        child: taskmodel.status == TaskStatus.finished ?  Icon(AppIcons.tick,color: AppColors.primaryText,) : null
      ),
    );
  }
}