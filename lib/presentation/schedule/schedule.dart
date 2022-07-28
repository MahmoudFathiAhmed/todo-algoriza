import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_algoriza/controller/task_controller.dart';
import 'package:todo_algoriza/core/util/colors.dart';
import 'package:todo_algoriza/data/models/task.dart';
import 'package:todo_algoriza/presentation/schedule/widgets/date_timeline.dart';
import 'package:todo_algoriza/presentation/schedule/widgets/task_item.dart';
import 'package:todo_algoriza/services/alarm.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
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
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 2,
        shadowColor: grey2Clr,
        backgroundColor: Colors.white,
        title: const Text(
          'Schedule',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black87,
            size: 15,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          DateTimeline(
            onDateChange: (newDate) => setState(() => selectedDate = newDate),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 3,
            color: grey2Clr,
          ),
          const SizedBox(height: 20,),
          showTasks(),
          // Padding(
          //   padding: const EdgeInsets.all(25),
          //   child: Column(
          //     children: [
          //       const DateHeader(),
          //       const SizedBox(
          //         height: 20,
          //       ),
          //       Container(
          //         padding: const EdgeInsets.all(15),
          //         height: 80,
          //         width: double.infinity,
          //         decoration: BoxDecoration(
          //             color: Colors.red,
          //             borderRadius: BorderRadius.circular(15)),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: const [
          //                 Text(
          //                   '09:00 Am',
          //                   style: TextStyle(
          //                       color: Colors.white,
          //                       fontWeight: FontWeight.w400),
          //                 ),
          //                 SizedBox(
          //                   height: 8,
          //                 ),
          //                 Text(
          //                   'Design team meeting',
          //                   style: TextStyle(
          //                       color: Colors.white,
          //                       fontWeight: FontWeight.w400),
          //                 ),
          //               ],
          //             ),
          //             IconButton(
          //               onPressed: () {},
          //               icon: const Icon(
          //                 Icons.check_circle_outlined,
          //                 color: Colors.white,
          //
          //               ),
          //             ),
          //             // Container(
          //             //   height: 10,
          //             //   decoration: const BoxDecoration(
          //             //     shape: BoxShape.circle,
          //             //     color: Colors.white,
          //             //   ),
          //             // ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
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
                    child: TaskItem(task),
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
          height:
               (task.isCompleted == 1
              ? MediaQuery.of(context).size.height * 0.30
              : MediaQuery.of(context).size.height * 0.39),

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
        width: MediaQuery.of(context).size.width*0.9,
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
