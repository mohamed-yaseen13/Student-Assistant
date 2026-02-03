import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_assistant/core/constants/database_constants.dart';
import 'package:student_assistant/core/helpers/grade.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/course_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/semester/semester_main/models/semester_model.dart';

class CoursesApiService {
  CoursesApiService();

  DocumentReference<Map<String, dynamic>> getEmailRef(String email) =>
      FirebaseFirestore.instance
          .collection(DatabaseConstants.emailsCollection)
          .doc(email);

  Future<List<SemesterModel>> getOrderedSemesters(String email) async {
    // variables i'll need
    final docRef = getEmailRef(email);
    // get all semesters from firestore
    final doc = await docRef.get();
    final semestersRaw = doc.data()?['semesters'];
    if (semestersRaw == null || semestersRaw is! Map) return [];
    // sort the semesters based on their index
    final list = semestersRaw.values
        .map((e) => SemesterModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    list.sort((a, b) => a.index.compareTo(b.index));
    return list;
  }

  Future<bool> checkIfCourseExistsInPreviousSemesters(
    String email,
    String courseName,
    int semesterIndex,
  ) async {
    final semesters = await getOrderedSemesters(email);
    final searchName = courseName.toLowerCase().replaceAll(RegExp(r'\s+'), '');
    for (int i = 0; i < semesterIndex; i++) {
      for (final course in semesters[i].courses.values) {
        if (course.searchName == searchName) {
          return true;
        }
      }
    }
    return false;
  }

  Future<void> addCourse({
    required String email,
    required String semesterName,
    required String courseName,
    required double credits,
    required String grade,
    required bool isRepeated,
    required int semesterIndex,
  }) async {
    // variables i'll need
    final docRef = getEmailRef(email);
    bool isFailedBefore = false;
    final newCourseSearchName = courseName.toLowerCase().replaceAll(
      RegExp(r'\s+'),
      '',
    );
    // check if course name exists in same semester
    final currentSemesterCourses = await getAllCourses(email, semesterName);
    final bool exist = currentSemesterCourses.any((c) => c.name == courseName);
    if (exist) {
      throw Exception('Course Name Already Exists');
    }
    // check is course name exists in previous semester
    if (isRepeated) {
      // update the repeated courses attribute of the current semester
      final semesters = await getOrderedSemesters(email);
      await docRef.update({
        'semesters.$semesterName.repeatedCourses':
            semesters[semesterIndex].repeatedCourses + 1,
      });
      // update some attributes of the previous courses
      for (int i = semesterIndex - 1; i >= 0; i--) {
        for (var oldCourse in semesters[i].courses.values) {
          if (oldCourse.searchName == newCourseSearchName) {
            final oldSemesterName = semesters[i].name;
            await docRef.update({
              'semesters.$oldSemesterName.courses.${oldCourse.name}.isChanged':
                  true,
              'semesters.$oldSemesterName.courses.${oldCourse.name}.newGrade':
                  grade,
            });
            if (Grade.getGradePoint(oldCourse.grade) == 0.0) {
              isFailedBefore = true;
            }
          }
        }
      }
    }
    // create a new course model
    final newCourse = CourseModel(
      name: courseName,
      index: currentSemesterCourses.length,
      searchName: newCourseSearchName,
      credits: credits,
      isFailedBefore: isFailedBefore,
      isRepeated: isRepeated,
      grade: grade,
    );
    // add the new course to firestore
    await docRef.update({
      'semesters.$semesterName.courses.$courseName': newCourse.toJson(),
    });
  }

  Future<List<CourseModel>> getAllCourses(
    String email,
    String semesterName,
  ) async {
    // variables i'll need
    final docRef = getEmailRef(email);
    // get all courses from firestore
    final doc = await docRef.get();
    final coursesRaw = doc.data()?['semesters']?[semesterName]?['courses'];
    if (coursesRaw == null || coursesRaw is! Map) return [];

    // sort the courses basec on their index
    final list = coursesRaw.values
        .map((e) => CourseModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    list.sort((a, b) => a.index.compareTo(b.index));
    return list;
  }

  Future<void> deleteCourses(
    String email,
    String semesterName,
    List<CourseModel> coursesToBeDeleted,
    int semesterIndex,
  ) async {
    // variables i'll need
    final docRef = getEmailRef(email);
    final hasRepeated = coursesToBeDeleted.any((c) => c.isRepeated);
    List<SemesterModel>? semesters;
    if (hasRepeated) {
      semesters = await getOrderedSemesters(email);
    }
    // check if the course to delete is repeated
    for (var course in coursesToBeDeleted) {
      if (course.isRepeated) {
        // update the repeated courses attribute of the current semester
        await docRef.update({
          'semesters.$semesterName.repeatedCourses':
              semesters![semesterIndex].repeatedCourses - 1,
        });
        // update some attributes of the previous courses
        for (int i = semesterIndex - 1; i >= 0; i--) {
          for (var oldCourse in semesters[i].courses.values) {
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
      // update the data on firestore
      await docRef.update({
        'semesters.$semesterName.courses.${course.name}': FieldValue.delete(),
      });
    }
  }

  Future<void> editCourse({
    required String email,
    required String semesterName,
    required String courseName,
    required int courseIndex,
    required bool isRepeated,
    required int semesterIndex,
    required String grade,
    required String oldCourseName,
    required double credits,
  }) async {
    // variables i'll need
    final docRef = getEmailRef(email);
    bool isFailedBefore = false;
    final newCourseSearchName = courseName.toLowerCase().replaceAll(
      RegExp(r'\s+'),
      '',
    );

    // check if the edited course name is exist in the same semester
    final currentSemesterCourses = await getAllCourses(email, semesterName);
    final bool exist = currentSemesterCourses
        .skipWhile((c) => c.index == courseIndex)
        .any((c) => c.name == courseName);
    if (exist) {
      throw Exception('Course Name Already Exists');
    }

    // check if the edited course name is exist in previous semester
    if (isRepeated) {
      // update the repeated courses attribute of the current semester
      final semesters = await getOrderedSemesters(email);
      await docRef.update({
        'semesters.$semesterName.repeatedCourses':
            semesters[semesterIndex].repeatedCourses + 1,
      });
      for (int i = 0; i < semesterIndex; i++) {
        for (var oldCourse in semesters[i].courses.values) {
          if (oldCourse.searchName == newCourseSearchName) {
            // update some attributes of the previous courses
            final oldSemesterName = semesters[i].name;
            await docRef.update({
              'semesters.$oldSemesterName.courses.${oldCourse.name}.isChanged':
                  true,
              'semesters.$oldSemesterName.courses.${oldCourse.name}.newGrade':
                  grade,
            });
            if (Grade.getGradePoint(oldCourse.grade) == 0.0) {
              isFailedBefore = true;
            }
          }
        }
      }
    }

    // create a new course model
    final newCourse = CourseModel(
      name: courseName,
      index: courseIndex,
      searchName: newCourseSearchName,
      credits: credits,
      isFailedBefore: isFailedBefore,
      isRepeated: isRepeated,
      grade: grade,
    );
    // add the new course to firestore
    await docRef.update({
      'semesters.$semesterName.courses.$oldCourseName': FieldValue.delete(),
      'semesters.$semesterName.courses.$courseName': newCourse.toJson(),
    });
  }
}
