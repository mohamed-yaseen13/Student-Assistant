import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/data/repos/gpa_main_repo_imp.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/semester_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/semesters_state.dart';

class SemestersCubit extends Cubit<SemestersState> {
  final GpaMainRepoImp gpaMainRepoImp;

  SemestersCubit({required this.gpaMainRepoImp}) : super(SemestersInitial());

  void addSemester(String semesterName) async {
    emit(SemestersAddSemesterLoading());
    final result = await gpaMainRepoImp.addSemester(semesterName);
    if (result is Success<void>) {
      emit(SemestersAddSemesterSuccess());
    } else if (result is Failure<void>) {
      emit(SemestersError(apiErrorModel: result.apiErrorModel));
    }
  }

  void getAllSemesters() async {
    emit(SemestersGetAllSemestersLoading());
    final result = await gpaMainRepoImp.getAllSemesters();
    if (result is Success<List<SemesterModel>>) {
      emit(SemestersGetAllSemestersSuccess(semesters: result.data));
    } else if (result is Failure<List<SemesterModel>>) {
      emit(SemestersError(apiErrorModel: result.apiErrorModel));
    }
  }

  void deleteSemester(String semesterName) async {
    emit(SemestersDeleteLoading());
    final result = await gpaMainRepoImp.deleteSemester(semesterName);
    if (result is Success<void>) {
      emit(SemestersDeleteSuccess());
    } else if (result is Failure<void>) {
      emit(SemestersError(apiErrorModel: result.apiErrorModel));
    }
  }
}
