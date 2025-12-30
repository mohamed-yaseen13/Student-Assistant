import 'package:student_assistant/core/api/api_error_handler.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/core/helpers/shared_prefs.dart';
import 'package:student_assistant/features/gpa_calculations/data/apis/gpa_calculations_api_service.dart';

class GpaCalculationsRepoImp {
  final GpaCalculationsApiService gpaCalculationsApiService;

  GpaCalculationsRepoImp({required this.gpaCalculationsApiService});

  Future<ApiResult<void>> calculateGpaAndCgpa() async {
    final String email = SharedPrefs.getUserEmail();
    try {
      final response = await gpaCalculationsApiService.calculateGpaAndCgpa(
        email,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
