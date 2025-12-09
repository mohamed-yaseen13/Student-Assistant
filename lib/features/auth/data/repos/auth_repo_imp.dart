import 'package:student_assistant/core/api/api_error_handler.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/features/auth/data/apis/auth_api_service.dart';

class AuthRepoImp {
  final AuthApiService authApiService;

  AuthRepoImp({required this.authApiService});

  Future<ApiResult<bool>> firstStepOfAuth(String email) async {
    try {
      final response = await authApiService.firstStepOfAuth(email);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> secondStepOfAuth(String email, String otp) async {
    try {
      final response = await authApiService.secondStepOfAuth(email, otp);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
