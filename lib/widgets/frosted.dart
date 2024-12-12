import 'dart:ui';

import 'package:flutter/material.dart';

//MAKE SURE THAT CHILD HAS A COLOR WITH LOW OPACITY FOR THE EFFECT TO WORK

class Frosted extends StatelessWidget {
  const Frosted({super.key, required this.child});

  final Container child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30,sigmaY: 30),
            child: child,
          ),
      ),
      ]
    );
  }
}