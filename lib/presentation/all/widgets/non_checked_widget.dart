import 'package:flutter/material.dart';

class NonCheckedWidget extends StatelessWidget {
  const NonCheckedWidget({Key? key, required this.color, required this.onTab}) : super(key: key);
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
          border: Border.all(color: color, width: 1.5),
        ),
      ),
    );
  }
}
