import 'package:flutter/material.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/widgets/todo/confirm_box.dart';
import 'package:todo/widgets/todo/mytextfield.dart';

class CreateTaskDialog extends StatelessWidget {
  const CreateTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
                       return Container(
                    height: 250,
                    color: AppColors.primaryText,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListView(
                        children: [
                          Column(
                          children: [
                            Mytextfield(hintText: 'Task Name',),
                            Mytextfield(hintText: 'Description',fontSize: 16,textColor: AppColors.subtitleText,),
                            SizedBox(height: 60,),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: ConfirmBox(),
                              ),
                            )

                          ],
                        ),
                        ],
                      ),
                    ),
                  );
  }
}