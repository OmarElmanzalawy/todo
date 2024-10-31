import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/Providers/tasks_state.dart';
import 'package:todo/constants/app_constants.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/service/init_getit.dart';
import 'package:todo/service/storage_service.dart';

final tasksProvider = StateNotifierProvider<TasksProvider, TasksState>((ref) {
  return TasksProvider();
});

class TasksProvider extends StateNotifier<TasksState> {
  TasksProvider() : super(TasksState());

  final String tasksKey = 'tasksKey';

  Future<void> addTasks(TaskModel taskModel) async {
    //final storage =  getIt<StorageService>();
    final prefs = await SharedPreferences.getInstance();
    final taskList = [...state.tasksList, taskModel];
    final stringList =
        taskList.map((task) => jsonEncode(task.toJson())).toList();
    prefs.setStringList(tasksKey, stringList);
    state = state.copywith(tasksList: taskList);
  }

  Future<void> deleteTask(TaskModel taskmodel) async {
    final prefs = await SharedPreferences.getInstance();
    List<TaskModel> taskList = state.tasksList;
    taskList.removeWhere((task) => task == taskmodel);
    final stringList =
        taskList.map((task) => jsonEncode(task.toJson())).toList();
    prefs.setStringList(tasksKey, stringList);
    state = state.copywith(tasksList: taskList);
    print(stringList);
  }

  Future<void> editTask(
    TaskModel taskModel, {
    required TextEditingController titleController,
    required TextEditingController descriptionController,
    TimeOfDay? deadline,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final List<TaskModel> tasks = state.tasksList;
    final int index = tasks.indexWhere((element) => element.id == taskModel.id);
    tasks[index] = TaskModel(
        title: titleController.text,
        description: descriptionController.text,
        deadline: deadline);
    print(
        'After editing: ${tasks[index].title}, textfield: ${titleController.text}');
    final stringList = tasks.map((task) => jsonEncode(task.toJson())).toList();
    prefs.setStringList(tasksKey, stringList);
    state = state.copywith(tasksList: tasks);
  }

  Future<void> clearTasks() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(tasksKey, []);
    state = state.copywith(tasksList: []);
  }

  Future<void> loadTasks() async {
    print('LOADING....\n');
    final prefs = await SharedPreferences.getInstance();
    final stringList = prefs.getStringList(tasksKey) ?? [];
    final updatedList =
        stringList.map((task) => TaskModel.fromJson(jsonDecode(task))).toList();
    state = state.copywith(tasksList: updatedList);
    print('LOADED TASKS: $updatedList');
  }

  Future<void> completeTask(
    TaskModel taskModel,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = state.tasksList;

    final int index = taskList.indexWhere((task) => task.id == taskModel.id);
    taskList[index].status = TaskStatus.finished;
    final stringList =
        taskList.map((task) => jsonEncode(task.toJson())).toList();
    prefs.setStringList(tasksKey, stringList);
    state = state.copywith(tasksList: taskList);
  }
}
