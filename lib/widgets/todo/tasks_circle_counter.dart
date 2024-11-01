import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Providers/tasks_provider.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/constants/app_constants.dart';

class TasksCircleCounter extends ConsumerStatefulWidget {
  const TasksCircleCounter({super.key});

  @override
  ConsumerState<TasksCircleCounter> createState() => _TasksCircleCounterState();
}

class _TasksCircleCounterState extends ConsumerState<TasksCircleCounter> {

  @override
  Widget build(BuildContext context) {
    final tasksFinished = ref.watch(tasksProvider.select((state)=> state.tasksFinished));
    final tasksNotFinished = ref.watch(tasksProvider.select((state)=> state.totalTasks));
    
    final Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Column(
        children: [
          Expanded(
            child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: DottedBorder(
                            padding: EdgeInsets.all(0),
                            borderType: BorderType.Circle,
                            strokeCap: StrokeCap.square,
                            strokeWidth: 5,
                            color: AppColors.primaryText,
                            child: Container(
                              height: size.height*0.23,
                              width: size.width*0.51,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                //color: Colors.red
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    runAlignment: WrapAlignment.center,
                                    children: [
                                  Text('$tasksFinished',style: AppConstants.taskCircleCounterStyle,overflow: TextOverflow.clip),
                                  Divider(thickness: 3,color: AppColors.primaryText,),
                                  Text(
                                      '$tasksNotFinished',
                                      //ref.read(tasksProvider).tasksList.length.toString(),
                                      style: AppConstants.taskCircleCounterStyle,
                                      overflow: TextOverflow.clip
                                      )
                                ]
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]
                    ),
          ),
                  SizedBox(height: size.height*0.03,),
                  Center(
                    child: Text('Amost There!',style: AppConstants.thinText.copyWith(color: AppColors.primaryText,fontSize: 20),),
                  )
        ],
      ),
    );
          
  }
}