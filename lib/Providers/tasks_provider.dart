import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/Providers/tasks_state.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/service/init_getit.dart';
import 'package:todo/service/storage_service.dart';

final tasksProvider = StateNotifierProvider<TasksProvider,TasksState>((ref) {
  return TasksProvider();
});

class TasksProvider extends StateNotifier<TasksState>{
  TasksProvider():super(TasksState());

  final String tasksKey = 'tasksKey';

  Future<void> addTasks(TaskModel taskModel)async{
    //final storage =  getIt<StorageService>();
    final prefs = await SharedPreferences.getInstance();
    final taskList = [...state.tasksList,taskModel];
    final stringList = taskList.map((task)=> task.toString()).toList();
    prefs.setStringList(tasksKey, stringList);
    state = state.copywith(tasksList: taskList);
  }

  Future<void> deleteTask(TaskModel taskmodel)async{
    final prefs = await SharedPreferences.getInstance();
    List<TaskModel> taskList = state.tasksList;
    taskList.removeWhere((task)=> task==taskmodel);
    final stringList = taskList.map((task)=> task.toString()).toList();
    prefs.setStringList(tasksKey, stringList);
    state = state.copywith(tasksList: taskList);
    print(taskList);
  }

  Future<void> editTask(TaskModel taskModel,{TextEditingController? titleController, TextEditingController? descriptionController})async{
    final prefs =await SharedPreferences.getInstance();
    titleController!.text = taskModel.title ?? '';
    descriptionController!.text = taskModel.description ?? '';
    final List<TaskModel> tasks = state.tasksList;
    final int index = tasks.indexWhere((element)=> element.id == taskModel.id);
    tasks[index] = TaskModel(title: titleController!.text,description: descriptionController!.text);
    final stringList = tasks.map((task)=> task.toString()).toList();
    prefs.setStringList(tasksKey, stringList);
    state = state.copywith(tasksList: tasks);
  }

  Future<void> clearTasks()async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(tasksKey, []);
    state = state.copywith(tasksList: []);
  }

  Future<void> loadTasks()async{
    final prefs = await SharedPreferences.getInstance();
    final stringList = prefs.getStringList(tasksKey);
    //TODO: CONVERT STRING LISTS IN EVERY FUNCTION INTO JSON FORMAT INSTEAD OF TOSTRING 
    // THEN DECODE IT USING FROMJSON 
    //final updatedList = stringList.map((task)=> )
  }

}