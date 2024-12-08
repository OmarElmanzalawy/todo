import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Providers/tasks_provider.dart';
import 'package:todo/Providers/tasks_stream_provder.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/constants/app_constants.dart';
import 'package:todo/constants/app_icons.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/service/dialogue_service.dart';
import 'package:todo/service/init_getit.dart';
import 'package:todo/utils/app_utils.dart';
import 'package:todo/widgets/dialogs/create_task_bottom_sheet.dart';
import 'package:todo/widgets/todo/task_widget.dart';
import 'package:todo/widgets/todo/tasks_circle_counter.dart';

class TodoScreen extends ConsumerStatefulWidget {
  TodoScreen({super.key});

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  final GlobalKey<AnimatedListState> animatedListKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final tasksStream = ref.watch(tasksStreamProvider);
    final tasks = ref.watch(tasksProvider);
    final sortedTasks = AppUtils.sortTasks(ref);
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                getIt<DialogueService>()
                    .showBottomSheet(CreateTaskBottomSheet(
                      animatedlistKey: animatedListKey,
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
                        onTap: () async=>
                           await ref.read(tasksProvider.notifier).clearTasks(),
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
          tasksStream.when(
            error: (error, stackTrace) {
              print(error.toString());
              return Center(
                child: Text('Error Occured'),
              );
            },

            loading: () {
              //TODO USE SKELETON TASKS LOADING INSTEAD OF CIRCULAR PROGRESS INDICATOR
              return Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: AppColors.darkGreen,
                ),
              );
            },

            data: (data) {
              return Expanded(
              //Finished
              child: AnimatedReorderableListView(
                enterTransition: [FadeIn()],
                exitTransition: [SlideInDown()],
                insertDuration: const Duration(milliseconds: 500),
                removeDuration: const Duration(milliseconds: 500),

                onReorder: (oldIndex,newIndex){
                  //REORDER FUNCTION
                  ref.read(tasksProvider.notifier).reOrder(oldIndex, newIndex);
                },

                  items: sortedTasks,
                  itemBuilder: (context, index) {
                    return Dismissible(
                        onDismissed: (DismissDirection direction) async{
                          if (direction == DismissDirection.endToStart) {
                            await ref
                                .read(tasksProvider.notifier)
                                .deleteTask(sortedTasks[index]);
                                print('widget deleted');
                          }
                        },
                        key: ValueKey<TaskModel>(sortedTasks[index]),
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
                          taskModel:  sortedTasks[index],
                          animatedlistKey: animatedListKey,
                          isMainList: true,
                          indexForDeletion: index,
                        ));
                  },
                  
                  ),
                  );
            },
          )
          /*Center(
                    child: Text('Finished',style: AppConstants.taskTitleStyle.copyWith(color: AppColors.subtitleText),),
                  ),*/
          /*Expanded(
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
              ))*/
        ],
      ),
    );
  }
}
