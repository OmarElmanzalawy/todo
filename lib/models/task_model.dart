import 'package:flutter/material.dart';
import 'package:todo/Providers/tasks_provider.dart';
import 'package:todo/constants/app_constants.dart';
import 'package:todo/utils/clippers/app_utils.dart';

class TaskModel {
  final String title;
  TaskStatus status;
  final String? description;
  final TimeOfDay? deadline;
  //WILL CAUSE PROBLEMS LATER
  final UniqueKey id = UniqueKey();

  TaskModel({
    required this.title,
    this.status = TaskStatus.unfinished,
    this.description,
    this.deadline,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    //FUNCTION USED TO SERIALIZE TASKSTATUS ENUM INTO AND FROM JSON
    TaskStatus? getTaskStatusFromString(String statusAsString) {
      for (TaskStatus element in TaskStatus.values) {
        if (element.toString() == statusAsString) {
          return element;
        }
      }
      return null;
    }

    print('Dedline: ${json['deadline']}');
    return TaskModel(
      title: json['title'],
      status: getTaskStatusFromString(json['status'])!,
      deadline: json['deadline'] != null ? AppUtils.stringToTimeOfDay(json['deadline']): null,
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['status'] = status.toString();
    deadline != null ? data['deadline'] = AppUtils.timeOfDayToString(deadline!): null;
    data['description'] = description;

    return data;
  }
}
