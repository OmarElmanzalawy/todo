import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/constants/app_constants.dart';
import 'package:todo/constants/app_icons.dart';
import 'package:todo/constants/app_theme_data.dart';
import 'package:todo/service/startup_service.dart';
import 'package:todo/utils/clippers/rounded_clipper.dart';
import 'package:todo/widgets/dashboard/circle_Icon.dart';
import 'package:todo/widgets/dashboard/dash_task.dart';
import 'package:todo/widgets/dashboard/rounded_card.dart';

class DashBoardScreen extends ConsumerStatefulWidget {
  const DashBoardScreen({super.key});

  @override
  ConsumerState<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends ConsumerState<DashBoardScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StartupService.loadLocalData(ref);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Theme(
      data: AppThemeData.greenTheme,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [AppColors.darkGreen, AppColors.darkestGreen])),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,bottom: 20,top: 50),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: 
                          Icon(Icons.account_circle,
                              size: 50, color: AppColors.primaryText),
                        ),
                        Spacer(),
                        CircleIcon(icon: AppIcons.notifications_outline),
                        SizedBox(
                          width: 5,
                        ),
                        CircleIcon(icon: AppIcons.plus),
                        SizedBox(
                          width: 15,
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    height: size.height * 0.29,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 15.0, top: 30, bottom: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello, Joseph',
                            style: TextStyle(color: AppColors.lightGreen),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text('Good Morning,\nTime To Work!',
                                style: AppConstants.h1Text),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: RoundedCard(
                      height: size.height * 0.31,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'MONDAY',
                              style: AppConstants.thinText,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Text(
                                    '11:48\n\tJAN',
                                    style: AppConstants.h1Text.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 65,
                                        letterSpacing: 0,
                                        height: 1),
                                  ),
                                  //SizedBox(width: 20),
                                  const VerticalDivider(
                                    color: Colors.black38,
                                  ),
                                  const IntrinsicWidth(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'FINISHED TASKS',
                                            style: AppConstants.thinText,
                                          ),
                                          Text('4 tasks'),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Divider(
                                              color: Colors.black38,
                                            ),
                                          ),
                                          Text(
                                            'UNFINISHED TASKS',
                                            style: AppConstants.thinText,
                                          ),
                                          Text('8 tasks'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: RoundedCard(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                backgroundColor: AppColors.primaryText,
                height: size.height * 0.34,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Today Tasks',
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/todo');
                            },
                            child: const Row(
                              children: [
                                Text(
                                  'View All',
                                  style:
                                      TextStyle(color: AppColors.subtitleText),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Icon(
                                  AppIcons.nextArrow,
                                  color: AppColors.subtitleText,
                                  size: 12,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Container(
                          color: Colors.transparent,
                          height: 180,
                          child: CarouselView(
                            elevation: 1,
                            itemSnapping: true,
                            itemExtent: MediaQuery.sizeOf(context).width - 80,
                            children: List.generate(10, (int index) {
                              return const DashTask();
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
