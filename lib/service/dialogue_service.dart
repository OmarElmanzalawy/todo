import 'package:flutter/material.dart';
import 'package:todo/constants/app_colors.dart';

class DialogueService {
  late GlobalKey<NavigatorState> dialogueKey;

  DialogueService() {
    dialogueKey = GlobalKey<NavigatorState>();
  }

  Future<void> showAlertDialog({required BuildContext context ,required List<Widget>? actions,required Widget title,required Widget content}) async {
    await showAdaptiveDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => AlertDialog.adaptive(
          title: title,
          content: content,
          actions: actions,
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

void showSnackbar({SnackBar? customSnackBar,required String text,required context}){

  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  final snackBar = SnackBar(
    content: Text(text,style: TextStyle(color: Colors.white),),
    backgroundColor: AppColors.darkGreen,
    );
  ScaffoldMessenger.of(context).showSnackBar(customSnackBar ?? snackBar);
}

}