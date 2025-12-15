import 'package:student_assistant/core/api/api_error_handler.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/data/apis/gpa_main_api_service.dart';

class GpaMainRepoImp {
  final GpaMainApiService gpaMainApiService;

  GpaMainRepoImp({required this.gpaMainApiService});

  Future<ApiResult<void>> addSemester(String semesterName) async {
    try {
      final response = await gpaMainApiService.addSemester(semesterName);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
