import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Providers/tasks_provider.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/constants/app_constants.dart';
import 'package:todo/constants/app_icons.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/service/dialogue_service.dart';
import 'package:todo/service/init_getit.dart';

class TaskCircle extends ConsumerStatefulWidget {
  const TaskCircle({super.key,required this.taskmodel,this.animatedlistKey,this.indexForDeletion});

  //TODO MAKE IT REQUIRED LATER
  final TaskModel taskmodel;
  final GlobalKey<AnimatedListState>? animatedlistKey;
  //Index of task to be deleted
  final int? indexForDeletion;

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

    super.initState();

    _controller.addListener((){
      print('Animation started for: ${widget.taskmodel.title}');
    });

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
    return GestureDetector(
      onTap: ()async{
        print('circle tap: ${widget.taskmodel.title}');
        final bool isfalse = await ref.read(tasksProvider.notifier).completeTask(widget.taskmodel);
        _controller.forward();
        if(isfalse){
        }
        //Checks if task has been completed before
        if(!isfalse){ 
          getIt<DialogueService>().showSnackbar(text: 'Task is already completed',context: context);
           print('task already completed');
        }

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
            color: widget.taskmodel.status == TaskStatus.finished ? AppColors.darkGreen :_colorAnimation.value
          ),
          child: widget.taskmodel.status == TaskStatus.finished ?  Icon(AppIcons.tick,color: AppColors.primaryText,) : null
        );
        },
      ),
    );
  }
}