import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Providers/tasks_provider.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/service/init_getit.dart';

class StartupService {

static Future init()async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  print('Firebase Initialized');
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