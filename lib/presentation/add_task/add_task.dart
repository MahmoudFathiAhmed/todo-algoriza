import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_algoriza/controller/task_controller.dart';
import 'package:todo_algoriza/core/util/colors.dart';
import 'package:todo_algoriza/core/util/widgets/default_button.dart';
import 'package:todo_algoriza/data/models/task.dart';
import 'package:todo_algoriza/presentation/add_task/widgets/date_input_field.dart';
import 'package:todo_algoriza/presentation/add_task/widgets/remind_input_field.dart';
import 'package:todo_algoriza/presentation/add_task/widgets/repeat_input_field.dart';
import 'package:todo_algoriza/presentation/add_task/widgets/time_input_field.dart';
import 'package:todo_algoriza/presentation/add_task/widgets/title_input_field.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _titleController = TextEditingController();

  final TaskController taskController = Get.put(TaskController());

  DateTime selectedDate = DateTime.now();

  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();

  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();

  int selectedRemind = 5;

  List<int> remindList = [5, 10, 15, 20];

  String selectedRepeat = 'None';

  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

  int selectedColor = 0;

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
              'Add Task',
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
          body: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleInputField(
                          header: 'title',
                          type: TextInputType.text,
                          controller: _titleController,
                          label: 'Enter task title'),
                      const SizedBox(
                        height: 20,
                      ),
                      DateInputField(
                        header: 'date',
                        type: TextInputType.datetime,
                        label: DateFormat('yyyy-MM-dd').format(selectedDate),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          getDateFromUser();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TimeInputField(
                              type: TextInputType.datetime,
                              label: startTime,
                              controller: TextEditingController(),
                              header: 'Start Time',
                              onPressed: (){
                                FocusScope.of(context).unfocus();
                                getTimeFromUser(isStartTime: true);
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TimeInputField(
                              type: TextInputType.datetime,
                              label: endTime,
                              header: 'End Time',
                              onPressed: (){
                                FocusScope.of(context).unfocus();
                                getTimeFromUser(isStartTime: false);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                       RemindInputField(
                           header: 'Remind',
                           label: '$selectedRemind minutes early',
                           suffix:  DropdownButton(
                             dropdownColor: greenClr,
                             borderRadius: BorderRadius.circular(10),
                             items: remindList
                                 .map<DropdownMenuItem<String>>(
                                   (int value) => DropdownMenuItem<String>(
                                 value: value.toString(),
                                 child: Text('$value',
                                     style: const TextStyle(
                                       color: Colors.white,
                                     )),
                               ),
                             )
                                 .toList(),
                             icon: const Icon(Icons.keyboard_arrow_down,
                                 color: Colors.grey),
                             iconSize: 24,
                             elevation: 4,
                             underline: Container(height: 0),
                             onChanged: (String? newValue) {
                               setState(() {
                                 selectedRemind = int.parse(newValue!);
                               });
                             },
                           ),
                       ),
                      const SizedBox(
                        height: 20,
                      ),
                      RepeatInputField(
                          header: 'Repeat',
                          type: TextInputType.datetime,
                          label: selectedRepeat,
                        suffix: DropdownButton(
                          dropdownColor: greenClr,
                          borderRadius: BorderRadius.circular(10),
                          items: repeatList
                              .map<DropdownMenuItem<String>>(
                                (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  )),
                            ),
                          )
                              .toList(),
                          icon: const Icon(Icons.keyboard_arrow_down,
                              color: Colors.grey),
                          iconSize: 24,
                          elevation: 4,
                          underline: Container(height: 0),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedRepeat = newValue!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20,),
                      taskColor(),
                    ],
                  ),
                ),
                DefaultButton(
                    text: 'Create Task',
                    onclick: () {
                      validateDate();
                    }),
              ],
            ),
          ),
    );
  }

  getDateFromUser() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      setState(() => selectedDate = pickedDate);
    } else {
      debugPrint('It\'s null or something is wrong');
    }
  }

  Widget taskColor() {
    return Wrap(
      children: List<Widget>.generate(
        4,
            (index) => GestureDetector(
          onTap: () {
            setState(() {
              selectedColor = index;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CircleAvatar(
              backgroundColor: index == 0
                  ? redClr
                  : index == 1
                  ? orangeClr
                  : index ==2
                  ?yellowClr
                  :blueClr,
              radius: 14,
              child: selectedColor == index
                  ? const Icon(Icons.done, size: 16, color: Colors.white)
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
          DateTime.now().add(const Duration(minutes: 15))),
    );
    String formattedTime = pickedTime!.format(context);
    if (isStartTime) {
      setState(() => startTime = formattedTime);
    } else if (!isStartTime) {
      setState(() => endTime = formattedTime);
    } else {
      debugPrint('time canceled or something is wrong');
    }
  }

  validateDate() {
    FocusScope.of(context).unfocus();
    if (_titleController.text.isNotEmpty) {
      addTasksToDb();
      Get.back();
    } else if (_titleController.text.isEmpty) {
      Get.snackbar(
        'required',
        'All fields are required!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: redClr,
        icon: const Icon(Icons.warning_amber_rounded, color: redClr),
      );
    } else {
      debugPrint('Error');
    }
  }

  addTasksToDb() async {
    try {
      //print('here is the selected month ${_selectedDate.month}');
      //print('here is the selected day ${_selectedDate.day}');
      int value = await taskController.addTask(
        task: Task(
          title: _titleController.text,
          isCompleted: 0,
          date: DateFormat.yMd().format(selectedDate),
          startTime: startTime,
          endTime: endTime,
          color: selectedColor,
          remind: selectedRemind,
          repeat: selectedRepeat,
        ),
      );
      debugPrint('id value = $value');
    } catch (e) {
      debugPrint('Error = $e');
    }
  }

}
