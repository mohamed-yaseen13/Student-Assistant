import 'package:flutter/material.dart';
import 'package:student_assistant/core/style/app_colors.dart';

class AddSemesterButton extends StatelessWidget {
  const AddSemesterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black),
      ),
      child: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: AppColors.lightOrange,
        onPressed: () {},
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
