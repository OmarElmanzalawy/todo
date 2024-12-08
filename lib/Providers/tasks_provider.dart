import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/Providers/tasks_state.dart';
import 'package:todo/constants/app_constants.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/service/dialogue_service.dart';
import 'package:todo/service/firestore_service.dart';
import 'package:todo/service/init_getit.dart';

final tasksProvider = StateNotifierProvider<TasksProvider, TasksState>((ref) {
  return TasksProvider();
});

class TasksProvider extends StateNotifier<TasksState> {
  TasksProvider() : super(TasksState());

  final String tasksKey = 'tasksKey';

  Future<void> addTasks(TaskModel taskModel) async {
    //final storage =  getIt<StorageService>();
    //final prefs = await SharedPreferences.getInstance();
    final taskList = [...state.tasksList, taskModel];
    /*final stringList =
        taskList.map((task) => jsonEncode(task.toJson())).toList();
    prefs.setStringList(tasksKey, stringList);*/
    //REMOVE COMMENT LATER FOR LINE BELOW
    final int totalTasks = state.totalTasks! + 1;
    await FirestoreService.addTask(taskModel,FirebaseAuth.instance.currentUser!.uid);
    state = state.copywith(tasksList: taskList,totalTasks: totalTasks);
    //print('Unfinished Tasks after add: ${state.unfinishedTasks}');
    //print('Total Tasks after add: ${state.tasksList}');
  }

  Future<void> deleteTask(TaskModel taskmodel) async {
    //final prefs = await SharedPreferences.getInstance();
    
    /*final stringList =
        taskList.map((task) => jsonEncode(task.toJson())).toList();
    prefs.setStringList(tasksKey, stringList);*/

    //REMOVE COMMENT LATER FOR LINE BELOW
    final bool wasCompleted = taskmodel.status == TaskStatus.finished ? true : false;
    final int? finishedTasks = wasCompleted ? state.tasksFinished! - 1 : state.tasksFinished;
    final int totalTasks = state.totalTasks! -1; 

    await FirestoreService.deleteTask(taskmodel);

    List<TaskModel> taskList = state.tasksList;
    taskList.removeWhere((task) => task == taskmodel);

    print('FIRESTORE DELETE');
    state = state.copywith(tasksList: taskList,totalTasks: totalTasks,tasksFinished: finishedTasks);
  }

  Future<void> editTask(
    TaskModel taskModel, {
    required TextEditingController titleController,
    required TextEditingController descriptionController,
    TimeOfDay? deadline,
    required TaskStatus status,
  }) async {
    //final prefs = await SharedPreferences.getInstance();
    /*final List<TaskModel> tasks = status == TaskStatus.finished ?  state.finishedTasks : state.tasksList;
    final int index = tasks.indexWhere((element) => element.id == taskModel.id);
    tasks[index] = TaskModel(
        id: UniqueKey().toString(),
        title: titleController.text,
        description: descriptionController.text,
        deadline: deadline,
        status: status
        );
    final stringList = tasks.map((task) => jsonEncode(task.toJson())).toList();
    //prefs.setStringList(tasksKey, stringList);
    state = state.copywith(tasksList: tasks);*/
    await FirestoreService.editTask(taskModel: taskModel, titleController: titleController, descriptionController: descriptionController, status: status,deadline: deadline);

  }

  Future<void> clearTasks() async {
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setStringList(tasksKey, []);
     await FirestoreService.clearTasks();
    state = state.copywith(tasksList: [],tasksFinished: 0,totalTasks: 0);
   
  }

  Future<void> loadTasks() async {
    print('LOADING....\n');
    //final prefs =  await SharedPreferences.getInstance();
     //prefs.getStringList(tasksKey) ?? [];
    // final updatedList =
    //     stringList.map((task) => TaskModel.fromJson(jsonDecode(task))).toList();

    //Count finished and unfinished tasks
    int finished =0;
    int totalTasks =0;
    //REMOVE COMMENT LATER FOR LINE BELOW
   

    print('Finished: $finished\n NotFinished: $totalTasks');
    
    final firebaseTasks = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('tasks').get();

    final List<TaskModel> mappedTasks = firebaseTasks.docs.map((snap)=> TaskModel.fromJson(snap.data())).toList();
    final taskList = mappedTasks;

     taskList.forEach((task){
      totalTasks +=1;
      task.status == TaskStatus.finished ? finished+=1 : null;
    });

    state = state.copywith(tasksList: taskList,tasksFinished: finished,totalTasks: totalTasks);

     print('LOADED TASKS: $taskList');
  }

  Future<bool> completeTask(
    TaskModel taskModel,
  ) async {
    // final prefs = await SharedPreferences.getInstance();
    final taskList = state.tasksList;

    final int index = taskList.indexWhere((task) => task.id == taskModel.id);
    if(taskList[index].status == TaskStatus.unfinished){
    taskList[index].status = TaskStatus.finished;
    // final stringList =
    //     taskList.map((task) => jsonEncode(task.toJson())).toList();
    // prefs.setStringList(tasksKey, stringList);
    

    final int finished = state.tasksFinished! + 1;
    state = state.copywith(tasksList: taskList,tasksFinished: finished);
    print('Finished Tasks: ${state.finishedTasks}');

    await FirestoreService.completeTask(taskModel);
    // print('Unfinished Tasks: ${state.unfinishedTasks}');
    // print('Total tasks: ${state.totalTasks}');
    return true;
    }
    //TASK HAS ALREADY BEEN COMPLETED BEFORE
    else{
      return false;
    }
  }


  Future<void> reOrder(int oldIndex,int newIndex)async{
    print('dragged');
    final prefs = await SharedPreferences.getInstance();
    final tasklist = state.tasksList;
    final TaskModel taskmodel = tasklist[oldIndex];
    tasklist.removeAt(oldIndex);
    tasklist.insert(newIndex, taskmodel);

    final stringList = tasklist.map((task) => jsonEncode(task.toJson())).toList();

    prefs.setStringList(tasksKey, stringList);
    state = state.copywith(tasksList: tasklist);

  }

}
