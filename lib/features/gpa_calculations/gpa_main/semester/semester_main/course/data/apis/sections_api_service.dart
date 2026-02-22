import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/helpers/functions.dart';
import 'package:student_assistant/core/models/course_model.dart';
import 'package:student_assistant/core/models/section_model.dart';
import 'package:student_assistant/core/models/semester_model.dart';

class SectionsApiService {
  SectionsApiService();

  Future<void> addSection({
    required String email,
    required String semesterName,
    required String courseName,
    required String sectionName,
    required double got,
    required int from,
  }) async {
    // variables i'll need
    final docRef = getEmailRef(email);
    final box = AppConstants.box;
    final student = box.values.first;
    final updatedSemesters = Map<String, SemesterModel>.from(student.semesters);
    final currentSemester = updatedSemesters[semesterName]!;
    final updatedCourses = Map<String, CourseModel>.from(
      currentSemester.courses,
    );
    final currentCourse = updatedCourses[courseName]!;
    final updatedSections = Map<String, SectionModel>.from(
      currentCourse.sections,
    );
    // create the new section
    final newSection = SectionModel(
      name: sectionName,
      index: updatedSections.length,
      obtainedMark: got,
      fullMark: from,
    );
    // add the new section
    updatedSections[sectionName] = newSection;
    updatedCourses[courseName] = currentCourse.copyWith(
      sections: updatedSections,
    );
    updatedSemesters[semesterName] = currentSemester.copyWith(
      courses: updatedCourses,
    );
    // put the new section into the hive box
    await box.put(email, student.copyWith(semesters: updatedSemesters));
    // update the firestore database
    await docRef.update({
      'semesters.$semesterName.courses.$courseName.sections.$sectionName':
          newSection.toJson(),
    });
  }
}
