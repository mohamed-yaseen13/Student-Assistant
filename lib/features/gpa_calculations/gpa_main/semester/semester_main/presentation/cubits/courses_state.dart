import 'package:student_assistant/core/api/api_error_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/course_model.dart';

sealed class CoursesState {}

class CoursesInitial extends CoursesState {}

// Add Course
class CoursesAddCourseLoading extends CoursesState {}

class CoursesAddCourseSuccess extends CoursesState {}

class CoursesAddCourseError extends CoursesState {
  final ApiErrorModel apiErrorModel;
  CoursesAddCourseError({required this.apiErrorModel});
}

// Get All Courses
class CoursesGetAllCoursesLoading extends CoursesState {}

class CoursesGetAllCoursesSuccess extends CoursesState {
  final List<CourseModel> courses;
  CoursesGetAllCoursesSuccess({required this.courses});
}

class CoursesGetAllCoursesError extends CoursesState {
  final ApiErrorModel apiErrorModel;
  CoursesGetAllCoursesError({required this.apiErrorModel});
}

// Delete Courses
class CoursesDeleteCoursesLoading extends CoursesState {}

class CoursesDeleteCoursesSuccess extends CoursesState {}

class CoursesDeleteCoursesError extends CoursesState {
  final ApiErrorModel apiErrorModel;
  CoursesDeleteCoursesError({required this.apiErrorModel});
}
