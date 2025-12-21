import 'package:student_assistant/core/api/api_error_handler.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/core/helpers/shared_prefs.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/course_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/data/apis/courses_api_service.dart';

class CoursesRepoImp {
  CoursesApiService coursesApiService;

  CoursesRepoImp({required this.coursesApiService});

  Future<ApiResult<void>> addCourse(
    String semesterName,
    String courseName,
    double credits,
    String grade,
  ) async {
    final email = SharedPrefs.getUserEmail();
    try {
      final response = await coursesApiService.addCourse(
        email,
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
    final email = SharedPrefs.getUserEmail();
    try {
      final response = await coursesApiService.getAllCourses(
        email,
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
    final email = SharedPrefs.getUserEmail();
    try {
      final response = await coursesApiService.deleteCourses(
        email,
        semesterName,
        coursesNames,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
