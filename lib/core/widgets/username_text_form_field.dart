import 'package:flutter/material.dart';
import 'package:student_assistant/core/helpers/extensions.dart';
import 'package:student_assistant/core/widgets/app_text_form_field.dart';

class UsernameTextFormField extends StatelessWidget {
  final TextEditingController usernameController;

  const UsernameTextFormField({super.key, required this.usernameController});

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      controller: usernameController,
      placeholder: 'Enter Your username',
      textInputType: TextInputType.text,
      validator: (value) {
        if (value.isNullOrEmpty()) {
          return 'Enter a username';
        } else if (value!.length < 3) {
          return 'username should be at least 3 characters';
        } else {
          return null;
        }
      },
      prefixIcon: Icon(Icons.person_outline),
    );
  }
}
