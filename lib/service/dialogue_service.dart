import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';

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
}
