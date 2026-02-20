import 'package:student_assistant/core/api/api_error_handler.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/core/helpers/shared_prefs.dart';
import 'package:student_assistant/core/models/course_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/data/apis/courses_api_service.dart';

class CoursesRepoImp {
  CoursesApiService coursesApiService;

  CoursesRepoImp({required this.coursesApiService});
  final email = SharedPrefs.getUserEmail();

  Future<ApiResult<bool>> checkRepeatedCourse(
    String courseName,
    int semesterIndex,
  ) async {
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

  Future<ApiResult<void>> addCourse({
    required String semesterName,
    required String courseName,
    required double credits,
    required String grade,
    required int semesterIndex,
    required bool isRepeated,
  }) async {
    try {
      final response = await coursesApiService.addCourse(
        email: email,
        semesterName: semesterName,
        courseName: courseName,
        credits: credits,
        grade: grade,
        semesterIndex: semesterIndex,
        isRepeated: isRepeated,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> deleteCourses(
    String semesterName,
    List<CourseModel> coursesNames,
    int semesterIndex,
  ) async {
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

  Future<ApiResult<void>> editCourse({
    required String semesterName,
    required String courseName,
    required int courseIndex,
    required bool isRepeated,
    required int semesterIndex,
    required String grade,
    required String oldCourseName,
    required double credits,
  }) async {
    try {
      final response = await coursesApiService.editCourse(
        email: email,
        semesterName: semesterName,
        courseName: courseName,
        semesterIndex: semesterIndex,
        courseIndex: courseIndex,
        isRepeated: isRepeated,
        grade: grade,
        credits: credits,
        oldCourseName: oldCourseName,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
