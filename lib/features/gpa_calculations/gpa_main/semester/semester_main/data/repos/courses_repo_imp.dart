import 'package:student_assistant/core/api/api_error_handler.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/core/helpers/shared_prefs.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/course_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/data/apis/courses_api_service.dart';

class CoursesRepoImp {
  CoursesApiService coursesApiService;

  CoursesRepoImp({required this.coursesApiService});

  Future<ApiResult<bool>> checkRepeatedCourse(
    String courseName,
    int semesterIndex,
  ) async {
    final email = SharedPrefs.getUserEmail();
    try {
      final result = await coursesApiService
          .checkIfCourseExistsInPreviousSemesters(
            email,
            courseName,
            semesterIndex,
          );
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<void>> addCourse(
    String semesterName,
    String courseName,
    double credits,
    String grade,
    int semesterIndex,
  ) async {
    final email = SharedPrefs.getUserEmail();
    try {
      final response = await coursesApiService.addCourse(
        email,
        semesterName,
        courseName,
        credits,
        grade,
        semesterIndex,
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
    int semesterIndex,
  ) async {
    final email = SharedPrefs.getUserEmail();
    try {
      final response = await coursesApiService.deleteCourses(
        email,
        semesterName,
        coursesNames,
        semesterIndex,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
