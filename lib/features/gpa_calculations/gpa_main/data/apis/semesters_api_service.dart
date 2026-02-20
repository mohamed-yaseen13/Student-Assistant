import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/helpers/functions.dart';
import 'package:student_assistant/core/models/course_model.dart';
import 'package:student_assistant/core/models/semester_model.dart';

class SemestersApiService {
  SemestersApiService();

  Future<void> addSemester(String email, String semesterName) async {
    // variables i'll need
    final box = AppConstants.box;
    final student = box.values.first;
    // check if semester exist
    final exists = student.semesters.containsKey(semesterName);
    if (exists) {
      throw Exception('Semester Name Already Exists');
    }
    // create a new semester
    final newSemester = SemesterModel(
      name: semesterName,
      index: student.semesters.length,
    );
    // update the semesters and student model
    final updatedSemesters = Map<String, SemesterModel>.from(student.semesters);
    updatedSemesters[semesterName] = newSemester;
    final updatedStudent = student.copyWith(semesters: updatedSemesters);
    // update the hive box of student locally
    await box.put(email, updatedStudent);
    // update the firestore database
    await getEmailRef(
      email,
    ).update({'semesters.$semesterName': newSemester.toJson()});
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
    final box = AppConstants.box;
    final student = box.values.first;
    final semesters = student.semesters.values.toList();
    final updatedSemesters = Map<String, SemesterModel>.from(student.semesters);

    // check if the semesters to be deleted have a repeated course
    final hasRepeated = semestersToBeDeleted.any(
      (s) => s.courses.values.any((c) => c.isRepeated),
    );

    // get each semester of the semesters to be deleted
    for (var semester in semestersToBeDeleted) {
      if (hasRepeated) {
        // catch the repeated course
        for (var course in semester.courses.values) {
          if (course.isRepeated) {
            // update some attributes of the previous courses
            for (int i = lowestIndex - 1; i >= 0; i--) {
              for (var oldCourse in semesters[i].courses.values) {
                if (oldCourse.searchName == course.searchName) {
                  final oldSemesterName = semesters[i].name;
                  // update the local database
                  final updatedOldCourses = Map<String, CourseModel>.from(
                    updatedSemesters[oldSemesterName]!.courses,
                  );
                  final updatedOldCourse = oldCourse.copyWith(
                    isChanged: false,
                    newGrade: '--',
                  );
                  updatedOldCourses[oldCourse.name] = updatedOldCourse;
                  updatedSemesters[oldSemesterName] =
                      updatedSemesters[oldSemesterName]!.copyWith(
                        courses: updatedOldCourses,
                      );
                  // update the firestore database
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
      // update tha local database
      updatedSemesters.remove(semester.name);
      // update the data on firestore
      await docRef.update({'semesters.${semester.name}': FieldValue.delete()});
    }
    // update the local database
    final updatedStudent = student.copyWith(semesters: updatedSemesters);
    await box.put(email, updatedStudent);
  }

  List<SemesterModel> searchForCourse(String email, String searchName) {
    final box = AppConstants.box;
    final student = box.get(email);
    final semesters = student!.semesters.values;
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
    final box = AppConstants.box;
    final student = box.get(email)!;
    // check if the new semester name is exist
    if (student.semesters.containsKey(newSemesterName)) {
      throw Exception('Semester Name Already Exists');
    }
    // get the old semester and modify it
    final oldSemester = student.semesters[oldSemesterName]!;
    final updatedSemesters = Map<String, SemesterModel>.from(student.semesters);
    updatedSemesters.remove(oldSemesterName);
    final updatedSemester = oldSemester.copyWith(name: newSemesterName);
    updatedSemesters[newSemesterName] = updatedSemester;
    final updatedStudent = student.copyWith(semesters: updatedSemesters);
    await box.put(email, updatedStudent);
    // update the data on firestore
    await getEmailRef(email).update({
      'semesters.$newSemesterName': updatedSemester.toJson(),
      'semesters.$oldSemesterName': FieldValue.delete(),
    });
  }
}
