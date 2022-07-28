import 'package:flutter/material.dart';
import 'package:todo_algoriza/core/util/colors.dart';
import 'package:todo_algoriza/core/util/widgets/default_text_form_field.dart';

class TimeInputField extends StatelessWidget {
  const TimeInputField(
      {Key? key,
      required this.header,
      required this.type,
      this.controller,
      required this.label, required this.onPressed})
      : super(key: key);
  final String header;
  final TextInputType type;
  final TextEditingController? controller;
  final String label;
  final VoidCallback onPressed;

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
              Icons.watch_later_outlined,
              color: grey1Clr,
            ),
            onPressed: onPressed,
          ),
          validation: 'Time not assigned',
          fillColor: lightGreyClr,
          borderColor: lightGreyClr,
          controller: controller,
          radius: 10,
        ),
      ],
    );
  }
}
