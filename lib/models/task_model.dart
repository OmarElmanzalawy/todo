import 'package:flutter/material.dart';

class TaskModel {

  final String title;
  final bool? status;
  final String? description;
  final DateTime? deadline;
  final UniqueKey id = UniqueKey();

  TaskModel({required this.title, this.status, this.description, this.deadline});

  

}