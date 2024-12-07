
import 'package:flutter/material.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/widgets/todo/task_widget.dart';

class AnimatedlistUtils {


static void onCompleteAdd({required GlobalKey<AnimatedListState> key,required List<TaskModel> completedList,required TaskModel task}){
  completedList = [...completedList, task];
  key.currentState!.insertItem(
    0,
    duration: const Duration(milliseconds: 500)
  );
}

static void onCompleteDelete({required GlobalKey<AnimatedListState> key, required TaskModel task,required int index}){
  key.currentState!.removeItem(
  index,
  (_,animation){
    return SizeTransition(
      sizeFactor: animation,
      child: TaskWidget(taskModel: task),
      );
    
  },
  duration: const Duration(milliseconds: 500),
  );

  }
}