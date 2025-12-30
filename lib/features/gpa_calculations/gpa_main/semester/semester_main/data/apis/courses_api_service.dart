import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_assistant/core/constants/database_constants.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/course_model.dart';

class CoursesApiService {
  CoursesApiService();

  DocumentReference<Map<String, dynamic>> getEmailRef(String email) =>
      FirebaseFirestore.instance
          .collection(DatabaseConstants.emailsCollection)
          .doc(email);

  Future<bool> checkIfCourseExist(
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

  Future<void> addCourse(
    String email,
    String semesterName,
    String courseName,
    double credits,
    String grade,
  ) async {
    final bool isCourseExist = await checkIfCourseExist(
      email,
      semesterName,
      courseName,
    );
    if (isCourseExist) throw Exception('Course Already Exist');
    final doc = await getEmailRef(email).get();
    final data = doc.data()!;
    final courses =
        data['semesters']?[semesterName]?['courses'] as Map<String, dynamic>? ??
        {};

    final nextIndex = courses.length;
    final courseMap = {
      ...CourseModel(
        name: courseName,
        searchName: courseName.toLowerCase().replaceAll(RegExp(r'\s+'), ''),
        credits: credits,
        grade: grade,
        index: nextIndex,
      ).toJson(),
    };
    await getEmailRef(email).set({
      'semesters': {
        semesterName: {
          'courses': {courseName: courseMap},
        },
      },
    }, SetOptions(merge: true));
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
