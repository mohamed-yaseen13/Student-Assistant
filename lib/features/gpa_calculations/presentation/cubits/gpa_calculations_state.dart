import 'package:student_assistant/core/api/api_error_model.dart';

sealed class GpaCalculationsState {}

class GpaCalculationsInitial extends GpaCalculationsState {}

class GpaCalculationsLoading extends GpaCalculationsState {}

class GpaCalculationsSuccess extends GpaCalculationsState {}

class GpaCalculationsError extends GpaCalculationsState {
  final ApiErrorModel apiErrorModel;
  GpaCalculationsError({required this.apiErrorModel});
}
