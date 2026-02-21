import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/features/auth/otp/data/repos/otp_repo_imp.dart';
import 'package:student_assistant/features/auth/otp/presentation/cubits/otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final OtpRepoImp otpRepoImp;

  OtpCubit({required this.otpRepoImp}) : super(OtpInitial());

  void verifyOtp(String email, String otp, {bool? isLoggingIn = false}) async {
    emit(OtpLoading());
    final result = await otpRepoImp.verifyOtp(
      email,
      otp,
      isLoggingIn: isLoggingIn,
    );
    if (result is Success<void>) {
      emit(OtpSuccess());
    } else if (result is Failure<void>) {
      emit(OtpError(apiErrorModel: result.apiErrorModel));
    }
  }
}
