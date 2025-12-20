import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/data/repos/semester_data_repo_imp.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/models/semester_data_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/presentation/cubits/semester_data_state.dart';

class SemesterDataCubit extends Cubit<SemesterDataState> {
  final SemesterDataRepoImp semesterDataRepoImp;

  SemesterDataCubit({required this.semesterDataRepoImp})
    : super(SemesterDataInitial());

  void getSpecificSemesterData(String semesterName) async {
    emit(SemesterDataLoading());
    final result = await semesterDataRepoImp.getSemesterData(semesterName);
    if (result is Success<SemesterDataModel>) {
      emit(SemesterDataSuccess(semesterDataModel: result.data));
    } else if (result is Failure<SemesterDataModel>) {
      emit(SemesterDataError(apiErrorModel: result.apiErrorModel));
    }
  }
}
