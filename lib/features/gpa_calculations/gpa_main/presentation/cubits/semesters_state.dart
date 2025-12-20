import 'package:student_assistant/core/api/api_error_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/models/semester_model.dart';

sealed class SemestersState {}

class SemestersInitial extends SemestersState {}

// Add Semester
class SemestersAddSemesterLoading extends SemestersState {}

class SemestersAddSemesterSuccess extends SemestersState {}

class SemestersAddSemesterError extends SemestersState {
  final ApiErrorModel apiErrorModel;
  SemestersAddSemesterError({required this.apiErrorModel});
}

// Get All Semesters
class SemestersGetAllSemestersLoading extends SemestersState {}

class SemestersGetAllSemestersSuccess extends SemestersState {
  final List<SemesterModel> semesters;
  SemestersGetAllSemestersSuccess({required this.semesters});
}

class SemestersGetAllSemestersError extends SemestersState {
  final ApiErrorModel apiErrorModel;
  SemestersGetAllSemestersError({required this.apiErrorModel});
}

// Delete Semester
class SemestersDeleteLoading extends SemestersState {}

class SemestersDeleteSuccess extends SemestersState {}

class SemestersDeleteError extends SemestersState {
  final ApiErrorModel apiErrorModel;
  SemestersDeleteError({required this.apiErrorModel});
}
