import 'package:student_assistant/core/api/api_error_handler.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/core/helpers/shared_prefs.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/course/data/apis/sections_api_service.dart';

class SectionsRepoImp {
  final SectionsApiService sectionsApiService;

  SectionsRepoImp({required this.sectionsApiService});

  final String email = SharedPrefs.getUserEmail();

  Future<ApiResult<void>> addSection({
    required String semesterName,
    required String courseName,
    required String sectionName,
    required double got,
    required int from,
  }) async {
    try {
      final response = await sectionsApiService.addSection(
        email: email,
        semesterName: semesterName,
        courseName: courseName,
        sectionName: sectionName,
        got: got,
        from: from,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
