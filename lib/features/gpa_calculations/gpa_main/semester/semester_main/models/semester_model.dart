import 'package:student_assistant/features/gpa_calculations/gpa_main/models/course_model.dart';

class SemesterModel {
  String name;
  int index;
  double gpa;
  double maxGpa;
  Map<String, CourseModel> courses;
  double cgpaOriginal;
  double cgpaChanged;
  double attemptedCredits;
  double earnedCredits;
  String note;
  int repeatedCourses;

  SemesterModel({
    required this.name,
    required this.index,
    this.courses = const {},
    this.gpa = 0.0,
    this.maxGpa = 0.0,
    this.cgpaOriginal = 0.0,
    this.cgpaChanged = 0.0,
    this.attemptedCredits = 0.0,
    this.earnedCredits = 0.0,
    this.note = '',
    this.repeatedCourses = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'index': index,
      'gpa': gpa,
      'maxGpa': maxGpa,
      'cgpaOriginal': cgpaOriginal,
      'cgpaChanged': cgpaChanged,
      'courses': courses.map((key, course) => MapEntry(key, course.toMap())),
      'repeatedCourses': repeatedCourses,
    };
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'index': index,
    'gpa': gpa,
    'maxGpa': maxGpa,
    'courses': courses.map((k, v) => MapEntry(k, v.toJson())),
    'cgpaOriginal': cgpaOriginal,
    'cgpaChanged': cgpaChanged,
    'attemptedCredits': attemptedCredits,
    'earnedCredits': earnedCredits,
    'note': note,
    'repeatedCourses': repeatedCourses,
  };

  factory SemesterModel.fromJson(Map<String, dynamic> json) {
    final rawCourses = json['courses'];

    return SemesterModel(
      name: json['name'] as String,
      index: json['index'] ?? 0,
      gpa: (json['gpa'] as num?)?.toDouble() ?? 0,
      maxGpa: (json['maxGpa'] as num?)?.toDouble() ?? 0,
      cgpaOriginal: (json['cgpaOriginal'] as num?)?.toDouble() ?? 0,
      cgpaChanged: (json['cgpaChanged'] as num?)?.toDouble() ?? 0,
      attemptedCredits: (json['attemptedCredits'] as num?)?.toDouble() ?? 0,
      earnedCredits: (json['earnedCredits'] as num?)?.toDouble() ?? 0,
      note: json['note'] as String? ?? '',
      courses: rawCourses is Map
          ? rawCourses.map(
              (k, v) => MapEntry(
                k,
                CourseModel.fromJson(Map<String, dynamic>.from(v)),
              ),
            )
          : {},
      repeatedCourses: json['repeatedCourses'] ?? 0,
    );
  }

  SemesterModel copyWith({
    String? name,
    int? index,
    double? gpa,
    double? maxGpa,
    Map<String, CourseModel>? courses,
    double? cgpaOriginal,
    double? cgpaChanged,
    double? attemptedCredits,
    double? earnedCredits,
    String? note,
    int? repeatedCourses,
  }) {
    return SemesterModel(
      name: name ?? this.name,
      index: index ?? this.index,
      gpa: gpa ?? this.gpa,
      maxGpa: maxGpa ?? this.maxGpa,
      courses: courses ?? Map<String, CourseModel>.from(this.courses),
      cgpaOriginal: cgpaOriginal ?? this.cgpaOriginal,
      cgpaChanged: cgpaChanged ?? this.cgpaChanged,
      attemptedCredits: attemptedCredits ?? this.attemptedCredits,
      earnedCredits: earnedCredits ?? this.earnedCredits,
      note: note ?? this.note,
      repeatedCourses: repeatedCourses ?? this.repeatedCourses,
    );
  }
}
