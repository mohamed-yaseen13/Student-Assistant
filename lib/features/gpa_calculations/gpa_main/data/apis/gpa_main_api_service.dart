import 'package:student_assistant/core/database/database.dart';
import 'package:student_assistant/core/helpers/shared_prefs.dart';

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
}
