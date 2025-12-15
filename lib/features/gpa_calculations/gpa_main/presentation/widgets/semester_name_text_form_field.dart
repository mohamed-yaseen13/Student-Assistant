import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_assistant/core/style/app_colors.dart';

class SemesterNameTextFormField extends StatelessWidget {
  final TextEditingController controller;

  const SemesterNameTextFormField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      inputFormatters: [LengthLimitingTextInputFormatter(20)],
      decoration: const InputDecoration(
        labelText: 'Semester Name',
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.mainOrange),
        ),
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Please enter Semester name';
        }
        return null;
      },
    );
  }
}
