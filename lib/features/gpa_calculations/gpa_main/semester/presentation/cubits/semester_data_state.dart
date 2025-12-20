import 'package:student_assistant/core/api/api_error_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/models/semester_data_model.dart';

sealed class SemesterDataState {}

class SemesterDataInitial extends SemesterDataState {}

class SemesterDataLoading extends SemesterDataState {}

class SemesterDataSuccess extends SemesterDataState {
  final SemesterDataModel semesterDataModel;
  SemesterDataSuccess({required this.semesterDataModel});
}

class SemesterDataError extends SemesterDataState {
  final ApiErrorModel apiErrorModel;
  SemesterDataError({required this.apiErrorModel});
}
