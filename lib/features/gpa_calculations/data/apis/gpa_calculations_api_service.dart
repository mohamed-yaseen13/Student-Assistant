import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_assistant/core/constants/database_constants.dart';
import 'package:student_assistant/core/helpers/grade.dart';
import 'package:student_assistant/features/auth/signup/models/student_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/models/semester_model.dart';

class GpaCalculationsApiService {
  GpaCalculationsApiService();

  DocumentReference<Map<String, dynamic>> getEmailRef(String email) =>
      FirebaseFirestore.instance
          .collection(DatabaseConstants.emailsCollection)
          .doc(email);

  Future<List<SemesterModel>> getOrderedSemesters(String email) async {
    final doc = await getEmailRef(email).get();
    final semestersRaw = doc.data()?['semesters'];
    if (semestersRaw == null || semestersRaw is! Map) return [];
    final list = semestersRaw.values
        .map((e) => SemesterModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    list.sort((a, b) => a.index.compareTo(b.index));
    return list;
  }

  Future<void> calculateGpaAndCgpa(String email) async {
    double totalCredits = 0.0;
    double cgpaPointsOriginal = 0.0;
    double cgpaPointsChanged = 0.0;
    double cgpaCredits = 0.0;

    final doc = await getEmailRef(email).get();
    final student = StudentModel.fromJson(doc.data()!);

    final semestersList = await getOrderedSemesters(email);
    final Map<String, SemesterModel> updatedSemesters = {};

    for (int s = 0; s < semestersList.length; s++) {
      final semester = semestersList[s];

      double gpaPoints = 0.0;
      double gpaCredits = 0.0;
      double earnedCredits = 0.0;
      bool hasRepeatedAndChanged = semester.courses.values.any(
        (c) => c.isRepeated && c.isChanged,
      );

      if (hasRepeatedAndChanged) {
        for (int i = s; i >= 0; i--) {
          for (final course in semestersList[i].courses.values) {
            if (!course.isRepeated) continue;
            outerloop:
            for (int j = i - 1; j >= 0; j--) {
              for (final oldCourse in semestersList[j].courses.values) {
                if (oldCourse.searchName == course.searchName) {
                  cgpaPointsOriginal +=
                      Grade.getGradePoint(course.grade) * course.credits -
                      Grade.getGradePoint(oldCourse.grade) * oldCourse.credits;
                  break outerloop;
                }
              }
            }
          }
        }
      } else {
        for (final course in semester.courses.values) {
          if (course.isRepeated) {
            cgpaPointsOriginal = cgpaPointsChanged;
            break;
          }
        }
      }

      for (final course in semester.courses.values) {
        if (course.grade == '--') {
          gpaCredits += course.credits;
          continue;
        }

        gpaPoints += Grade.getGradePoint(course.grade) * course.credits;
        gpaCredits += course.credits;
        earnedCredits +=
            course.isRepeated ||
                (course.isChanged &&
                    Grade.getGradePoint(course.newGrade) == 0 &&
                    Grade.getGradePoint(course.grade) == 0) ||
                (!course.isChanged && Grade.getGradePoint(course.grade) == 0)
            ? 0.0
            : course.credits;
        if (!course.isRepeated) {
          cgpaPointsOriginal +=
              Grade.getGradePoint(course.grade) * course.credits;
          cgpaCredits += course.credits;
          cgpaPointsChanged +=
              course.isChanged && Grade.getGradePoint(course.newGrade) != 0
              ? Grade.getGradePoint(course.newGrade) * course.credits
              : Grade.getGradePoint(course.grade) * course.credits;
        }
      }
      totalCredits += earnedCredits;
      final gpa = gpaCredits > 0 ? gpaPoints / gpaCredits : 0.0;
      final cgpaOriginal = cgpaCredits > 0
          ? cgpaPointsOriginal / cgpaCredits
          : 0.0;
      final cgpaChanged = cgpaCredits > 0
          ? cgpaPointsChanged / cgpaCredits
          : 0.0;
      updatedSemesters[semester.name] = semester.copyWith(
        gpa: double.parse(gpa.toStringAsFixed(2)),
        cgpaOriginal: double.parse(cgpaOriginal.toStringAsFixed(2)),
        cgpaChanged: double.parse(cgpaChanged.toStringAsFixed(2)),
        attemptedCredits: gpaCredits,
        earnedCredits: earnedCredits,
      );
    }
    final lastSemester = semestersList.isNotEmpty ? semestersList.last : null;
    final finalCgpa = lastSemester != null
        ? updatedSemesters[lastSemester.name]!.cgpaChanged
        : 0.0;
    await getEmailRef(email).set(
      student
          .copyWith(
            cgpa: double.parse(finalCgpa.toStringAsFixed(2)),
            totalCredits: totalCredits,
            semesters: updatedSemesters,
          )
          .toJson(),
      SetOptions(merge: true),
    );
  }
}
