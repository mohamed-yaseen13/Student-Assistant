import 'package:student_assistant/core/api/api_error_handler.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/core/helpers/shared_prefs.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/data/apis/semesters_api_service.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/data/mappers/searched_course_mapper.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/searched_course_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/models/semester_model.dart';

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

  Future<ApiResult<List<SemesterModel>>> getAllSemesters() async {
    try {
      final response = await semestersApiService.getAllSemesters(email);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> deleteSemesters(List<String> semestersNames) async {
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

  Future<ApiResult<List<SearchedCourseModel>>> searchForCourse(
    String courseName,
  ) async {
    try {
      final String searchName = courseName.toLowerCase().replaceAll(
        RegExp(r'\s+'),
        '',
      );
      final semesters = await semestersApiService.searchForCourse(
        email,
        searchName,
      );
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
