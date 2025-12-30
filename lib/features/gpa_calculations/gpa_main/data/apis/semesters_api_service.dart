import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_assistant/core/constants/database_constants.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/models/semester_model.dart';

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
    final doc = await getEmailRef(email).get();
    final data = doc.data();
    final semesters = data?['semesters'] as Map<String, dynamic>? ?? {};
    final nextIndex = semesters.length;
    final semesterMap = {
      ...SemesterModel(name: semesterName, index: nextIndex).toJson(),
    };
    await getEmailRef(email).set({
      'semesters': {semesterName: semesterMap},
    }, SetOptions(merge: true));
  }

  Future<List<SemesterModel>> getAllSemesters(String email) async {
    final doc = await getEmailRef(email).get();
    final semestersRaw = doc.data()?['semesters'];
    if (semestersRaw == null || semestersRaw is! Map) return [];
    final list = semestersRaw.values
        .map((e) => SemesterModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    list.sort((a, b) => a.index.compareTo(b.index));
    return list;
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

  Future<void> editSemesterName(
    String email,
    String oldSemesterName,
    String newSemesterName,
  ) async {
    final docRef = getEmailRef(email);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      final data = snapshot.data();
      final Map<String, dynamic> semesters = Map<String, dynamic>.from(
        data!['semesters'],
      );
      if (semesters.containsKey(newSemesterName)) {
        throw Exception('Semester Name Already Exists');
      }
      final Map<String, dynamic> semesterData = Map<String, dynamic>.from(
        semesters[oldSemesterName],
      );
      semesterData['name'] = newSemesterName;
      transaction.set(docRef, {
        'semesters': {newSemesterName: semesterData},
      }, SetOptions(merge: true));
      transaction.set(docRef, {
        'semesters': {oldSemesterName: FieldValue.delete()},
      }, SetOptions(merge: true));
    });
  }
}
