import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Providers/tasks_provider.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/constants/app_icons.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/widgets/todo/confirm_box.dart';
import 'package:todo/widgets/todo/my_action_chip.dart';
import 'package:todo/widgets/todo/mytextfield.dart';

class CreateTaskBottomSheet extends ConsumerStatefulWidget {
  const CreateTaskBottomSheet({super.key});

  @override
  ConsumerState<CreateTaskBottomSheet> createState() => _CreateTaskBottomSheetState();
}

class _CreateTaskBottomSheetState extends ConsumerState<CreateTaskBottomSheet> {
  final TextEditingController taskController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  TimeOfDay? deadlineTime;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Container(
      height: size.height * 0.45,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Mytextfield(
              hintText: 'Task Name',
              controller: taskController,
            ),
            Mytextfield(
              hintText: 'Description',
              fontSize: 16,
              textColor: AppColors.subtitleText,
              controller: descriptionController,
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyActionChip(
                  label: Text(deadlineTime != null
                      ? deadlineTime!.format(context).toString()
                      : 'Deadline?'),
                  backgroundColor: Colors.grey.shade100,
                  icon: Icon(AppIcons.alarm, color: Colors.black),
                  onpressed: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      //initialEntryMode: TimePickerEntryMode.input,
                      barrierColor: Colors.transparent,
                    ).then((value) => setState(() {
                          deadlineTime = value;
                        }));
                  },
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.025,
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 0.0,bottom: 12),
                child: ConfirmBox(
                  ontap: () {
                    ref.read(tasksProvider.notifier).addTasks(TaskModel(
                        title: taskController.text,
                        description: descriptionController.text,
                        deadline:  deadlineTime!.format(context).toString()));
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
