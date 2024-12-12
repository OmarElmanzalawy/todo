import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/constants/app_theme_data.dart';
import 'package:todo/screens/auth/sign_in_screen.dart';
import 'package:todo/screens/auth/sign_up_screen.dart';
import 'package:todo/screens/auth/social_auth_details_screen.dart';
import 'package:todo/screens/rewards_screen.dart';
import 'package:todo/screens/splash_screen.dart';
import 'package:todo/screens/dashboard.dart';
import 'package:todo/screens/todo.dart';
import 'package:todo/service/startup_service.dart';

void main() async{
  
  //TODO: ADD A GLOBAL CLASS WHERE EVERY CLASS GETS INITIALIZED
  await StartupService.init();
  //await FirebaseAuth.instance.signOut(); //FOR DEBUGING ONLY
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: FirebaseAuth.instance.currentUser == null  ? '/splash' : '/dashboard',
      initialRoute: '/rewards',
      routes: {
        '/dashboard': (context) => DashBoardScreen(),
        '/todo': (context) =>TodoScreen(),
        '/splash': (context) => SplashScreen(),
        '/signin': (context) => SignInScreen(),
        '/signup': (context) => SignUpScreen(),
        '/rewards': (context) => RewardsScreen(),
      },

      theme: AppThemeData.mainTheme,

    );
  }
}
