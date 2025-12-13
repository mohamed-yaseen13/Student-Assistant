import 'package:student_assistant/core/api/api_error_handler.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/features/auth/otp/data/apis/otp_api_service.dart';

class OtpRepoImp {
  final OtpApiService otpApiService;

  OtpRepoImp({required this.otpApiService});

  Future<ApiResult<void>> verifyOtp(String email, String otp) async {
    try {
      final response = await otpApiService.verifyOtp(email, otp);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
