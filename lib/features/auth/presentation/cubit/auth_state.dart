import 'package:student_assistant/core/api/api_error_model.dart';

sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthFirstStepLoading extends AuthState {}

class AuthFirstStepSuccess extends AuthState {
  final bool isUserHasAccount;
  final String email;

  AuthFirstStepSuccess({required this.isUserHasAccount, required this.email});
}

class AuthFirstStepError extends AuthState {
  final ApiErrorModel apiErrorModel;
  AuthFirstStepError({required this.apiErrorModel});
}

class AuthSecondStepLoading extends AuthState {}

class AuthSecondStepSuccess extends AuthState {}

class AuthSecondStepError extends AuthState {
  final ApiErrorModel apiErrorModel;
  AuthSecondStepError({required this.apiErrorModel});
}
