// import 'package:flutter/material.dart';
// import 'package:todo_algoriza/core/util/colors.dart';
//
// class TaskColor extends StatefulWidget {
//   const TaskColor({Key? key,}) : super(key: key);
//
//   @override
//   State<TaskColor> createState() => _TaskColorState();
// }
//
// class _TaskColorState extends State<TaskColor> {
//   int selectedColor = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//         children: List<Widget>.generate(
//         4,
//         (index) => GestureDetector(
//       onTap: (){
//         setState(() {
//           selectedColor = index;
//         });
//       },
//       child: Padding(
//         padding: const EdgeInsets.only(right: 8),
//         child: CircleAvatar(
//           backgroundColor: index == 0
//               ? redClr
//               : index == 1
//               ? orangeClr
//               : index ==2
//               ?yellowClr
//               :blueClr,
//           radius: 14,
//           child: selectedColor == index
//               ? const Icon(Icons.done, size: 16, color: Colors.white)
//               : null,
//         ),
//       ),
//     ),
//         ),
//     );
//   }
// }
