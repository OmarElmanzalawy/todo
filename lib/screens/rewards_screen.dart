import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Providers/profile_pic_url_provider.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/constants/app_constants.dart';
import 'package:todo/constants/app_icons.dart';
import 'package:todo/widgets/reward/reward_card.dart';

class RewardsScreen extends ConsumerWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final profileUrl = ref.watch(profilePicUrlProvider);
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: size.height * 0.35,
                decoration: BoxDecoration(
                  color: AppColors.darkGreen,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                SafeArea(
                  child: profileUrl != null ? Container(
                  
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(profileUrl),fit: BoxFit.cover),
                    shape: BoxShape.circle
                  ),
                                            ) :  CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: 
                   Icon(Icons.account_circle,
                      size: 45, color: AppColors.primaryText) 
                      
                  ),
                ),
                Text('Rewards',style: TextStyle(fontSize: 30,color: AppColors.primaryWhiteCard,fontWeight: FontWeight.bold),),
                SizedBox(height: 25,),
                  Container(
                    width: size.width * 0.92,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.primaryWhiteCard,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          width: 60,
                          height: 60,
                          child: Image.asset('assets/icons/currency.png'),
                        ),
                        SizedBox(width: 15,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('320',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                            Text('Available Points',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
                          ],
                        )
                      ],
                    ),
                  ),
                            ],
                          ),
              )
            ]
          ),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('All Rewards',style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
                    Spacer(),
                     Padding(
                       padding: const EdgeInsets.only(right: 17.0),
                       child: ElevatedButton(
                        onPressed: () {
                          print('clicked');
                        },
                        style: ButtonStyle(
                            splashFactory: NoSplash.splashFactory,
                            backgroundColor: WidgetStatePropertyAll(
                                AppColors.darkGreen.withOpacity(0.7)),
                            textStyle: WidgetStatePropertyAll(
                                TextStyle(color: AppColors.primaryText)),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            )),
                        child: GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Icon(
                                AppIcons.plus,
                                color: AppColors.primaryText,
                              ),
                              Text(
                                'Add Reward',
                                style: TextStyle(color: AppColors.primaryText),
                              ),
                            ],
                          ),
                        ),
                        ),
                     ),
                  ],
                ),
                SizedBox(height: 10,),
                RewardCard(),
              ],
            ),
          )
        ],
      ),
    );
  }
}