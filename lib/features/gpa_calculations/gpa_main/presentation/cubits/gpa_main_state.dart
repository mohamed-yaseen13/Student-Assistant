import 'package:student_assistant/core/api/api_error_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/semester_model.dart';

sealed class GpaMainState {}

class GpaMainInitial extends GpaMainState {}

class GpaMainAddSemesterLoading extends GpaMainState {}

class GpaMainAddSemesterSuccess extends GpaMainState {}

class GpaMainError extends GpaMainState {
  final ApiErrorModel apiErrorModel;

  GpaMainError({required this.apiErrorModel});
}

class GpaMainGetAllSemestersLoading extends GpaMainState {}

class GpaMainGetAllSemestersSuccess extends GpaMainState {
  final List<SemesterModel> semesters;
  GpaMainGetAllSemestersSuccess({required this.semesters});
}
