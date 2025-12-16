import 'package:flutter/material.dart';
import 'package:student_assistant/core/helpers/extensions.dart';

Future<void> showDeleteDialog({
  required BuildContext context,
  required String content,
  required VoidCallback onConfirm,
  required VoidCallback onCancel,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Delete $content'),
      content: Text('Do you actually need to delete these $content'),
      actions: [
        TextButton(
          onPressed: () => context.pop(false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () => context.pop(true),
          child: const Text('Yes'),
        ),
      ],
    ),
  );
  if (result == true) {
    onConfirm();
  }
  onCancel();
}
