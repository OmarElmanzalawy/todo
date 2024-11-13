import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/constants/app_theme_data.dart';
import 'package:todo/screens/sign_in_screen.dart';
import 'package:todo/screens/sign_up_screen.dart';
import 'package:todo/screens/splash_screen.dart';
import 'package:todo/screens/dashboard.dart';
import 'package:todo/screens/todo.dart';
import 'package:todo/service/startup_service.dart';

void main() {
  
  //TODO: ADD A GLOBAL CLASS WHERE EVERY CLASS GETS INITIALIZED
  StartupService.init();
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',

      routes: {
        '/dashboard': (context) => DashBoardScreen(),
        '/todo': (context) =>TodoScreen(),
        '/splash': (context) => SplashScreen(),
        '/signin': (context) => SignInScreen(),
        '/signup': (context) => SignUpScreen(),
      },

      theme: AppThemeData.mainTheme,

    );
  }
}
