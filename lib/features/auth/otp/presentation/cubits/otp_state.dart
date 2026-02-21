import 'package:student_assistant/core/api/api_error_model.dart';

sealed class OtpState {}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSuccess extends OtpState {}

class OtpError extends OtpState {
  final ApiErrorModel apiErrorModel;
  OtpError({required this.apiErrorModel});
}
