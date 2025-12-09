import 'package:flutter/material.dart';
import 'package:student_assistant/core/helpers/extensions.dart';

void errorState({
  required BuildContext context,
  required String desc,
  required String message,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(desc),
      content: Text(message),
      actions: [
        TextButton(onPressed: () => context.pop(), child: const Text("OK")),
      ],
    ),
  );
}
