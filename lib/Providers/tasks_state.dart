import 'package:flutter/material.dart';
import 'package:todo/constants/app_constants.dart';
import 'package:todo/models/task_model.dart';

class TasksState {
  final List<TaskModel> tasksList;
  List<TaskModel> unfinishedTasks;
  List<TaskModel> finishedTasks;
  int? tasksFinished;
  int? totalTasks;

  TasksState(
      {this.tasksList = const [],
      this.tasksFinished,
      this.totalTasks,
      this.finishedTasks = const [],
      this.unfinishedTasks = const []}){
        assignTaskState();

      }

  //Function that takes tasksList and assign task based on status
  //Which is finished and which is not
  void assignTaskState() {
    print('Custom Function');
    unfinishedTasks = tasksList
        .where((task) => task.status == TaskStatus.unfinished)
        .toList();
        print('Inside Function Unfinished: $unfinishedTasks');
    finishedTasks =
        tasksList.where((task) => task.status == TaskStatus.finished).toList();
  }



  TasksState copywith(
      {List<TaskModel>? tasksList, int? tasksFinished, int? totalTasks}) {
    //Asign finished and unfinshed tasks function

    
    return TasksState(
      tasksList: tasksList ?? this.tasksList,
      tasksFinished: tasksFinished ?? this.tasksFinished,
      totalTasks: totalTasks ?? this.tasksList.length,
      unfinishedTasks: this.unfinishedTasks,
      finishedTasks: this.finishedTasks
    );
    
  }
}
