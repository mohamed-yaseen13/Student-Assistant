import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/helpers/functions.dart';
import 'package:student_assistant/core/helpers/grade.dart';
import 'package:student_assistant/core/models/course_model.dart';
import 'package:student_assistant/core/models/semester_model.dart';

class CoursesApiService {
  CoursesApiService();

  Future<bool> checkIfCourseExistsInPreviousSemesters(
    String email,
    String courseName,
    int semesterIndex,
  ) async {
    final box = AppConstants.box;
    final student = box.values.first;
    final semesters = student.semesters.values.toList();
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
    final box = AppConstants.box;
    final student = box.values.first;
    final semesters = student.semesters.values.toList();
    final updatedSemesters = Map<String, SemesterModel>.from(student.semesters);
    final newCourseSearchName = courseName.toLowerCase().replaceAll(
      RegExp(r'\s+'),
      '',
    );
    bool isFailedBefore = false;
    // check if course name exists in same semester
    final currentSemester = updatedSemesters[semesterName]!;
    final updatedCourses = Map<String, CourseModel>.from(
      currentSemester.courses,
    );
    if (updatedCourses.containsKey(courseName)) {
      throw Exception('Course Name Already Exists');
    }
    // check is course name exists in previous semester
    if (isRepeated) {
      // update the local database
      currentSemester.repeatedCourses = currentSemester.repeatedCourses + 1;
      // update the repeated courses attribute of the current semester
      await docRef.update({
        'semesters.$semesterName.repeatedCourses':
            currentSemester.repeatedCourses + 1,
      });
      // update some attributes of the previous courses
      for (int i = semesterIndex - 1; i >= 0; i--) {
        for (var oldCourse in semesters[i].courses.values) {
          if (oldCourse.searchName == newCourseSearchName) {
            final oldSemesterName = semesters[i].name;
            // update the local database
            final updatedOldCourses = Map<String, CourseModel>.from(
              semesters[i].courses,
            );
            final updatedOldCourse = oldCourse.copyWith(
              isChanged: true,
              newGrade: grade,
            );
            updatedOldCourses[oldCourse.name] = updatedOldCourse;

            updatedSemesters[oldSemesterName] = semesters[i].copyWith(
              courses: updatedOldCourses,
            );
            // update firestore database
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
      index: updatedCourses.length,
      searchName: newCourseSearchName,
      credits: credits,
      isFailedBefore: isFailedBefore,
      isRepeated: isRepeated,
      grade: grade,
    );
    // update the local database
    updatedCourses[courseName] = newCourse;
    updatedSemesters[semesterName] = currentSemester.copyWith(
      courses: updatedCourses,
    );
    final updatedStudent = student.copyWith(semesters: updatedSemesters);
    await box.put(email, updatedStudent);
    // add the new course to firestore
    await docRef.update({
      'semesters.$semesterName.courses.$courseName': newCourse.toJson(),
    });
  }

  Future<void> deleteCourses(
    String email,
    String semesterName,
    List<CourseModel> coursesToBeDeleted,
    int semesterIndex,
  ) async {
    // variables i'll need
    final docRef = getEmailRef(email);
    final box = AppConstants.box;
    final student = box.values.first;
    final semesters = student.semesters.values.toList();
    final updatedSemesters = Map<String, SemesterModel>.from(student.semesters);
    final currentSemester = updatedSemesters[semesterName]!;
    final updatedCourses = Map<String, CourseModel>.from(
      currentSemester.courses,
    );

    // check if the course to delete is repeated
    for (var course in coursesToBeDeleted) {
      if (course.isRepeated) {
        // update the local database
        currentSemester.repeatedCourses =
            semesters[semesterIndex].repeatedCourses - 1;
        // update the repeated courses attribute of the current semester
        await docRef.update({
          'semesters.$semesterName.repeatedCourses':
              semesters[semesterIndex].repeatedCourses - 1,
        });
        // update some attributes of the previous courses
        for (int i = semesterIndex - 1; i >= 0; i--) {
          for (var oldCourse in semesters[i].courses.values) {
            if (oldCourse.searchName == course.searchName) {
              final oldSemesterName = semesters[i].name;
              // update the local dtabase
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
              // update firestore database
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
      // update the local database
      updatedCourses.remove(course.name);
      // update the data on firestore
      await docRef.update({
        'semesters.$semesterName.courses.${course.name}': FieldValue.delete(),
      });
    }
    updatedSemesters[semesterName] = currentSemester.copyWith(
      courses: updatedCourses,
    );
    await box.put(email, student.copyWith(semesters: updatedSemesters));
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
    final box = AppConstants.box;
    final student = box.values.first;
    final semesters = student.semesters.values.toList();
    final updatedSemesters = Map<String, SemesterModel>.from(student.semesters);
    final currentSemester = updatedSemesters[semesterName]!;
    final updatedCourses = Map<String, CourseModel>.from(
      currentSemester.courses,
    );
    // check if the edited course name is exist in the same semester
    final bool exist = updatedCourses.values
        .skipWhile((c) => c.index == courseIndex)
        .any((c) => c.name == courseName);
    if (exist) {
      throw Exception('Course Name Already Exists');
    }

    // check if the edited course name is exist in previous semester
    if (isRepeated) {
      // update the repeated courses attribute of the current semester
      // local
      currentSemester.repeatedCourses =
          semesters[semesterIndex].repeatedCourses + 1;
      // firestore
      await docRef.update({
        'semesters.$semesterName.repeatedCourses':
            semesters[semesterIndex].repeatedCourses + 1,
      });
      for (int i = 0; i < semesterIndex; i++) {
        for (var oldCourse in semesters[i].courses.values) {
          if (oldCourse.searchName == newCourseSearchName) {
            // update some attributes of the previous courses
            final oldSemesterName = semesters[i].name;
            // local
            final updatedOldCourses = Map<String, CourseModel>.from(
              updatedSemesters[oldSemesterName]!.courses,
            );
            final updatedOldCourse = oldCourse.copyWith(
              isChanged: true,
              newGrade: grade,
            );
            updatedOldCourses[oldCourse.name] = updatedOldCourse;
            updatedSemesters[oldSemesterName] =
                updatedSemesters[oldSemesterName]!.copyWith(
                  courses: updatedOldCourses,
                );
            // firestore
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
    // local
    updatedCourses[courseName] = newCourse;
    updatedCourses.remove(oldCourseName);
    updatedSemesters[semesterName] = currentSemester.copyWith(
      courses: updatedCourses,
    );
    await box.put(email, student.copyWith(semesters: updatedSemesters));
    // add the new course to firestore
    await docRef.update({
      'semesters.$semesterName.courses.$courseName': newCourse.toJson(),
      'semesters.$semesterName.courses.$oldCourseName': FieldValue.delete(),
    });
  }
}
