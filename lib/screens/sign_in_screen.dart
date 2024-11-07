import 'package:flutter/material.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/widgets/auth/titled_textfield.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final TextEditingController _emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: TitledTextField(hint: 'test', controller: _emailcontroller),
          )
        ],
      )
    );
  }
}