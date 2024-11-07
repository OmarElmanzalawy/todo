import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Providers/splash_dot_index_notifier.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/widgets/splash/splash_btn.dart';
import 'package:todo/widgets/splash/splash_item.dart';

class SplashScreen extends ConsumerWidget {
  SplashScreen({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(dotIndexProvider);
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          //color: Colors.red,
          height: size.height * 0.75,
          child: PageView(
            controller: _pageController,
            onPageChanged: (value) =>
                ref.read(dotIndexProvider.notifier).changeIndex(value),
            children: [
              SplashItem(
                title: 'Stay Organized, Achieve More!',
                animationPath: 'task-organization.json',
                subtitle:
                    'Track your tasks and deadlines in one place. Your goals are within reach when you\'re organized!',
              ),
              SplashItem(
                title: 'Complete Tasks, Earn Rewards!',
                animationPath: 'earn-rewards.json',
                subtitle:
                    'Every task you complete earns you in-app currency, which can be redeemed for rewards you create. Get motivated to accomplish more!',
              ),
              SplashItem(
                title: 'Customize Your Goals!',
                animationPath: 'task-organization.json',
                subtitle:
                    'Set personal rewards and track your progress towards achieving them. With every completed task, you\'re one step closer.',
              ),
              SplashItem(
                title: 'Your Productivity Companion',
                animationPath: 'task-organization.json',
                subtitle:
                    'From to-do lists to motivational rewards, this app is designed to help you stay productive and inspired',
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 70),
          child: DotsIndicator(
            position: index,
            dotsCount: 4,
            decorator: DotsDecorator(
              color: AppColors.darkGreen,
              activeColor: AppColors.lightGreen,
              size: Size.square(9),
              activeSize: Size(24, 8),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: SplashButton(
              isfinalIndex: index == 3 ? true : false,
              ontap: () {
                  if(index<3){
                  ref.read(dotIndexProvider.notifier).changeIndex(index + 1,pagecontroller: _pageController);
                  }
                  else{
                    Navigator.pushNamed(context, '/signin');
                  }
              }
            ))
      ],
    ));
  }
}
