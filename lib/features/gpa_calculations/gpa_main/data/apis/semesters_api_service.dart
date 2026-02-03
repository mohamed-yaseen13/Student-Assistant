import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_assistant/core/constants/database_constants.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/models/semester_model.dart';

class SemestersApiService {
  SemestersApiService();

  DocumentReference<Map<String, dynamic>> getEmailRef(String email) =>
      FirebaseFirestore.instance
          .collection(DatabaseConstants.emailsCollection)
          .doc(email);

  Future<void> addSemester(String email, String semesterName) async {
    // check if semester name already exists
    final semesters = await getAllSemesters(email);
    final bool exists = semesters.any((s) => s.name == semesterName);
    if (exists) {
      throw Exception('Semester Name Already Exists');
    }

    // creating the new semester
    final newSemester = SemesterModel(
      name: semesterName,
      index: semesters.length,
    );

    // update the data on firestore
    await getEmailRef(
      email,
    ).update({'semesters.$semesterName': newSemester.toJson()});
  }

  Future<List<SemesterModel>> getAllSemesters(String email) async {
    // getting all semesters from firestore
    final doc = await getEmailRef(email).get();
    final semestersRaw = doc.data()?['semesters'];
    if (semestersRaw == null || semestersRaw is! Map) return [];

    // sorting semesters based on their index
    final list = semestersRaw.values
        .map((e) => SemesterModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    list.sort((a, b) => a.index.compareTo(b.index));
    return list;
  }

  Future<void> deleteSemesters(
    String email,
    List<SemesterModel> semestersToBeDeleted,
  ) async {
    // variables i'll need
    final docRef = getEmailRef(email);
    final int lowestIndex = semestersToBeDeleted
        .map((s) => s.index)
        .reduce((a, b) => a < b ? a : b);

    // check if the semesters to be deleted have a repeated course
    final hasRepeated = semestersToBeDeleted.any(
      (s) => s.courses.values.any((c) => c.isRepeated),
    );
    List<SemesterModel>? semesters;
    if (hasRepeated) {
      semesters = await getAllSemesters(email);
    }
    // get each semester of the semesters to be deleted
    for (var semester in semestersToBeDeleted) {
      if (hasRepeated) {
        // catch the repeated course
        for (var course in semester.courses.values) {
          if (course.isRepeated) {
            // update some attributes of the previous courses
            for (int i = lowestIndex - 1; i >= 0; i--) {
              for (var oldCourse in semesters![i].courses.values) {
                if (oldCourse.searchName == course.searchName) {
                  final oldSemesterName = semesters[i].name;
                  await docRef.update({
                    'semesters.$oldSemesterName.courses.${oldCourse.name}.isChanged':
                        false,
                    'semesters.$oldSemesterName.courses.${oldCourse.name}.newGrade':
                        '--',
                  });
                }
              }
            }
          }
        }
      }
      // update the data on firestore
      await docRef.update({'semesters.${semester.name}': FieldValue.delete()});
    }
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
    // check if the new semester name is exist
    final semesters = await getAllSemesters(email);
    final bool exists = semesters.any((s) => s.name == newSemesterName);
    if (exists) {
      throw Exception('Semester Name Already Exists');
    }

    // get the old semester and modify it
    final updatedSemester = semesters.firstWhere(
      (semester) => semester.name == oldSemesterName,
    );
    updatedSemester.name = newSemesterName;

    // update the data on firestore
    await getEmailRef(email).update({
      'semesters.$newSemesterName': updatedSemester.toJson(),
      'semesters.$oldSemesterName': FieldValue.delete(),
    });
  }
}
