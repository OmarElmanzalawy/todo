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
import 'package:todo/widgets/todo/task_widget.dart';
import 'package:todo/widgets/todo/tasks_circle_counter.dart';

class TodoScreen extends ConsumerStatefulWidget {
  TodoScreen({super.key});

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  final GlobalKey<AnimatedListState> finishedAnimatedListKey = GlobalKey();
  final GlobalKey<AnimatedListState> unfinishedAnimatedListKey = GlobalKey();

  @override
  Widget build(
    BuildContext context,
  ) {
    
    final tasks = ref.watch(tasksProvider);
    print(tasks.unfinishedTasks);
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      /*floatingActionButton: FloatingActionButton(
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
      ),*/
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                getIt<DialogueService>()
                    .showBottomSheet(CreateTaskBottomSheet(
                      animatedlistKey: unfinishedAnimatedListKey,
                      taskList: tasks.unfinishedTasks,
                    ), context);
              },
              icon: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  AppIcons.plus,
                  color: AppColors.primaryText,
                  size: 30,
                ),
              ))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              constraints:
                  BoxConstraints(minHeight: 200, minWidth: double.infinity),
              decoration: BoxDecoration(color: AppColors.darkGreen),
              //TODO ADD SOME KIND OF BACKGROUND WITH A BLUR EFFECT (IDEA)
              child: TasksCircleCounter(),
            ),
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
              flex: 2,
              //Finished
              child: AnimatedList(
                key: unfinishedAnimatedListKey,
                  initialItemCount: tasks.unfinishedTasks.length,
                  itemBuilder: (context, index,animation) {
                    return SizeTransition(
                      sizeFactor: animation,
                      child: Dismissible(
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
                            taskModel:  tasks.unfinishedTasks[index],
                            animatedlistKey: unfinishedAnimatedListKey,
                            isMainList: true,
                            indexForDeletion: index,
                          )),
                    );
                  })),
          /*Center(
                    child: Text('Finished',style: AppConstants.taskTitleStyle.copyWith(color: AppColors.subtitleText),),
                  ),*/
          Expanded(
              flex: 1,
              child: AnimatedList(
                key: finishedAnimatedListKey,
                initialItemCount: tasks.finishedTasks.length,
                itemBuilder: (context, index, animation) {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: TaskWidget(
                      taskModel: tasks.finishedTasks[index],
                      animatedlistKey: finishedAnimatedListKey,
                      isMainList: false,
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }
}
