import 'package:student_assistant/core/api/api_error_handler.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/course_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/data/apis/specific_semester_api_service.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/models/semester_data_model.dart';

class SpecificSemesterRepoImp {
  final SpecificSemesterApiService specificSemesterApiService;

  SpecificSemesterRepoImp({required this.specificSemesterApiService});

  Future<ApiResult<SemesterDataModel>> getSpecificSemesterData(
    String semesterName,
  ) async {
    try {
      final response = await specificSemesterApiService.getSpecificSemesterData(
        semesterName,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> addCourse(
    String semesterName,
    String courseName,
    double credits,
    String grade,
  ) async {
    try {
      final response = await specificSemesterApiService.addCourse(
        semesterName,
        courseName,
        credits,
        grade,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<CourseModel>>> getAllCourses(
    String semesterName,
  ) async {
    try {
      final response = await specificSemesterApiService.getAllCourses(
        semesterName,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> deleteCourses(
    String semesterName,
    List<String> coursesNames,
  ) async {
    try {
      final response = await specificSemesterApiService.deleteCourses(
        semesterName,
        coursesNames,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
