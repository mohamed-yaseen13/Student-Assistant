import 'package:student_assistant/core/database/database.dart';
import 'package:student_assistant/core/helpers/shared_prefs.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/semester_model.dart';

class GpaMainApiService {
  final Database database;

  GpaMainApiService({required this.database});

  Future<void> addSemester(String semesterName) async {
    final String email = SharedPrefs.getUserEmail();
    final bool isSemesterNameExist = await database.semesterExists(
      email,
      semesterName,
    );
    if (isSemesterNameExist) throw Exception('Semester Name Already Exists');
    await database.addSemester(email: email, semesterName: semesterName);
  }

  Future<List<SemesterModel>> getAllSemesters() async {
    final String email = SharedPrefs.getUserEmail();
    return await database.getAllSemesters(email);
  }
}
