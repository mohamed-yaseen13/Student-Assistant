import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/data/repos/scales_repo_imp.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/cubits/scales_state.dart';

class ScalesCubit extends Cubit<ScalesState> {
  final ScalesRepoImp scalesRepoImp;

  ScalesCubit({required this.scalesRepoImp}) : super(ScalesInitial());

  void saveScale({
    required String title,
    required List<List<String>> rows,
    String? oldTitle,
  }) async {
    emit(ScalesSaveScaleLoading());
    final result = await scalesRepoImp.saveScale(
      title: title,
      rows: rows,
      oldTitle: oldTitle,
    );
    if (result is Success<void>) {
      emit(ScalesSaveScaleSuccess());
    } else if (result is Failure<void>) {
      emit(ScalesSaveScaleError(apiErrorModel: result.apiErrorModel));
    }
  }

  void deleteScale(String title) async {
    emit(ScalesDeleteScaleLoading());
    final result = await scalesRepoImp.deleteScale(title);
    if (result is Success<void>) {
      emit(ScalesDeleteScaleSuccess());
    } else if (result is Failure<void>) {
      emit(ScalesDeleteScaleError(apiErrorModel: result.apiErrorModel));
    }
  }

  void changeScale(String title) async {
    emit(ScalesChangeScaleLoading());
    final result = await scalesRepoImp.changeScale(title);
    if (result is Success<void>) {
      emit(ScalesChangeScaleSuccess());
    } else if (result is Failure<void>) {
      emit(ScalesChangeScaleError(apiErrorModel: result.apiErrorModel));
    }
  }
}
