import 'package:student_assistant/core/api/api_error_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/models/scale_model.dart';

sealed class ScalesState {}

class ScalesInitial extends ScalesState {}

// get selected scale's title
class ScalesGetSelectedScaleTitleLoading extends ScalesState {}

class ScalesGetSelectedScaleTitleSuccess extends ScalesState {
  final String scaleTitle;
  ScalesGetSelectedScaleTitleSuccess({required this.scaleTitle});
}

class ScalesGetSelectedScaleTitleError extends ScalesState {
  final ApiErrorModel apiErrorModel;
  ScalesGetSelectedScaleTitleError({required this.apiErrorModel});
}

// get all scales
class ScalesGetAllScalesLoading extends ScalesState {}

class ScalesGetAllScalesSuccess extends ScalesState {
  final List<ScaleModel> scales;
  ScalesGetAllScalesSuccess({required this.scales});
}

class ScalesGetAllScalesError extends ScalesState {
  final ApiErrorModel apiErrorModel;
  ScalesGetAllScalesError({required this.apiErrorModel});
}

// save scale
class ScalesSaveScaleLoading extends ScalesState {}

class ScalesSaveScaleSuccess extends ScalesState {}

class ScalesSaveScaleError extends ScalesState {
  final ApiErrorModel apiErrorModel;
  ScalesSaveScaleError({required this.apiErrorModel});
}

// delete scale
class ScalesDeleteScaleLoading extends ScalesState {}

class ScalesDeleteScaleSuccess extends ScalesState {}

class ScalesDeleteScaleError extends ScalesState {
  final ApiErrorModel apiErrorModel;
  ScalesDeleteScaleError({required this.apiErrorModel});
}

// change scale
class ScalesChangeScaleLoading extends ScalesState {}

class ScalesChangeScaleSuccess extends ScalesState {}

class ScalesChangeScaleError extends ScalesState {
  final ApiErrorModel apiErrorModel;
  ScalesChangeScaleError({required this.apiErrorModel});
}
