import 'package:flutter/material.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/widgets/glass_morphism.dart';

class RewardCard extends StatelessWidget {
  const RewardCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GlassMorphism(
      blur: 12,
      opacity: 0.1,
      color: Colors.blue,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: EdgeInsets.only(right: 18),
        constraints: BoxConstraints(minWidth: size.width * 0.92,minHeight: 75),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Day out with friends',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 8,),
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