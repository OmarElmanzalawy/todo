import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Providers/coin_provider.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/constants/app_constants.dart';
import 'package:todo/service/dialogue_service.dart';
import 'package:todo/service/init_getit.dart';
import 'package:todo/widgets/frosted.dart';

class RewardCard extends ConsumerWidget {
  const RewardCard({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: (){
        getIt<DialogueService>().showAlertDialog(
          context: context,
           actions: [
            TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Cancel')),
            TextButton(onPressed: (){

              //TODO: Redeem reward functionality
              Navigator.pop(context);
              }, child: Text('Ok'))
           ], 
           title: Text('Redeem Reward'), 
           content: Text('Are you sure you want to redeem this reward ?')
           );
      },
      child: Container(
        margin: EdgeInsets.only(right: 18),
        constraints: BoxConstraints(minWidth: size.width * 0.92,minHeight: 75),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(colors: [AppColors.primaryWhiteCard,AppColors.lightGreyBorder])
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Day out with friends',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 8,),
              Wrap(children: [
                Text('Description......',style: AppConstants.thinText.copyWith(color: Colors.grey.shade600),),
              ],),
              SizedBox(height: 12,),
              LinearProgressIndicator(
                color: AppColors.darkestGreen,
                backgroundColor: Colors.white,
                value: 0.6,
              ),
              // SizedBox(height: 15,),
              Row(
                children: [
                  Image.asset('assets/icons/currency.png',width: 20,height: 20,),
                  Text('\t100',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,),),
                  Spacer(),
                  IconButton(icon: Icon(Icons.delete,color: Colors.red,) , onPressed: (){},)
                ],
              )
            ],
          ),
        ),
        
      ),
    );
  }
}