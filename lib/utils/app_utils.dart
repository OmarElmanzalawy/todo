import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Providers/tasks_provider.dart';
import 'package:todo/constants/app_constants.dart';
import 'package:todo/models/task_model.dart';

class AppUtils {

static String timeOfDayToString(TimeOfDay time){
  final bool isPM = time.hour >= 12 ? true:false; 
  final String result;

  return '${isPM ? time.hour -12 : time.hour}:${time.minute} ${isPM ? 'PM': 'AM'}';
}

static TimeOfDay stringToTimeOfDay(String stringTime){
  print(stringTime);

  late final bool isPm;

  if(stringTime.contains('PM')){
    print('pm found');
    isPm = true;
    stringTime = stringTime.replaceAll('PM', '');
  }
  else if(stringTime.contains('AM')){
    isPm = false;
    stringTime = stringTime.replaceAll('AM', '');
  }

  
  final parts = stringTime.split(':');
  print(parts);
  int hour = int.parse(parts[0]);
  print('PM Hour: $hour');
  final int minute = int.parse(parts[1]);

  return TimeOfDay(hour: hour, minute: minute);
}

    //FUNCTION USED TO SERIALIZE TASKSTATUS ENUM INTO AND FROM JSON
  static  TaskStatus? getTaskStatusFromString(String statusAsString) {
      for (TaskStatus element in TaskStatus.values) {
        if (element.toString() == statusAsString) {
          return element;
        }
      }
      return null;
    }

  //Function that sorts task list based on status where unfinished tasks are first
    static List<TaskModel> sortTasks(WidgetRef ref){

    final provider = ref.read(tasksProvider);
    final sortedList = [...provider.unfinishedTasks,...provider.finishedTasks];

    sortedList.forEach((task)=> print(task.status));

    return sortedList;

  }

}