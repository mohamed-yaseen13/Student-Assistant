import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_assistant/core/style/app_colors.dart';

class SectionGotMarkTextFormField extends StatelessWidget {
  final TextEditingController controller;

  const SectionGotMarkTextFormField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      ],
      decoration: const InputDecoration(
        labelText: 'Got Mark',
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.mainOrange),
        ),
      ),
      //validator: (value) {
      //  if (value?.isEmpty ?? true) {
      //    return 'Please enter Got Mark';
      //  }
      //  return null;
      //},
    );
  }
}
