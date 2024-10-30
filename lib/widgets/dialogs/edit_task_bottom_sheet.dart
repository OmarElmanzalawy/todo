import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Providers/tasks_provider.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/constants/app_icons.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/widgets/todo/confirm_box.dart';
import 'package:todo/widgets/todo/my_action_chip.dart';
import 'package:todo/widgets/todo/mytextfield.dart';

class EditTaskBottomSheet extends ConsumerStatefulWidget {
  const EditTaskBottomSheet({super.key, required this.taskModel});
  final TaskModel taskModel;

  @override
  ConsumerState<EditTaskBottomSheet> createState() =>
      _EditTaskBottomSheetState();
}

class _EditTaskBottomSheetState extends ConsumerState<EditTaskBottomSheet> {
  final TextEditingController taskController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  TimeOfDay? deadlineTime;
  //TODO: FIX EDIT DEADLINE LOGIC

  @override
  Widget build(BuildContext context) {
    //deadlineTime = widget.taskModel.deadline != null ? widget.taskModel.deadline as TimeOfDay : null;
    final Size size = MediaQuery.sizeOf(context);
    return Container(
      height: size.height * 0.45,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Mytextfield(
              hintText: widget.taskModel.title ?? '',
              controller: taskController,
            ),
            Mytextfield(
              hintText: widget.taskModel.description ?? '',
              fontSize: 16,
              textColor: AppColors.subtitleText,
              controller: descriptionController,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyActionChip(
                  label: Text(widget.taskModel.deadline != null
                      ? widget.taskModel.deadline!
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
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0, bottom: 12),
                child: ConfirmBox(
                  ontap: () {
                    ref.read(tasksProvider.notifier).editTask(widget.taskModel,
                        titleController: taskController,
                        descriptionController: descriptionController,
                        deadline: deadlineTime!= null ? deadlineTime.toString() : widget.taskModel.deadline ?? null
                        );
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
