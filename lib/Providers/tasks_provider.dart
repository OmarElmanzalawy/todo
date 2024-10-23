import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/Providers/tasks_state.dart';
import 'package:todo/models/task_model.dart';

final tasksProvider = StateNotifierProvider<TasksProvider,TasksState>((ref) {
  return TasksProvider();
});

class TasksProvider extends StateNotifier<TasksState>{
  TasksProvider():super(TasksState());

  Future<void> addTasks(TaskModel taskModel)async{
    //final prefs = await SharedPreferences.getInstance();
    final taskList = [...state.tasksList,taskModel];
    //prefs.setString('tasks',taskList.toString());
    //print('prefs: ${prefs.getString('tasks')}');
    print(taskList);
    state = state.copywith(tasksList: taskList);
  }

  void deleteTask(TaskModel taskmodel){
    List<TaskModel> taskList = state.tasksList;
    taskList.removeWhere((task)=> task==taskmodel);
    state = state.copywith(tasksList: taskList);
    print(taskList);
  }

  void editTask(TaskModel taskModel){
    List<TaskModel> taskList = state.tasksList;
    //TODO COMPLETE EDIT LOGIC
  }

  void clearTasks(){
    state = state.copywith(tasksList: []);
  }


}