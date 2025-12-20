import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_assistant/core/constants/database_constants.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/gpa_data_model.dart';

class GpaDataApiService {
  GpaDataApiService();

  DocumentReference<Map<String, dynamic>> getEmailRef(String email) =>
      FirebaseFirestore.instance
          .collection(DatabaseConstants.emailsCollection)
          .doc(email);

  Future<GpaDataModel> getGpaData(String email) async {
    final doc = await getEmailRef(email).get();
    final data = doc.data();
    final double cgpa = data!['cgpa'];
    final double totalCredits = data['totalCredits'];
    final double maxCgpa = data['maxCgpa'];
    return GpaDataModel(
      cgpa: cgpa,
      totalCredits: totalCredits,
      maxCgpa: maxCgpa,
    );
  }
}
