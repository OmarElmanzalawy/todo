import 'package:flutter/material.dart';
import 'package:todo/models/task_model.dart';

class TasksState {

  final List<TaskModel> tasksList;
  int? tasksFinished;
  int? totalTasks;

  TasksState({this.tasksList = const [],this.tasksFinished,this.totalTasks});

  TasksState copywith({
    List<TaskModel>? tasksList,
    int? tasksFinished,
    int? totalTasks
  })
  {
    return TasksState(tasksList: tasksList ?? this.tasksList,
    tasksFinished: tasksFinished ?? this.tasksFinished, 
    totalTasks: totalTasks ?? this.tasksList.length, 
    );
  }

}