import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/models/student_model.dart';

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
    return ValueListenableBuilder(
      valueListenable: AppConstants.box.listenable(),
      builder: (context, Box<StudentModel> box, _) {
        final selectedScale = box.values.first.scales.values.firstWhere(
          (s) => s.isSelected,
        );
        final gradeList = selectedScale.grades.values
            .expand((gradeMap) => gradeMap.keys)
            .toList();
        const gradeOrder = [
          'A+',
          'A',
          'A-',
          'B+',
          'B',
          'B-',
          'C+',
          'C',
          'C-',
          'D+',
          'D',
          'F',
          'Fr',
        ];
        gradeList.sort(
          (a, b) => gradeOrder.indexOf(a).compareTo(gradeOrder.indexOf(b)),
        );
        return DropdownButtonFormField<String>(
          initialValue: initialGrade,
          decoration: const InputDecoration(
            labelText: 'Grade',
            border: OutlineInputBorder(),
          ),
          items: [
            const DropdownMenuItem<String>(value: '--', child: Text('--')),
            ...gradeList.map(
              (grade) =>
                  DropdownMenuItem<String>(value: grade, child: Text(grade)),
            ),
          ],
          onChanged: onChanged,
        );
      },
    );
  }
}
