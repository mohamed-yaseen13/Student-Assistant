import 'package:student_assistant/core/api/api_error_handler.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/features/auth/login/data/apis/login_api_service.dart';

class LoginRepoImp {
  final LoginApiService loginApiService;

  LoginRepoImp({required this.loginApiService});

  Future<ApiResult<void>> login(String email) async {
    try {
      final response = await loginApiService.login(email);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
