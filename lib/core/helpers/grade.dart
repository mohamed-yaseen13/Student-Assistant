import 'package:student_assistant/core/constants/app_constants.dart';

class Grade {
  static double getGradePoint(String grade) =>
      AppConstants.defaultGrades[grade] ?? 0.0;
}
