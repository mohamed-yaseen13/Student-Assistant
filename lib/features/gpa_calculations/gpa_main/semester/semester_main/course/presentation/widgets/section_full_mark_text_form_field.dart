import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_assistant/core/style/app_colors.dart';

class SectionFullMarkTextFormField extends StatelessWidget {
  final TextEditingController controller;

  const SectionFullMarkTextFormField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: false),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      ],
      decoration: const InputDecoration(
        labelText: 'Full Mark',
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.mainOrange),
        ),
      ),
      //validator: (value) {
      //  if (value?.isEmpty ?? true) {
      //    return 'Please enter the Full Mark';
      //  }
      //  return null;
      //},
    );
  }
}
