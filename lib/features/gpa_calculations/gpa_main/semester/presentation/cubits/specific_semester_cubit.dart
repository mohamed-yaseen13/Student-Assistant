import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/data/repos/specific_semester_repo_imp.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/models/semester_data_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/presentation/cubits/specific_semester_state.dart';

class SpecificSemesterCubit extends Cubit<SpecificSemesterState> {
  final SpecificSemesterRepoImp specificSemesterRepoImp;

  SpecificSemesterCubit({required this.specificSemesterRepoImp})
    : super(SpecificSemesterInitial());

  void getSpecificSemesterData(String semesterName) async {
    emit(SpecificSemesterLoading());
    final result = await specificSemesterRepoImp.getSpecificSemesterData(
      semesterName,
    );
    if (result is Success<SemesterDataModel>) {
      emit(SpecificSemesterSuccess(semesterDataModel: result.data));
    } else if (result is Failure<SemesterDataModel>) {
      emit(SpecificSemesterError(apiErrorModel: result.apiErrorModel));
    }
  }
}
