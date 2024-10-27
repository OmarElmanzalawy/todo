import 'package:flutter/material.dart';

class TaskModel {

  final String title;
  final bool? status;
  final String? description;
  final TimeOfDay? deadline;
  //WILL CAUSE PROBLEMS LATER
  final UniqueKey id = UniqueKey();

  TaskModel({required this.title, this.status, this.description, this.deadline,});

  factory TaskModel.fromJson(Map<String,dynamic> json){
    return TaskModel(
      title: json['title'],
      status: json['status'] ?? false,
      deadline: json['deadline'],
      description: json['description'] ?? '',      
    );
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = Map<String,dynamic>();
    data['title'] = title;
    data['status'] = status ?? false;
    data['deadline'] = deadline;
    data['description'] = description;

    return data;
  }

}