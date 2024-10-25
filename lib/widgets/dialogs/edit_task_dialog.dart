import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Providers/tasks_provider.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/widgets/todo/confirm_box.dart';
import 'package:todo/widgets/todo/mytextfield.dart';

class EditTaskDialog extends ConsumerStatefulWidget  {
  const EditTaskDialog({super.key,required this.taskModel});
  final TaskModel taskModel;

  @override
  ConsumerState<EditTaskDialog> createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends ConsumerState<EditTaskDialog> {

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
                        Mytextfield(hintText: widget.taskModel.title??'',controller: taskController,),
                        Mytextfield(hintText: widget.taskModel.description??'',fontSize: 16,textColor: AppColors.subtitleText,controller: descriptionController,),
                        SizedBox(height: 60,),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: ConfirmBox(
                              ontap: (){
                                  ref.read(tasksProvider.notifier).editTask(widget.taskModel, titleController: taskController,descriptionController: descriptionController);
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