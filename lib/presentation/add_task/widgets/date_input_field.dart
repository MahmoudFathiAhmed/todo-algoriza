import 'package:flutter/material.dart';
import 'package:todo_algoriza/core/util/colors.dart';
import 'package:todo_algoriza/core/util/widgets/default_text_form_field.dart';

class DateInputField extends StatelessWidget {
  const DateInputField(
      {Key? key,
      required this.header,
      required this.type,
      required this.onPressed,
      this.controller,
      required this.label})
      : super(key: key);
  final String header;
  final TextInputType type;
  final VoidCallback onPressed;
  final TextEditingController? controller;
  final String label;

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
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: grey1Clr,
            ),
            onPressed: onPressed,
          ),
          validation: 'date not assigned',
          fillColor: lightGreyClr,
          borderColor: lightGreyClr,
          controller: controller,
          radius: 10,
        ),
      ],
    );
  }
}
