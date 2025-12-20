import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_assistant/core/style/app_colors.dart';

class CourseNameTextFormField extends StatelessWidget {
  final TextEditingController controller;

  const CourseNameTextFormField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      inputFormatters: [LengthLimitingTextInputFormatter(20)],
      decoration: const InputDecoration(
        labelText: 'Course Name',
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.mainOrange),
        ),
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Please enter Course name';
        }
        return null;
      },
    );
  }
}
