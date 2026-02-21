import 'package:student_assistant/core/models/searched_course_model.dart';
import 'package:student_assistant/core/models/semester_model.dart';

class SearchedCourseMapper {
  static List<SearchedCourseModel> toSearchedCourseModel(
    List<SemesterModel> semesters,
    String searchName,
  ) {
    final List<SearchedCourseModel> result = [];

    for (final semester in semesters) {
      for (final course in semester.courses.values) {
        if (course.searchName.contains(searchName)) {
          result.add(
            SearchedCourseModel(
              semesterName: semester.name,
              courseName: course.name,
              semesterIndex: semester.index,
            ),
          );
        }
      }
    }

    return result;
  }
}
