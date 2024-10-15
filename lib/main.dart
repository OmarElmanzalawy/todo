import 'package:flutter/material.dart';
import 'package:todo/constants/app_theme_data.dart';
import 'package:todo/screens/dashboard.dart';

void main() {
  runApp(const MainApp());
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
      },

      theme: AppThemeData.mainTheme,

    );
  }
}
