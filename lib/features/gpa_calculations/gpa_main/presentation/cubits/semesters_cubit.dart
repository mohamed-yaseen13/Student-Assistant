import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/data/repos/semesters_repo_imp.dart';
import 'package:student_assistant/core/models/searched_course_model.dart';
import 'package:student_assistant/core/models/semester_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/semesters_state.dart';

class SemestersCubit extends Cubit<SemestersState> {
  final SemestersRepoImp semestersRepoImp;

  SemestersCubit({required this.semestersRepoImp}) : super(SemestersInitial());

  void addSemester(String semesterName) async {
    emit(SemestersAddSemesterLoading());
    final result = await semestersRepoImp.addSemester(semesterName);
    if (result is Success<void>) {
      emit(SemestersAddSemesterSuccess());
    } else if (result is Failure<void>) {
      emit(SemestersAddSemesterError(apiErrorModel: result.apiErrorModel));
    }
  }

  Future<void> deleteSemesters(List<SemesterModel> semestersNames) async {
    emit(SemestersDeleteLoading());
    final result = await semestersRepoImp.deleteSemesters(semestersNames);
    if (result is Success<void>) {
      emit(SemestersDeleteSuccess());
    } else if (result is Failure<void>) {
      emit(SemestersDeleteError(apiErrorModel: result.apiErrorModel));
    }
  }

  void searchForCourse(String courseName) {
    emit(SemestersSearchForCourseLoading());
    final result = semestersRepoImp.searchForCourse(courseName);
    if (result is Success<List<SearchedCourseModel>>) {
      emit(SemestersSearchForCourseSuccess(searchedCourseResults: result.data));
    } else if (result is Failure<List<SearchedCourseModel>>) {
      emit(SemestersSearchForCourseError(apiErrorModel: result.apiErrorModel));
    }
  }

  Future<void> editSemesterName(
    String oldSemesterName,
    String newSemesterName,
  ) async {
    emit(SemestersEditSemesterNameLoading());
    final result = await semestersRepoImp.editSemesterName(
      oldSemesterName,
      newSemesterName,
    );
    if (result is Success<void>) {
      emit(SemestersEditSemesterNameSuccess());
    } else if (result is Failure<void>) {
      emit(SemestersEditSemesterNameError(apiErrorModel: result.apiErrorModel));
    }
  }
}
