import 'package:flutter/material.dart';
import 'package:todo_algoriza/core/util/colors.dart';

//NOTE: default width ==> double.infinity
class DefaultButton extends StatelessWidget {
  final Color backgroundColor;
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double width;
  final double height;
  final VoidCallback onclick;
  final double borderRadius;

  const DefaultButton(
      {Key? key,
        this.backgroundColor = greenClr,
        required this.text,
        this.textColor = Colors.white,
        this.width = double.infinity,
        required this.onclick,
        this.borderRadius = 15,
        this.fontSize = 16,
        this.fontWeight = FontWeight.w500,
        this.height = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: backgroundColor),
      child: MaterialButton(
        onPressed: onclick,
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}