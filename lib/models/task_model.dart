import 'package:flutter/material.dart';
import 'package:todo/constants/app_constants.dart';
import 'package:todo/utils/app_utils.dart';

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


    print('Dedline: ${json['deadline']}');
    return TaskModel(
      title: json['title'],
      status:  AppUtils.getTaskStatusFromString(json['status'])!,
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
