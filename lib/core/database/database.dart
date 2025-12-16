import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_assistant/core/constants/database_constants.dart';
import 'package:student_assistant/features/auth/signup/models/student_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/gpa_data_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/semester_model.dart';

class Database {
  final FirebaseFirestore firestore;

  Database({required this.firestore});

  DocumentReference<Map<String, dynamic>> getEmailRef(String email) =>
      FirebaseFirestore.instance
          .collection(DatabaseConstants.emailsCollection)
          .doc(email);

  // Auth
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

  Future<void> saveStudentToDatabase(String email, String username) async {
    final studentMap = {
      ...StudentModel(name: username).toJson(),
      'createdAt': FieldValue.serverTimestamp(),
    };
    await getEmailRef(email).set(studentMap, SetOptions(merge: true));
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

  // GPA Main

  // Add Semester
  Future<void> addSemester({
    required String email,
    required String semesterName,
  }) async {
    final semesterMap = {
      ...SemesterModel(name: semesterName).toJson(),
      'createdAt': FieldValue.serverTimestamp(),
    };
    await getEmailRef(email).set({
      'semesters': {semesterName: semesterMap},
    }, SetOptions(merge: true));
  }

  // Check if Semester exists
  Future<bool> semesterExists(String email, String semesterName) async {
    final doc = await getEmailRef(email).get();
    final data = doc.data();
    final semesters = data!['semesters'];
    if (semesters == null || semesters is! Map<String, dynamic>) {
      return false;
    }
    return semesters.containsKey(semesterName);
  }

  // Get All Semesters
  Future<List<SemesterModel>> getAllSemesters(String email) async {
    final doc = await getEmailRef(email).get();
    final data = doc.data();
    final semestersRaw = data!['semesters'];
    if (semestersRaw == null || semestersRaw is! Map) {
      return [];
    }
    final Map<String, dynamic> semestersMap = Map<String, dynamic>.from(
      semestersRaw,
    );
    final List<MapEntry<String, dynamic>> entries = semestersMap.entries
        .toList();
    entries.sort((a, b) {
      final tsA = a.value['createdAt'] as Timestamp?;
      final tsB = b.value['createdAt'] as Timestamp?;
      if (tsA == null || tsB == null) return 0;
      return tsA.compareTo(tsB);
    });
    return entries
        .map((e) => SemesterModel.fromJson(Map<String, dynamic>.from(e.value)))
        .toList();
  }

  // Get GPA Data
  Future<GpaDataModel> getGpaData(String email) async {
    final doc = await getEmailRef(email).get();
    final data = doc.data();
    final double cgpa = data!['cgpa'];
    final int totalCredits = data['totalCredits'];
    final double maxCgpa = data['maxCgpa'];
    return GpaDataModel(
      cgpa: cgpa,
      totalCredits: totalCredits,
      maxCgpa: maxCgpa,
    );
  }
}
