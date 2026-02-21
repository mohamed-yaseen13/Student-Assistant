import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/features/auth/signup/data/repos/signup_repo_imp.dart';
import 'package:student_assistant/features/auth/signup/presentation/cubits/signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepoImp signupRepoImp;

  SignupCubit({required this.signupRepoImp}) : super(SignupInitial());

  void signup(String email, String username) async {
    emit(SignupLoading());
    final result = await signupRepoImp.signup(email, username);
    if (result is Success<void>) {
      emit(SignupSuccess(email: email));
    } else if (result is Failure<void>) {
      emit(SignupError(apiErrorModel: result.apiErrorModel));
    }
  }
}
