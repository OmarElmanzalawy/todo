import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Providers/tasks_provider.dart';
import 'package:todo/constants/app_theme_data.dart';
import 'package:todo/screens/dashboard.dart';
import 'package:todo/screens/todo.dart';
import 'package:todo/service/init_getit.dart';
import 'package:todo/service/storage_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  //TODO: ADD A GLOBAL CLASS WHERE EVERY CLASS GETS INITIALIZED
  /*final initProvider = FutureProvider.autoDispose((ref) async{
    ref.keepAlive();
    await Future.microtask(()async{
      await ref.read(tasksProvider.notifier).loadTasks();
    }
    );
  },);*/
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/dashboard',

      routes: {
        '/dashboard': (context) => DashBoardScreen(),
        '/todo': (context) =>TodoScreen(),
      },

      theme: AppThemeData.mainTheme,

    );
  }
}
