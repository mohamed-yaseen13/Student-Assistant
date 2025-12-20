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
    final courseMap = {
      ...CourseModel(name: courseName, credits: credits, grade: grade).toJson(),
      'createdAt': FieldValue.serverTimestamp(),
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
    final data = doc.data();
    final semesters = data!['semesters'];
    final semester = semesters[semesterName];
    final coursesRow = semester['courses'];
    if (coursesRow == null || coursesRow is! Map) {
      return [];
    }
    final Map<String, dynamic> coursesMap = Map<String, dynamic>.from(
      coursesRow,
    );
    final List<MapEntry<String, dynamic>> entries = coursesMap.entries.toList();
    entries.sort((a, b) {
      final tsA = a.value['createdAt'] as Timestamp?;
      final tsB = b.value['createdAt'] as Timestamp?;
      if (tsA == null || tsB == null) return 0;
      return tsA.compareTo(tsB);
    });
    return entries
        .map((e) => CourseModel.fromJson(Map<String, dynamic>.from(e.value)))
        .toList();
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
