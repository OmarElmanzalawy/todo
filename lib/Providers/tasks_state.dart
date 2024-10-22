import 'package:todo/models/task_model.dart';

class TasksState {

  final List<TaskModel> tasksList;

  TasksState({this.tasksList = const []});

  TasksState copywith({
    List<TaskModel>? tasksList,
  })
  {
    return TasksState(tasksList: tasksList ?? this.tasksList);
  }

}