import 'package:flutter/material.dart';
import 'package:student_assistant/core/helpers/extensions.dart';
import 'package:student_assistant/core/widgets/app_text_form_field.dart';

class EmailTextFormField extends StatelessWidget {
  final TextEditingController emailController;

  const EmailTextFormField({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    return AppTextFormField(
      controller: emailController,
      placeholder: 'Enter your email',
      textInputType: TextInputType.emailAddress,
      validator: (value) {
        if (value.isNullOrEmpty()) {
          return "Enter an email";
        } else if (!emailRegex.hasMatch(value!)) {
          return 'Enter a valid email';
        } else {
          return null;
        }
      },
      prefixIcon: Icon(Icons.email_outlined),
    );
  }
}
