import 'package:flutter/material.dart';
import 'package:student_assistant/core/constants/app_constants.dart';

class CourseGradeDropdown extends StatelessWidget {
  final String initialGrade;
  final ValueChanged<String?> onChanged;

  const CourseGradeDropdown({
    super.key,
    required this.initialGrade,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: initialGrade,
      decoration: const InputDecoration(
        labelText: 'Grade',
        border: OutlineInputBorder(),
      ),
      items: AppConstants.defaultGrades.keys
          .map(
            (grade) =>
                DropdownMenuItem<String>(value: grade, child: Text(grade)),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
