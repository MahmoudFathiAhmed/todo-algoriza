import 'package:flutter/material.dart';

import 'package:todo_algoriza/core/util/colors.dart';

import 'package:todo_algoriza/data/models/task.dart';


class TaskItem extends StatelessWidget {
  const TaskItem(this.task, {Key? key}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: getTaskClr(task.color),
        ),
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${task.startTime}',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[100],
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      task.title!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10,),
            task.isCompleted == 0 ?const Icon(Icons.circle_outlined,color: Colors.white,):
            const Icon(Icons.check_circle_outlined,color: Colors.white,),
          ],
        ),
      ),
    );
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