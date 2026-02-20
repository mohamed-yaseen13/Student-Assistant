import 'package:student_assistant/core/api/api_error_handler.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/core/helpers/shared_prefs.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/data/apis/semesters_api_service.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/data/mappers/searched_course_mapper.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/searched_course_model.dart';
import 'package:student_assistant/core/models/semester_model.dart';

class SemestersRepoImp {
  SemestersApiService semestersApiService;

  SemestersRepoImp({required this.semestersApiService});

  final String email = SharedPrefs.getUserEmail();

  Future<ApiResult<void>> addSemester(String semesterName) async {
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

  Future<ApiResult<void>> deleteSemesters(
    List<SemesterModel> semestersNames,
  ) async {
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

  ApiResult<List<SearchedCourseModel>> searchForCourse(String courseName) {
    try {
      final String searchName = courseName.toLowerCase().replaceAll(
        RegExp(r'\s+'),
        '',
      );
      final semesters = semestersApiService.searchForCourse(email, searchName);
      final response = SearchedCourseMapper.toSearchedCourseModel(
        semesters,
        searchName,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> editSemesterName(
    String oldSemesterName,
    String newSemesterName,
  ) async {
    try {
      final response = await semestersApiService.editSemesterName(
        email,
        oldSemesterName,
        newSemesterName,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
