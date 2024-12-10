import 'package:flutter/material.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/service/auth_service.dart';
import 'package:todo/service/dialogue_service.dart';
import 'package:todo/service/init_getit.dart';
import 'package:todo/widgets/auth/titled_textfield.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              'Sign In',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkestGreen),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'Welcome Back You have been missed!',
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w200),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TitledTextField(
                  title: 'Email',
                  hint: 'enter your email',
                  controller: _emailcontroller,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TitledTextField(
                  title: 'Password',
                  hint: 'enter your password',
                  controller: _passwordcontroller,
                  isSensitive: true,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'OR',
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('assets/icons/apple.png')),
              ),
              InkWell(
                onTap: () async => await AuthService.signInWithGoogle(context),
                child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('assets/icons/google.png')),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 90.0),
            child: ElevatedButton(
              onPressed: () async{
                print('login');
                final bool didLogin = await AuthService.login(email: _emailcontroller.text, password: _passwordcontroller.text);
                if(didLogin){
                  Navigator.pushNamed(context, '/dashboard');
                }
                else{getIt<DialogueService>().showSnackbar(text: 'Error occured. Please try again', context: context);}
              },
              style: ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.all(12)),
                backgroundColor: WidgetStatePropertyAll(AppColors.darkGreen),
                foregroundColor: WidgetStatePropertyAll(AppColors.primaryText),
                splashFactory: NoSplash.splashFactory,
              ),
              child: Container(
                constraints: BoxConstraints(minWidth: size.width * 0.85),
                decoration: BoxDecoration(
                  color: AppColors.darkGreen,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Don\' have an account?'),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text('Register'),
                style: ButtonStyle(
                    foregroundColor:
                        WidgetStatePropertyAll(AppColors.darkGreen),
                    splashFactory: NoSplash.splashFactory),
              )
            ],
          ),
        ],
      ),
    );
  }
}
