import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Providers/tasks_state.dart';
import 'package:todo/models/task_model.dart';

final tasksProvider = StateNotifierProvider<TasksProvider,TasksState>((ref) {
  return TasksProvider();
});

class TasksProvider extends StateNotifier<TasksState>{
  TasksProvider():super(TasksState());

  void addTasks(TaskModel taskModel){
    final taskList = state.tasksList;
    taskList.add(taskModel);
    state = state.copywith(tasksList: taskList);
  }

}