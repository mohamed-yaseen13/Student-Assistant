import 'package:student_assistant/core/api/api_error_model.dart';

sealed class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String email;

  LoginSuccess({required this.email});
}

class LoginError extends LoginState {
  final ApiErrorModel apiErrorModel;

  LoginError({required this.apiErrorModel});
}
