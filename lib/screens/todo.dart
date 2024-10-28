import 'package:dotted_border/dotted_border.dart';
import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Providers/tasks_provider.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/constants/app_constants.dart';
import 'package:todo/constants/app_icons.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/service/dialogue_service.dart';
import 'package:todo/service/init_getit.dart';
import 'package:todo/widgets/dialogs/create_task_bottom_sheet.dart';
import 'package:todo/widgets/dialogs/create_task_dialog.dart';
import 'package:todo/widgets/todo/confirm_box.dart';
import 'package:todo/widgets/todo/mytextfield.dart';
import 'package:todo/widgets/todo/task_widget.dart';
import 'package:todo/widgets/todo/tasks_circle_counter.dart';

class TodoScreen extends ConsumerWidget {
  TodoScreen({super.key});

  //You will get these from firestore db when we integrate it

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);
    //tasks.tasksList.isNotEmpty ? print(tasks.tasksList[0].id): null;
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //getIt<DialogueService>().showDialog(CreateTaskDialog(), context);
        getIt<DialogueService>().showBottomSheet(CreateTaskBottomSheet(), context);
        },
        backgroundColor: AppColors.floatingButton,
        foregroundColor: Colors.white,
        child: Icon(
          AppIcons.plus,
          size: 30,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints:
                BoxConstraints(minHeight: 200, minWidth: double.infinity),
            decoration: BoxDecoration(color: AppColors.darkGreen),
            //TODO ADD SOME KIND OF BACKGROUND WITH A BLUR EFFECT (IDEA)
            child: TasksCircleCounter(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 40, left: 15, right: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Today\'s Task',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        print('clicked');
                      },
                      style: ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                          backgroundColor: WidgetStatePropertyAll(
                              AppColors.darkGreen.withOpacity(0.7)),
                          textStyle: WidgetStatePropertyAll(
                              TextStyle(color: AppColors.primaryText)),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          )),
                      child: GestureDetector(
                        onTap: () =>
                            ref.read(tasksProvider.notifier).clearTasks(),
                        child: Row(
                          children: [
                            Icon(
                              AppIcons.plus,
                              color: AppColors.primaryText,
                            ),
                            Text(
                              'Clear All',
                              style: TextStyle(color: AppColors.primaryText),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: tasks.tasksList.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                        onDismissed: (DismissDirection direction) {
                          if (direction == DismissDirection.endToStart) {
                            ref
                                .read(tasksProvider.notifier)
                                .deleteTask(tasks.tasksList[index]);
                          }
                        },
                        key: ValueKey<TaskModel>(tasks.tasksList[index]),
                        secondaryBackground: Container(
                          color: AppColors.red,
                          child: Icon(
                            AppIcons.delete,
                            color: AppColors.primaryText,
                            size: 40,
                          ),
                        ),
                        background: Container(
                          color: AppColors.darkGreen,
                        ),
                        child: TaskWidget(
                          taskModel: tasks.tasksList[index],
                        ));
                  })),
        ],
      ),
    );
  }
}
