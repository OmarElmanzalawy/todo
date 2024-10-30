import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Providers/tasks_provider.dart';
import 'package:todo/service/init_getit.dart';

class StartupService {

static void init(){

  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  
}

static Future loadLocalData(WidgetRef ref)async{
  Future.microtask(()async{
  print('microtasking');
  //await ref.read(tasksProvider.notifier).clearTasks();
  await ref.read(tasksProvider.notifier).loadTasks();

  });
  
}

}