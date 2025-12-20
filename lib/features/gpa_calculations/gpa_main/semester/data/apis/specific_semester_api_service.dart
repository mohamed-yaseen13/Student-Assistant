import 'package:student_assistant/core/database/database.dart';
import 'package:student_assistant/core/helpers/shared_prefs.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/course_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/models/semester_data_model.dart';

class SpecificSemesterApiService {
  final Database database;

  SpecificSemesterApiService({required this.database});

  Future<SemesterDataModel> getSpecificSemesterData(String semesterName) async {
    final email = SharedPrefs.getUserEmail();
    return await database.getSpecificSemesterData(email, semesterName);
  }

  Future<void> addCourse(
    String semesterName,
    String courseName,
    double credits,
    String grade,
  ) async {
    final email = SharedPrefs.getUserEmail();
    final bool isCourseExist = await database.isCourseExist(
      email,
      semesterName,
      courseName,
    );
    if (isCourseExist) throw Exception('Course Already Exist');
    await database.addCourse(email, semesterName, courseName, credits, grade);
  }

  Future<List<CourseModel>> getAllCourses(String semesterName) async {
    final email = SharedPrefs.getUserEmail();
    return await database.getAllCourses(email, semesterName);
  }

  Future<void> deleteCourses(
    String semesterName,
    List<String> coursesNames,
  ) async {
    final email = SharedPrefs.getUserEmail();
    await database.deleteCourses(email, semesterName, coursesNames);
  }
}
