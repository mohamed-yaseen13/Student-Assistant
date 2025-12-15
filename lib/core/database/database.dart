import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_assistant/core/constants/database_constants.dart';

class Database {
  final FirebaseFirestore firestore;

  Database({required this.firestore});

  DocumentReference<Map<String, dynamic>> getEmailRef(String email) =>
      FirebaseFirestore.instance
          .collection(DatabaseConstants.emailsCollection)
          .doc(email);

  Future<bool> checkIfEmailExist(String email) async {
    final doc = await getEmailRef(email).get();
    return doc.exists;
  }

  Future<void> saveOtpToDatabase(String email, String otp) async {
    final expiresAt = DateTime.now().add(const Duration(minutes: 1));
    await getEmailRef(email).set({
      'otp': otp,
      "expiresAt": Timestamp.fromDate(expiresAt),
    }, SetOptions(merge: true));
  }

  Future<void> saveUsernameToDatabase(String email, String username) async {
    await getEmailRef(
      email,
    ).set({'username': username}, SetOptions(merge: true));
  }

  Future<bool> isOtpCorrect(String email, String otp) async {
    final doc = await getEmailRef(email).get();
    final String savedOtp = doc.data()!['otp'];
    final Timestamp expiresAtTs = doc.data()!['expiresAt'];
    final DateTime expiresAt = expiresAtTs.toDate();
    return savedOtp == otp && DateTime.now().isBefore(expiresAt);
  }

  Future<void> deleteOtp(String email) async {
    await getEmailRef(
      email,
    ).update({'otp': FieldValue.delete(), 'expiresAt': FieldValue.delete()});
  }

  Future<void> addSemester({
    required String email,
    required String semesterName,
  }) async {
    await getEmailRef(email).set({
      'semesters': {
        'name': semesterName,
        'gpa': 0.0,
        'cgpaOriginal': 0.0,
        'cgpaChanged': 0.0,
        'attemptedCredits': 0,
        'earnedCredits': 0,
        'note': '',
      },
    }, SetOptions(merge: true));
  }

  Future<bool> semesterExists(String email, String semesterName) async {
    final query = await getEmailRef(email)
        .collection(DatabaseConstants.semestersCollection)
        .where('name', isEqualTo: semesterName)
        .limit(1)
        .get();

    return query.docs.isNotEmpty;
  }
}
