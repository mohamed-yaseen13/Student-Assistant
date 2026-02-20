import 'package:student_assistant/core/api/api_error_model.dart';

sealed class CoursesState {}

class CoursesInitial extends CoursesState {}

// Add Course
class CoursesAddCourseLoading extends CoursesState {}

class CoursesAddCourseSuccess extends CoursesState {}

class CoursesAddCourseError extends CoursesState {
  final ApiErrorModel apiErrorModel;
  CoursesAddCourseError({required this.apiErrorModel});
}

// Delete Courses
class CoursesDeleteCoursesLoading extends CoursesState {}

class CoursesDeleteCoursesSuccess extends CoursesState {}

class CoursesDeleteCoursesError extends CoursesState {
  final ApiErrorModel apiErrorModel;
  CoursesDeleteCoursesError({required this.apiErrorModel});
}

// Edit Course
class CoursesEditCourseLoading extends CoursesState {}

class CoursesEditCourseSuccess extends CoursesState {}

class CoursesEditCourseError extends CoursesState {
  final ApiErrorModel apiErrorModel;
  CoursesEditCourseError({required this.apiErrorModel});
}
