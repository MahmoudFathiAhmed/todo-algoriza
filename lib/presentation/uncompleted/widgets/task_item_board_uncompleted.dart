import 'package:flutter/material.dart';
import 'package:todo_algoriza/core/util/colors.dart';
import 'package:todo_algoriza/core/util/widgets/default_text.dart';

import 'package:todo_algoriza/data/models/task.dart';
import 'package:todo_algoriza/presentation/all/widgets/checked_widget.dart';
import 'package:todo_algoriza/presentation/all/widgets/non_checked_widget.dart';


class TaskItemBoardUnCompleted extends StatelessWidget {
  const TaskItemBoardUnCompleted(this.task, {Key? key, required this.onPressed}) : super(key: key);

  final Task task;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return task.isCompleted == 0 ?Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Row(
              children: [
                task.isCompleted == 0 ?NonCheckedWidget(color: getTaskClr(task.color), onTab: (){}):
                CheckedWidget(color: getTaskClr(task.color), onTab: (){}),
                const SizedBox(width: 20,),
                DefaultText(
                  text:task.title!,
                ),
                const Spacer(),
                IconButton(onPressed: onPressed, icon: const Icon(Icons.more_vert))
              ],
            ),
          ),
        ),
      ],
    ):Container();
  }

  getTaskClr(int? color) {
    switch (color) {
      case 0:
        return redClr;
      case 1:
        return orangeClr;
      case 2:
        return yellowClr;
      default:
        return blueClr;
    }
  }
}