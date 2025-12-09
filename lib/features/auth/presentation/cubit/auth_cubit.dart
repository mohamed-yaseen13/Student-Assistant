import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/features/auth/data/repos/auth_repo_imp.dart';
import 'package:student_assistant/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepoImp authRepoImp;

  AuthCubit({required this.authRepoImp}) : super(AuthInitial());

  void firstStepOfAuth(String email) async {
    emit(AuthFirstStepLoading());

    ApiResult<bool> result = await authRepoImp.firstStepOfAuth(email);

    if (result is Success<bool>) {
      emit(AuthFirstStepSuccess(isUserHasAccount: result.data, email: email));
    } else if (result is Failure<bool>) {
      emit(AuthFirstStepError(apiErrorModel: result.apiErrorModel));
    }
  }

  void secondStepOfAuth(String email, String otp) async {
    emit(AuthSecondStepLoading());

    ApiResult<void> result = await authRepoImp.secondStepOfAuth(email, otp);

    if (result is Success<void>) {
      emit(AuthSecondStepSuccess());
    } else if (result is Failure<void>) {
      emit(AuthSecondStepError(apiErrorModel: result.apiErrorModel));
    }
  }
}
