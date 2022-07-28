import 'package:flutter/material.dart';
import 'package:todo_algoriza/core/util/colors.dart';
import 'package:todo_algoriza/core/util/widgets/default_text_form_field.dart';

class RepeatInputField extends StatelessWidget {
  const RepeatInputField(
      {Key? key,
      required this.header,
      this.type,
      this.controller,
      required this.label, required this.suffix})
      : super(key: key);
  final String header;
  final TextInputType? type;
  final TextEditingController? controller;
  final String label;
  final Widget suffix;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(header),
        const SizedBox(
          height: 10,
        ),
        DefaultTextFormField(
          type: type,
          label: label,
          isFilled: true,
          suffixIcon: suffix,
          validation: 'Repeat not assigned',
          fillColor: lightGreyClr,
          borderColor: lightGreyClr,
          controller: controller,
          radius: 10,
        ),
      ],
    );
  }
}
