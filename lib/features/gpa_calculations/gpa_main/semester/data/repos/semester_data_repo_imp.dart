import 'package:student_assistant/core/api/api_error_handler.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/core/helpers/shared_prefs.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/data/apis/semester_data_api_service.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/models/semester_data_model.dart';

class SemesterDataRepoImp {
  final SemesterDataApiService semesterDataApiService;

  SemesterDataRepoImp({required this.semesterDataApiService});

  Future<ApiResult<SemesterDataModel>> getSemesterData(
    String semesterName,
  ) async {
    final email = SharedPrefs.getUserEmail();
    try {
      final response = await semesterDataApiService.getSemesterData(
        email,
        semesterName,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
