import 'package:flutter/material.dart';

class CheckedWidget extends StatelessWidget {
  const CheckedWidget({Key? key, required this.color, required this.onTab})
      : super(key: key);
  final Color color;
  final VoidCallback onTab;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: color,
        ),
        child: Icon(
          Icons.check,
          color: Colors.grey[200],
          size: 15,
        ),
      ),
    );
  }
}
