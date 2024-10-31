import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Providers/tasks_provider.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/constants/app_constants.dart';
import 'package:todo/constants/app_icons.dart';
import 'package:todo/models/task_model.dart';

class TaskCircle extends ConsumerStatefulWidget {
  const TaskCircle({super.key,required this.taskmodel});

  //TODO MAKE IT REQUIRED LATER
  final TaskModel taskmodel;

  @override
  ConsumerState<TaskCircle> createState() => _TaskCircleState();
}

class _TaskCircleState extends ConsumerState<TaskCircle> with SingleTickerProviderStateMixin {

  late final AnimationController _controller;
  late Animation _colorAnimation;

  @override
  void initState() {
    _controller = AnimationController(duration: Duration(milliseconds: 500),vsync: this);

    _colorAnimation = ColorTween(begin: AppColors.primaryText, end: AppColors.darkGreen)
    .animate(_controller);

    _controller.addListener((){
      print(_colorAnimation.value);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    print('disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(tasksProvider);
    return InkWell(
      onTap: ()async{
        ref.read(tasksProvider.notifier).completeTask(widget.taskmodel);
        _controller.forward();
        Future.delayed(const Duration(seconds: 1),(){
          //IMPLEMENT ANIMATION THEN DELETE TASK
          print('deleted after 2 seconds');
          ref.read(tasksProvider.notifier).deleteTask(widget.taskmodel);
        });
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.lightGreyBorder),
            shape: BoxShape.circle,
            color: _colorAnimation.value
          ),
          child: widget.taskmodel.status == TaskStatus.finished ?  Icon(AppIcons.tick,color: AppColors.primaryText,) : null
        );
        },
      ),
    );
  }
}