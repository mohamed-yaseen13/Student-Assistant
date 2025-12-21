import 'package:flutter/material.dart';
import 'package:student_assistant/core/style/app_colors.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback onPressed;
  const DeleteButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black),
      ),
      child: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: AppColors.mainOrange,
        onPressed: onPressed,
        child: const Icon(Icons.delete, color: Colors.black),
      ),
    );
  }
}
