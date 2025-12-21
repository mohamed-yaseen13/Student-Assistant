import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_assistant/core/constants/database_constants.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/models/semester_model.dart';

class SemestersApiService {
  SemestersApiService();

  DocumentReference<Map<String, dynamic>> getEmailRef(String email) =>
      FirebaseFirestore.instance
          .collection(DatabaseConstants.emailsCollection)
          .doc(email);

  Future<bool> isSemesterExists(String email, String semesterName) async {
    final doc = await getEmailRef(email).get();
    final data = doc.data();
    final semesters = data!['semesters'];
    if (semesters == null || semesters is! Map<String, dynamic>) {
      return false;
    }
    return semesters.containsKey(semesterName);
  }

  Future<void> addSemester(String email, String semesterName) async {
    final bool isSemesterNameExist = await isSemesterExists(
      email,
      semesterName,
    );
    if (isSemesterNameExist) throw Exception('Semester Name Already Exists');
    final semesterMap = {
      ...SemesterModel(name: semesterName).toJson(),
      'createdAt': FieldValue.serverTimestamp(),
    };
    await getEmailRef(email).set({
      'semesters': {semesterName: semesterMap},
    }, SetOptions(merge: true));
  }

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

  Future<void> deleteSemesters(
    String email,
    List<String> semestersNames,
  ) async {
    final Map<String, dynamic> deletionMap = {
      for (var name in semestersNames) name: FieldValue.delete(),
    };
    await getEmailRef(
      email,
    ).set({'semesters': deletionMap}, SetOptions(merge: true));
  }

  Future<List<SemesterModel>> searchForCourse(
    String email,
    String searchName,
  ) async {
    final semesters = await getAllSemesters(email);
    final filtered = semesters.where((semester) {
      final hasMatch = semester.courses.values.any((course) {
        final match = course.searchName.contains(searchName);
        return match;
      });
      return hasMatch;
    }).toList();
    return filtered;
  }
}
