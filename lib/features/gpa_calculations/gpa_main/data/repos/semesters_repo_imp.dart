import 'package:student_assistant/core/api/api_error_handler.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/core/helpers/shared_prefs.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/data/apis/semesters_api_service.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/models/semester_model.dart';

class SemestersRepoImp {
  SemestersApiService semestersApiService;

  SemestersRepoImp({required this.semestersApiService});

  Future<ApiResult<void>> addSemester(String semesterName) async {
    final String email = SharedPrefs.getUserEmail();
    try {
      final response = await semestersApiService.addSemester(
        email,
        semesterName,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<SemesterModel>>> getAllSemesters() async {
    final String email = SharedPrefs.getUserEmail();
    try {
      final response = await semestersApiService.getAllSemesters(email);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> deleteSemesters(List<String> semestersNames) async {
    final String email = SharedPrefs.getUserEmail();
    try {
      final response = await semestersApiService.deleteSemesters(
        email,
        semestersNames,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
