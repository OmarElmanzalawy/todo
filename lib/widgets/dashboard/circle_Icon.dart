
import 'package:flutter/material.dart';
import 'package:todo/constants/app_icons.dart';

class CircleIcon extends StatelessWidget {
  final double? width;
  final double? height;
  final IconData icon;
  final double? iconSize;
  final Color? backgroundColor;
  const CircleIcon({super.key, this.width, this.height, required this.icon, this.iconSize, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
              width: width ?? 40,
              height: height ?? 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: backgroundColor ?? Colors.white10
              ),
              child: Icon(icon),
            );
  }
}