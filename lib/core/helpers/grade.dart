import 'package:student_assistant/core/constants/app_constants.dart';

class Grade {
  static double getGradePoint(String grade) {
    final selectedScale = AppConstants.box.values.first.scales.values
        .firstWhere((s) => s.isSelected);
    for (final gradeMap in selectedScale.grades.values) {
      if (gradeMap.containsKey(grade)) {
        return gradeMap[grade]!;
      }
    }

    return 0.0;
  }
}
