import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/course/data/repos/sections_repo_imp.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/course/presentation/cubit/sections_state.dart';

class SectionsCubit extends Cubit<SectionsState> {
  final SectionsRepoImp sectionsRepoImp;

  SectionsCubit({required this.sectionsRepoImp}) : super(SectionsInitial());

  void addSection({
    required String semesterName,
    required String courseName,
    required String sectionName,
    required double got,
    required int from,
  }) async {
    emit(SectionsAddSectionLoading());
    final result = await sectionsRepoImp.addSection(
      semesterName: semesterName,
      courseName: courseName,
      sectionName: sectionName,
      got: got,
      from: from,
    );
    if (result is Success<void>) {
      emit(SectionsAddSectionSuccess());
    } else if (result is Failure<void>) {
      emit(SectionsAddSectionError(apiErrorModel: result.apiErrorModel));
    }
  }
}
