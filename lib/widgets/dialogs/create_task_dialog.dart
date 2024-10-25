import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Providers/tasks_provider.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/widgets/todo/confirm_box.dart';
import 'package:todo/widgets/todo/mytextfield.dart';

class CreateTaskDialog extends ConsumerStatefulWidget  {
  const CreateTaskDialog({super.key});

  @override
  ConsumerState<CreateTaskDialog> createState() => _CreateTaskDialogState();
}

class _CreateTaskDialogState extends ConsumerState<CreateTaskDialog> {

final TextEditingController taskController = TextEditingController();
final TextEditingController descriptionController = TextEditingController();



  @override
  Widget build(BuildContext context) {
                       return Container(
                    height: 250,
                    color: AppColors.primaryText,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                      children: [
                        Mytextfield(hintText: 'Task Name',controller: taskController,),
                        Mytextfield(hintText: 'Description',fontSize: 16,textColor: AppColors.subtitleText,controller: descriptionController,),
                        SizedBox(height: 60,),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: ConfirmBox(
                              ontap: (){
                                  ref.read(tasksProvider.notifier).addTasks(TaskModel(title: taskController.text,description: descriptionController.text));
                                  Navigator.pop(context);
                              },
                            ),
                          ),
                        )
                      
                      ],
                                              ),
                    ),
                  );
  }
}