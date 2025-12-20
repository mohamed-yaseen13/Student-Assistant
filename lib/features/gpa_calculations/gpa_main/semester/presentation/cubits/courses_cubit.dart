import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/course_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/data/repos/specific_semester_repo_imp.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/presentation/cubits/courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  final SpecificSemesterRepoImp specificSemesterRepoImp;

  CoursesCubit({required this.specificSemesterRepoImp})
    : super(CoursesInitial());

  void addCourse(
    String semesterName,
    String courseName,
    double credits,
    String grade,
  ) async {
    emit(CoursesAddCourseLoading());
    final result = await specificSemesterRepoImp.addCourse(
      semesterName,
      courseName,
      credits,
      grade,
    );
    if (result is Success<void>) {
      emit(CoursesAddCourseSuccess());
    } else if (result is Failure<void>) {
      emit(CoursesAddCourseError(apiErrorModel: result.apiErrorModel));
    }
  }

  void getAllCourses(String semesterName) async {
    emit(CoursesGetAllCoursesLoading());
    final result = await specificSemesterRepoImp.getAllCourses(semesterName);
    if (result is Success<List<CourseModel>>) {
      emit(CoursesGetAllCoursesSuccess(courses: result.data));
    } else if (result is Failure<List<CourseModel>>) {
      emit(CoursesGetAllCoursesError(apiErrorModel: result.apiErrorModel));
    }
  }

  void deleteCourses(String semesterName, List<String> coursesNames) async {
    emit(CoursesDeleteCoursesLoading());
    final result = await specificSemesterRepoImp.deleteCourses(
      semesterName,
      coursesNames,
    );
    if (result is Success<void>) {
      emit(CoursesDeleteCoursesSuccess());
    } else if (result is Failure<void>) {
      emit(CoursesDeleteCoursesError(apiErrorModel: result.apiErrorModel));
    }
  }
}
