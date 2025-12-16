import 'package:student_assistant/core/api/api_error_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/semester_model.dart';

sealed class SemestersState {}

class SemestersInitial extends SemestersState {}

// Add Semester
class SemestersAddSemesterLoading extends SemestersState {}

class SemestersAddSemesterSuccess extends SemestersState {}

// Get All Semesters
class SemestersGetAllSemestersLoading extends SemestersState {}

class SemestersGetAllSemestersSuccess extends SemestersState {
  final List<SemesterModel> semesters;
  SemestersGetAllSemestersSuccess({required this.semesters});
}

class SemestersError extends SemestersState {
  final ApiErrorModel apiErrorModel;

  SemestersError({required this.apiErrorModel});
}
