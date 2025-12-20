import 'package:student_assistant/core/api/api_error_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/models/semester_data_model.dart';

sealed class SpecificSemesterState {}

class SpecificSemesterInitial extends SpecificSemesterState {}

class SpecificSemesterLoading extends SpecificSemesterState {}

class SpecificSemesterSuccess extends SpecificSemesterState {
  final SemesterDataModel semesterDataModel;
  SpecificSemesterSuccess({required this.semesterDataModel});
}

class SpecificSemesterError extends SpecificSemesterState {
  final ApiErrorModel apiErrorModel;
  SpecificSemesterError({required this.apiErrorModel});
}
