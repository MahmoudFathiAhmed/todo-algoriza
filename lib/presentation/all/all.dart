import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_algoriza/controller/task_controller.dart';
import 'package:todo_algoriza/core/util/colors.dart';
import 'package:todo_algoriza/core/util/widgets/default_button.dart';

import 'package:todo_algoriza/data/models/task.dart';
import 'package:todo_algoriza/presentation/add_task/add_task.dart';
import 'package:todo_algoriza/presentation/all/widgets/task_item_board.dart';
import 'package:todo_algoriza/services/alarm.dart';

class All extends StatefulWidget {
  const All({Key? key}) : super(key: key);

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  late Alarm alarm;
  @override
  void initState() {
    super.initState();
    alarm = Alarm();
    alarm.requestIOSPermissions();
    alarm.initializeNotification();
    taskController.getTasks();
  }

  DateTime selectedDate = DateTime.now();
  final TaskController taskController = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 300,
            child: Column(
              children: [
                showTasks(),
                // Row(
                //   children: [
                //     CheckedWidget(color: redClr, onTab: () {},),
                //     const SizedBox(width: 20,),
                //     const DefaultText(
                //       text:'Design team meeting',
                //     ),
                //     const Spacer(),
                //     IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert))
                //   ],
                // ),
                // const SizedBox(height: 20,),
                // Row(
                //   children: [
                //     NonCheckedWidget(color: orangeClr, onTab: () {},),
                //     const SizedBox(width: 20,),
                //     const DefaultText(
                //       text:'Making wireframes',
                //     ),
                //     const Spacer(),
                //     IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert))
                //   ],
                // ),
              ],
            ),
          ),
          DefaultButton(text: 'Add Task', onclick: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const AddTask()));
          }),
        ],
      ),
    );
  }
  showTasks() {
    return Expanded(
      child: Obx(() {
        if (taskController.taskList.isEmpty) {
          return _noTaskMsg();
        } else {
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                var task = taskController.taskList[index];
                if (task.repeat == 'Daily' ||
                    task.date == DateFormat.yMd().format(selectedDate) ||
                    (task.repeat == 'Weekly' &&
                        selectedDate
                            .difference(
                            DateFormat.yMd().parse(task.date!))
                            .inDays %
                            7 ==
                            0) ||
                    (task.repeat == 'Monthly' &&
                        DateFormat.yMd().parse(task.date!).day ==
                            selectedDate.day)) {
                  var date = DateFormat.jm().parse(task.startTime!);
                  var myTime = DateFormat('HH:mm').format(date);

                  alarm.scheduledNotification(
                    int.parse(myTime.toString().split(':')[0]),
                    int.parse(myTime.toString().split(':')[1]),
                    task,
                  );

                  return GestureDetector(
                    onTap: () => showBottomSheet(context, task),
                    child: TaskItemBoard(task,onPressed: () => showBottomSheet(context, task),),
                  );
                } else {
                  return Container();
                }
              },
              itemCount: taskController.taskList.length,
            ),
          );
        }
      }),
    );
  }

  Future<void> _onRefresh() async {
    taskController.getTasks();
  }

  _noTaskMsg() {
    return Container();
  }

  showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 4),
          width: double.infinity,
          height: 400,
          color: Colors.white,
          child: Column(
            children: [
              Flexible(
                child: Container(
                  height: 6,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              task.isCompleted == 1
                  ? Container()
                  : _buildBottomSheet(
                label: 'Task Completed',
                onTap: () {
                  alarm.cancelNotification(task);
                  taskController.markTaskCompleted(task.id!);
                  Get.back();
                },
                clr: greenClr,
              ),
              task.isFavourite == 1
                  ? Container()
                  : _buildBottomSheet(
                label: 'Favourite',
                onTap: () {
                  taskController.markTaskFavourite(task.id!);
                  Get.back();
                },
                clr: greenClr,
              ),

              _buildBottomSheet(
                label: 'delete Task',
                onTap: () {
                  alarm.cancelNotification(task);
                  taskController.deleteTasks(task);
                  Get.back();
                },
                clr: redClr,
              ),
              const Divider(color: grey2Clr),
              _buildBottomSheet(
                label: 'Cancel',
                onTap: () {
                  Get.back();
                },
                clr: greenClr,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  _buildBottomSheet(
      {required String label,
        required Function() onTap,
        required Color clr,
        bool isClose = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 65,
        width: 300,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
          ),
        ),
      ),
    );
  }
}
