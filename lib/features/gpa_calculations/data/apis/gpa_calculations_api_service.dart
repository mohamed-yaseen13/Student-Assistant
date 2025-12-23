import 'package:student_assistant/core/constants/app_constants.dart';

class GpaCalculationsApiService {
  GpaCalculationsApiService();

  double getGradePoints(String grade) {
    final key = AppConstants.defaultGrades.keys.firstWhere(
      (grade) => grade == grade,
    );
    return AppConstants.defaultGrades[key]!;
  }
}
