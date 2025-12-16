import 'package:student_assistant/core/api/api_error_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/gpa_data_model.dart';

sealed class GpaDataState {}

class GpaDataInitial extends GpaDataState {}

class GpaDataLoading extends GpaDataState {}

class GpaDataSuccess extends GpaDataState {
  final GpaDataModel gpaDataModel;
  GpaDataSuccess({required this.gpaDataModel});
}

class GpaDataError extends GpaDataState {
  final ApiErrorModel apiErrorModel;
  GpaDataError({required this.apiErrorModel});
}
