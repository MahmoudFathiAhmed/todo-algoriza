import 'package:flutter/material.dart';

//(overflow ellipsis and max lines 1)
//fontWeight w300
//color black
//text style may replaced by theme.of(context) directly
//default text align ==> center
class DefaultText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final Color color;
  final double fontSize;
  final TextAlign textAlign;

  const DefaultText(
      {Key? key,
        required this.text,
        this.fontWeight = FontWeight.w400,
        this.color = Colors.black,
        this.fontSize = 19,
        this.textAlign = TextAlign.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}