import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';
import 'package:todo/constants/app_colors.dart';

class DialogueService {
  late GlobalKey<NavigatorState> dialogueKey;

  DialogueService() {
    dialogueKey = GlobalKey<NavigatorState>();
  }

  Future<void> showDialog(Widget widget,BuildContext context) async {
    await showAdaptiveDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => FluidDialog(
            rootPage: FluidDialogPage(
                alignment: Alignment.center,
                builder: (context) {
                  return widget;
                })));
  }
  Future<void> showAlertDialog(Widget widget,BuildContext context) async {
    await showAdaptiveDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => AlertDialog.adaptive(
          title: Text('Delete'),
          content: Text('Are you sure you want to delete this task'),
          actions: [Text('Yes'),Text('No')],
        ));
  }

  Future<void> showBottomSheet(Widget widget, BuildContext context)async{
  return await showModalBottomSheet(
    backgroundColor: AppColors.primaryText,
    //barrierLabel: 'Add Task',
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
    context: context, 
    builder: (context)=> widget
    );
}
}