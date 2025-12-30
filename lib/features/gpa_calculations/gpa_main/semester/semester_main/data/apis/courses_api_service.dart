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

  Future<bool> checkIfCourseExistInSameSemester(
    String email,
    String semesterName,
    String courseName,
  ) async {
    final doc = await getEmailRef(email).get();
    final data = doc.data();
    final semesters = data!['semesters'];
    final semester = semesters[semesterName];
    final courses = semester['courses'];
    if (courses == null || courses is! Map<String, dynamic>) {
      return false;
    }
    return courses.containsKey(courseName);
  }

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

  Future<void> addCourse(
    String email,
    String semesterName,
    String courseName,
    double credits,
    String grade,
    int semesterIndex,
  ) async {
    final bool existsInSameSemester = await checkIfCourseExistInSameSemester(
      email,
      semesterName,
      courseName,
    );
    if (existsInSameSemester) {
      throw Exception('Course Already Exist');
    }
    final searchName = courseName.toLowerCase().replaceAll(RegExp(r'\s+'), '');
    final semestersList = await getOrderedSemesters(email);
    bool isRepeated = false;
    bool isFailedBefore = false;
    for (int i = 0; i < semesterIndex; i++) {
      final semester = semestersList[i];
      final courses = Map<String, CourseModel>.from(semester.courses);
      for (final entry in courses.entries) {
        final oldCourse = entry.value;
        if (oldCourse.searchName == searchName) {
          isRepeated = true;
          oldCourse.isChanged = true;
          oldCourse.newGrade = grade == '--' ? oldCourse.grade : grade;
          if (Grade.getGradePoint(oldCourse.grade) == 0.0) {
            isFailedBefore = true;
          }
          courses[entry.key] = oldCourse;
          semestersList[i] = semester.copyWith(courses: courses);
          break;
        }
      }
    }
    final currentSemester = semestersList[semesterIndex];
    final currentCourses = Map<String, CourseModel>.from(
      currentSemester.courses,
    );
    final nextIndex = currentCourses.length;
    final newCourse = CourseModel(
      name: courseName,
      searchName: searchName,
      credits: credits,
      grade: grade,
      index: nextIndex,
      isRepeated: isRepeated,
      isFailedBefore: isFailedBefore,
    );
    currentCourses[courseName] = newCourse;
    semestersList[semesterIndex] = currentSemester.copyWith(
      courses: currentCourses,
    );
    final Map<String, dynamic> semestersMap = {
      for (final s in semestersList) s.name: s.toJson(),
    };
    await getEmailRef(
      email,
    ).set({'semesters': semestersMap}, SetOptions(merge: true));
  }

  Future<List<CourseModel>> getAllCourses(
    String email,
    String semesterName,
  ) async {
    final doc = await getEmailRef(email).get();
    final coursesRaw = doc.data()?['semesters']?[semesterName]?['courses'];
    if (coursesRaw == null || coursesRaw is! Map) return [];
    final list = coursesRaw.values
        .map((e) => CourseModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    list.sort((a, b) => a.index.compareTo(b.index));
    return list;
  }

  Future<void> deleteCourses(
    String email,
    String semesterName,
    List<String> coursesNames,
    int semesterIndex,
  ) async {
    final Map<String, dynamic> deletionMap = {
      for (var name in coursesNames) name: FieldValue.delete(),
    };
    await getEmailRef(email).set({
      'semesters': {
        semesterName: {'courses': deletionMap},
      },
    }, SetOptions(merge: true));
  }
}
