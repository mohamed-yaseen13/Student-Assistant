import 'package:student_assistant/core/api/api_error_model.dart';

sealed class GpaMainState {}

class GpaMainInitial extends GpaMainState {}

class GpaMainLoading extends GpaMainState {}

class GpaMainSuccess extends GpaMainState {}

class GpaMainError extends GpaMainState {
  final ApiErrorModel apiErrorModel;

  GpaMainError({required this.apiErrorModel});
}
