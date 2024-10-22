import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Providers/tasks_provider.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/constants/app_constants.dart';
import 'package:todo/constants/app_icons.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/service/dialogue_service.dart';
import 'package:todo/service/init_getit.dart';
import 'package:todo/widgets/dialogs/create_task_dialog.dart';
import 'package:todo/widgets/todo/confirm_box.dart';
import 'package:todo/widgets/todo/mytextfield.dart';
import 'package:todo/widgets/todo/task_widget.dart';

class TodoScreen extends ConsumerWidget {
  TodoScreen({super.key});


  //You will get these from firestore db when we integrate it
  
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //TODO: DISPLAY DIALOGUE
          getIt<DialogueService>().showDialog(CreateTaskDialog(),context);
        },
        backgroundColor: AppColors.floatingButton,
        foregroundColor: Colors.white,
        child: Icon(AppIcons.plus,size: 30,),
        ),
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
                itemCount: tasks.tasksList.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                    child: TaskWidget(taskModel: tasks.tasksList[index],),
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
