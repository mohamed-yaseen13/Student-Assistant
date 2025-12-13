import 'package:student_assistant/core/api/api_error_handler.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/features/auth/signup/data/apis/signup_api_service.dart';

class SignupRepoImp {
  final SignupApiService signupApiService;

  SignupRepoImp({required this.signupApiService});

  Future<ApiResult<void>> signup(String email, String username) async {
    try {
      final response = await signupApiService.signup(email, username);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
