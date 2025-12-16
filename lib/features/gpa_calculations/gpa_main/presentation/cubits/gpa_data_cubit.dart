import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/data/repos/gpa_main_repo_imp.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/gpa_data_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/gpa_data_state.dart';

class GpaDataCubit extends Cubit<GpaDataState> {
  final GpaMainRepoImp gpaMainRepoImp;

  GpaDataCubit({required this.gpaMainRepoImp}) : super(GpaDataInitial());

  Future<void> getGpaData() async {
    emit(GpaDataLoading());
    final result = await gpaMainRepoImp.getGpaData();

    if (result is Success<GpaDataModel>) {
      emit(GpaDataSuccess(gpaDataModel: result.data));
    } else if (result is Failure<GpaDataModel>) {
      emit(GpaDataError(apiErrorModel: result.apiErrorModel));
    }
  }
}
