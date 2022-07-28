import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:todo_algoriza/core/util/colors.dart';

class DateTimeline extends StatelessWidget {
  const DateTimeline({Key? key, required this.onDateChange}) : super(key: key);
  final Function(DateTime) onDateChange;

  @override
  Widget build(BuildContext context) {
    return DatePicker(
      DateTime.now(),
      width: 70,
      height: 80,
      initialSelectedDate: DateTime.now(),
      selectedTextColor: Colors.white,
      selectionColor: greenClr,
      monthTextStyle: TextStyle(fontSize: 0),
      onDateChange: onDateChange,
    );
  }
}
