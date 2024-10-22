import 'package:flutter/material.dart';
import 'package:todo/constants/app_colors.dart';

class RoundedCard extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Widget? child;
  final BorderRadius? borderRadius;

  const RoundedCard(
      {super.key,
      this.width,
      this.height,
      this.backgroundColor,
      this.child,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 100,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.lightGreen,
          borderRadius: borderRadius ??
              const BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35))),
      child: child,
    );
  }
}