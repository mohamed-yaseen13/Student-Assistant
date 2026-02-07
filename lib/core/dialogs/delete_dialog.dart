import 'package:flutter/material.dart';
import 'package:student_assistant/core/helpers/extensions.dart';

Future<void> showDeleteDialog({
  required BuildContext context,
  String? content,
  required VoidCallback onConfirm,
  required VoidCallback onCancel,
  bool? isSingle = true,
  bool? isScale = false,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Delete ${isScale == true ? 'Scale' : content}'),
      content: Text(
        'Do you actually need to delete ${isSingle == true ? 'this' : 'these'} ${isScale == true ? 'Scale' : content}',
      ),
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
  } else {
    onCancel();
  }
}
