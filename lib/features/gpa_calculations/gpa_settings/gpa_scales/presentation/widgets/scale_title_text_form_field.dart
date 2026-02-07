import 'package:flutter/material.dart';

class ScaleTitleTextFormField extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const ScaleTitleTextFormField({
    super.key,
    required this.onChanged,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      onChanged: onChanged,
      decoration: InputDecoration(labelText: 'Scale Title'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please add a scale title';
        }
        return null;
      },
    );
  }
}
