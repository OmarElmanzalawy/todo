import 'package:flutter/material.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/constants/app_constants.dart';
import 'package:todo/constants/app_icons.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/widgets/todo/task_widget.dart';

class TodoScreen extends StatelessWidget {
  TodoScreen({super.key});

  //You will get these from firestore db when we integrate it
  List<TaskModel> tasks = [
    TaskModel(title: 'Finish Website'),
    TaskModel(title: 'Pray'),
    TaskModel(title: 'Continue Flutter Course',description: '2 hours of focuesd deep work with no interruptions',deadline: DateTime.now()),
    TaskModel(title: 'Skincare'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              //TODO ADD SOME KIND OF BACKGROUND WITH A BLUR EFFECT (IDEA)
            ),
            Row(
              children: [
                Text(
                  'Today\'s Task',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {print('clicked');},
                  style: ButtonStyle(
                    splashFactory: NoSplash.splashFactory,
                    backgroundColor: WidgetStatePropertyAll(AppColors.darkGreen.withOpacity(0.5)),
                    textStyle: WidgetStatePropertyAll(TextStyle(color: AppColors.primaryText)),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    )
                  ),
                  child: Row(
                    children: [Icon(AppIcons.plus,color: AppColors.primaryText,), Text('New Task',style: TextStyle(color: AppColors.primaryText),)],
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                    child: TaskWidget(taskModel: tasks[index],),
                  );
                }
                )
              ),
          ],
        ),
      ),
    );
  }
}
