import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/features/auth/login/data/repos/login_repo_imp.dart';
import 'package:student_assistant/features/auth/login/presentation/cubits/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepoImp loginRepoImp;

  LoginCubit({required this.loginRepoImp}) : super(LoginInitial());

  void login(String email) async {
    emit(LoginLoading());

    ApiResult<void> result = await loginRepoImp.login(email);

    if (result is Success<void>) {
      emit(LoginSuccess(email: email));
    } else if (result is Failure<void>) {
      emit(LoginError(apiErrorModel: result.apiErrorModel));
    }
  }
}
