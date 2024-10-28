import 'package:flutter/material.dart';
import 'package:todo/constants/app_colors.dart';

class Mytextfield extends StatelessWidget {
  const Mytextfield({super.key, required this.hintText,this.fontSize,this.textColor,this.controller});
  final String hintText;
  final double? fontSize;
  final Color? textColor;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width,
      //color: Colors.red,
      child: TextField(
        maxLines: 2,
        showCursor: false,
        controller: controller,
        cursorColor: AppColors.fadedBlack,
        style: TextStyle(fontSize: fontSize ??25,color: textColor),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: textColor),
          hintText: hintText,
        ),
        onChanged: (value) {
          //print(value);
        },
      ),
    );
  }
}