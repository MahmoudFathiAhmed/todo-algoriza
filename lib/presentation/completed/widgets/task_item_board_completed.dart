import 'package:flutter/material.dart';
import 'package:todo_algoriza/core/util/colors.dart';
import 'package:todo_algoriza/core/util/widgets/default_text.dart';

import 'package:todo_algoriza/data/models/task.dart';
import 'package:todo_algoriza/presentation/all/widgets/checked_widget.dart';
import 'package:todo_algoriza/presentation/all/widgets/non_checked_widget.dart';


class TaskItemBoardCompleted extends StatelessWidget {
  const TaskItemBoardCompleted(this.task, {Key? key, required this.onPressed}) : super(key: key);

  final Task task;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return task.isCompleted == 1 ?Row(
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
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       task.title!,
            //       style: const TextStyle(
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.white,
            //       ),
            //     ),
            //     const SizedBox(height: 12),
            //     Row(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Icon(
            //           Icons.access_time_rounded,
            //           color: Colors.grey[200],
            //           size: 18,
            //         ),
            //         const SizedBox(width: 12),
            //         Text(
            //           '${task.startTime} - ${task.endTime}',
            //           style: TextStyle(
            //             fontSize: 13,
            //             color: Colors.grey[100],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
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