import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/constants/app_constants.dart';
import 'package:todo/utils/app_utils.dart';
import 'package:uuid/uuid.dart';



class TaskModel {
  final String title;
  TaskStatus status;
  final String? description;
  final TimeOfDay? deadline;
  //WILL CAUSE PROBLEMS LATER
  final String id;

  TaskModel( 
    {
    required this.id,
    required this.title,
    this.status = TaskStatus.unfinished,
    this.description,
    this.deadline,
  }); 


  factory TaskModel.fromJson(Map<String, dynamic> json, String id) {
    print('Dedline: ${json['deadline']}');
    return TaskModel(
      id: json['id'],
      title: json['title'],
      status:  AppUtils.getTaskStatusFromString(json['status'])!,
      deadline: json['deadline'] != null ? AppUtils.stringToTimeOfDay(json['deadline']): null,
      description: json['description'] ?? '',
    );
  }

    factory TaskModel.fromSnap(DocumentSnapshot snap, String id) {
      Map<String, dynamic> snapshot = snap.data() as Map<String,dynamic>;
    print('Dedline: ${snapshot['deadline']}');
    return TaskModel(
      id: snapshot['id'],
      title: snapshot['title'],
      status:  AppUtils.getTaskStatusFromString(snapshot['status'])!,
      deadline: snapshot['deadline'] != null ? AppUtils.stringToTimeOfDay(snapshot['deadline']): null,
      description: snapshot['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['status'] = status.toString();
    data['deadline'] = deadline != null ? AppUtils.timeOfDayToString(deadline!): null;
    data['description'] = description;

    return data;
  }
}
