import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/course_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/data/repos/courses_repo_imp.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/presentation/cubits/courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  final CoursesRepoImp coursesRepoImp;

  CoursesCubit({required this.coursesRepoImp}) : super(CoursesInitial());

  Future<bool> checkRepeatedCourse(String courseName, int semesterIndex) async {
    final result = await coursesRepoImp.checkRepeatedCourse(
      courseName,
      semesterIndex,
    );
    if (result is Success<bool>) {
      return result.data;
    }
    return false;
  }

  Future<void> addCourse({
    required String semesterName,
    required String courseName,
    required double credits,
    required String grade,
    required int semesterIndex,
    required bool isRepeated,
  }) async {
    emit(CoursesAddCourseLoading());
    final result = await coursesRepoImp.addCourse(
      semesterName: semesterName,
      courseName: courseName,
      credits: credits,
      grade: grade,
      semesterIndex: semesterIndex,
      isRepeated: isRepeated,
    );
    if (result is Success<void>) {
      emit(CoursesAddCourseSuccess());
    } else if (result is Failure<void>) {
      emit(CoursesAddCourseError(apiErrorModel: result.apiErrorModel));
    }
  }

  Future<void> getAllCourses(String semesterName) async {
    emit(CoursesGetAllCoursesLoading());
    final result = await coursesRepoImp.getAllCourses(semesterName);
    if (result is Success<List<CourseModel>>) {
      emit(CoursesGetAllCoursesSuccess(courses: result.data));
    } else if (result is Failure<List<CourseModel>>) {
      emit(CoursesGetAllCoursesError(apiErrorModel: result.apiErrorModel));
    }
  }

  Future<void> deleteCourses(
    String semesterName,
    List<CourseModel> coursesNames,
    int semesterIndex,
  ) async {
    emit(CoursesDeleteCoursesLoading());
    final result = await coursesRepoImp.deleteCourses(
      semesterName,
      coursesNames,
      semesterIndex,
    );
    if (result is Success<void>) {
      emit(CoursesDeleteCoursesSuccess());
    } else if (result is Failure<void>) {
      emit(CoursesDeleteCoursesError(apiErrorModel: result.apiErrorModel));
    }
  }

  Future<void> editCourse({
    required String semesterName,
    required String courseName,
    required int courseIndex,
    required bool isRepeated,
    required int semesterIndex,
    required String grade,
    required String oldCourseName,
    required double credits,
  }) async {
    emit(CoursesEditCourseLoading());
    final result = await coursesRepoImp.editCourse(
      semesterIndex: semesterIndex,
      semesterName: semesterName,
      courseIndex: courseIndex,
      courseName: courseName,
      oldCourseName: oldCourseName,
      grade: grade,
      credits: credits,
      isRepeated: isRepeated,
    );
    if (result is Success<void>) {
      emit(CoursesEditCourseSuccess());
    } else if (result is Failure<void>) {
      emit(CoursesEditCourseError(apiErrorModel: result.apiErrorModel));
    }
  }
}
