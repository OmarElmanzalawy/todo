import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Providers/image_picker_provider.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/widgets/auth/titled_textfield.dart';

class SignUpScreen extends ConsumerWidget {
  SignUpScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final profilePhoto = ref.watch(imagePickerProvider);
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Text(
            'Sign Up',
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                color: AppColors.darkestGreen),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 25,
          ),
                    Stack(
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: profilePhoto != null ? FileImage(profilePhoto) : NetworkImage('https://thumbs.dreamstime.com/b/default-profile-picture-avatar-photo-placeholder-vector-illustration-default-profile-picture-avatar-photo-placeholder-vector-189495158.jpg'),
              ),
              Positioned(
                //top: 150,
                bottom: 0,
                left: 70,
                child: Container(
                  height: 50,
                  child: IconButton(
                    icon: Icon(Icons.add_a_photo,color: Colors.white,),
                    onPressed: (){
                      ref.read(imagePickerProvider.notifier).pickImage();
                    }, 
                    ),
                  decoration: BoxDecoration(
                    color:  AppColors.darkGreen, //Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
              )
            ],
          ),
          Column(
            children: [
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TitledTextField(
                  title: 'User Name',
                  hint: 'enter your username',
                  controller: _emailController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TitledTextField(
                  title: 'Email',
                  hint: 'enter your email',
                  controller: _emailController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TitledTextField(
                  title: 'Password',
                  hint: 'enter your password',
                  controller: _passwordController,
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
            height: 15,
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
              GestureDetector(
                child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('assets/icons/google.png')),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: ElevatedButton(
              onPressed: () {
                print('Sign in');
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
                  'Submit',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Already have an account?'),
              TextButton(
                onPressed: () {},
                child: Text('Login'),
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