import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_assistant/core/constants/database_constants.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/models/semester_data_model.dart';

class SemesterDataApiService {
  SemesterDataApiService();

  DocumentReference<Map<String, dynamic>> getEmailRef(String email) =>
      FirebaseFirestore.instance
          .collection(DatabaseConstants.emailsCollection)
          .doc(email);

  Future<SemesterDataModel> getSemesterData(
    String email,
    String semesterName,
  ) async {
    final doc = await getEmailRef(email).get();
    final data = doc.data();
    final Map<String, dynamic> semestersMap = Map<String, dynamic>.from(
      data!['semesters'],
    );
    final Map<String, dynamic> semesterData = Map<String, dynamic>.from(
      semestersMap[semesterName],
    );
    final double attemptedCredits = semesterData['attemptedCredits'];
    final double earnedCredits = semesterData['earnedCredits'];
    final double gpa = semesterData['gpa'];
    final double maxGpa = semesterData['maxGpa'];
    return SemesterDataModel(
      attemptedCredits: attemptedCredits,
      earnedCredits: earnedCredits,
      gpa: gpa,
      maxGpa: maxGpa,
    );
  }
}
