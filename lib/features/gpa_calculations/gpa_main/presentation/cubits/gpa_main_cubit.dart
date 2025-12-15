import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/data/repos/gpa_main_repo_imp.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/semester_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/gpa_main_state.dart';

class GpaMainCubit extends Cubit<GpaMainState> {
  final GpaMainRepoImp gpaMainRepoImp;

  GpaMainCubit({required this.gpaMainRepoImp}) : super(GpaMainInitial());

  void addSemester(String semesterName) async {
    emit(GpaMainAddSemesterLoading());
    final result = await gpaMainRepoImp.addSemester(semesterName);
    if (result is Success<void>) {
      emit(GpaMainAddSemesterSuccess());
    } else if (result is Failure<void>) {
      emit(GpaMainError(apiErrorModel: result.apiErrorModel));
    }
  }

  void getAllSemesters() async {
    emit(GpaMainGetAllSemestersLoading());
    final result = await gpaMainRepoImp.getAllSemesters();
    if (result is Success<List<SemesterModel>>) {
      emit(GpaMainGetAllSemestersSuccess(semesters: result.data));
    } else if (result is Failure<List<SemesterModel>>) {
      emit(GpaMainError(apiErrorModel: result.apiErrorModel));
    }
  }
}
