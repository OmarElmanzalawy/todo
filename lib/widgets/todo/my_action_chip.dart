import 'package:flutter/material.dart';
import 'package:todo/constants/app_icons.dart';

class MyActionChip extends StatelessWidget {
  const MyActionChip({super.key, this.backgroundColor, required this.label, this.icon, this.onpressed});

  final Color? backgroundColor;
  final Widget label;
  final Icon? icon;
  final VoidCallback? onpressed;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: label ?? Text('Deadline?'),
      backgroundColor: backgroundColor ?? Colors.grey.shade100,
      avatar: icon ?? Icon(AppIcons.alarm,color: Colors.black),
      side: BorderSide.none,
      //surfaceTintColor: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: onpressed,
    );
  }
}