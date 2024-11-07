import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/constants/app_constants.dart';

class SplashItem extends StatelessWidget {
  const SplashItem({super.key, required this.animationPath, required this.title, required this.subtitle});

  final String animationPath;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Lottie.asset(
            'assets/animations/$animationPath',
            fit: BoxFit.contain
            )),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Text(title,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: AppConstants.splashItemTitleStyle,
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(subtitle,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey.shade600,
                  
                ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
