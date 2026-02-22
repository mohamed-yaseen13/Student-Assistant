import 'package:student_assistant/core/api/api_error_model.dart';

sealed class SectionsState {}

class SectionsInitial extends SectionsState {}

// Add Section
class SectionsAddSectionLoading extends SectionsState {}

class SectionsAddSectionSuccess extends SectionsState {}

class SectionsAddSectionError extends SectionsState {
  final ApiErrorModel apiErrorModel;
  SectionsAddSectionError({required this.apiErrorModel});
}
