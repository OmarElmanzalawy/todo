import 'package:flutter/material.dart';
import 'package:todo/constants/app_constants.dart';

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


  

}