import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/data/repos/gpa_data_repo_imp.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/gpa_data_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/gpa_data_state.dart';

class GpaDataCubit extends Cubit<GpaDataState> {
  final GpaDataRepoImp gpaDataRepoImp;

  GpaDataCubit({required this.gpaDataRepoImp}) : super(GpaDataInitial());

  void getGpaData() async {
    emit(GpaDataLoading());
    final result = await gpaDataRepoImp.getGpaData();

    if (result is Success<GpaDataModel>) {
      emit(GpaDataSuccess(gpaDataModel: result.data));
    } else if (result is Failure<GpaDataModel>) {
      emit(GpaDataError(apiErrorModel: result.apiErrorModel));
    }
  }
}
