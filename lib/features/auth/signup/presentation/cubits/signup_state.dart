import 'package:student_assistant/core/api/api_error_model.dart';

sealed class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final String email;
  SignupSuccess({required this.email});
}

class SignupError extends SignupState {
  final ApiErrorModel apiErrorModel;
  SignupError({required this.apiErrorModel});
}
