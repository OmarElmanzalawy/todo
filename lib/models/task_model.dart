class TaskModel {

  final String title;
  final bool? status;
  final String? description;
  final DateTime? deadline;

  TaskModel({required this.title, this.status, this.description, this.deadline});

}