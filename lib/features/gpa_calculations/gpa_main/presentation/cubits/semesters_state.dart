import 'package:student_assistant/core/api/api_error_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/searched_course_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/models/semester_model.dart';

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

// Search For Course
class SemestersSearchForCourseLoading extends SemestersState {}

class SemestersSearchForCourseSuccess extends SemestersState {
  final List<SearchedCourseModel> searchedCourseResults;
  SemestersSearchForCourseSuccess({required this.searchedCourseResults});
}

class SemestersSearchForCourseError extends SemestersState {
  final ApiErrorModel apiErrorModel;
  SemestersSearchForCourseError({required this.apiErrorModel});
}

// Edit Semester Name
class SemestersEditSemesterNameLoading extends SemestersState {}

class SemestersEditSemesterNameSuccess extends SemestersState {}

class SemestersEditSemesterNameError extends SemestersState {
  final ApiErrorModel apiErrorModel;
  SemestersEditSemesterNameError({required this.apiErrorModel});
}
