import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/features/gpa_calculations/data/repos/gpa_calculations_repo_imp.dart';
import 'package:student_assistant/features/gpa_calculations/presentation/cubits/gpa_calculations_state.dart';

class GpaCalculationsCubit extends Cubit<GpaCalculationsState> {
  final GpaCalculationsRepoImp gpaCalculationsRepoImp;

  GpaCalculationsCubit({required this.gpaCalculationsRepoImp})
    : super(GpaCalculationsInitial());

  Future<void> calculateGpaAndCgpa() async {
    emit(GpaCalculationsLoading());
    final result = await gpaCalculationsRepoImp.calculateGpaAndCgpa();
    if (result is Success<void>) {
      emit(GpaCalculationsSuccess());
    } else if (result is Failure<void>) {
      emit(GpaCalculationsError(apiErrorModel: result.apiErrorModel));
    }
  }
}
