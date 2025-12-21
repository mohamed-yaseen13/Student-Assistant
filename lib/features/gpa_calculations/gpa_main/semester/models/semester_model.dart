import 'package:student_assistant/features/gpa_calculations/gpa_main/models/course_model.dart';

class SemesterModel {
  String name;
  double gpa;
  double maxGpa;
  Map<String, CourseModel> courses;
  double cgpaOriginal;
  double cgpaChanged;
  double attemptedCredits;
  double earnedCredits;
  String note;

  SemesterModel({
    required this.name,
    this.courses = const {},
    this.gpa = 0.0,
    this.maxGpa = 0.0,
    this.cgpaOriginal = 0.0,
    this.cgpaChanged = 0.0,
    this.attemptedCredits = 0.0,
    this.earnedCredits = 0.0,
    this.note = '',
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'gpa': gpa,
    'maxGpa': maxGpa,
    'courses': courses.map((k, v) => MapEntry(k, v.toJson())),
    'cgpaOriginal': cgpaOriginal,
    'cgpaChanged': cgpaChanged,
    'attemptedCredits': attemptedCredits,
    'earnedCredits': earnedCredits,
    'note': note,
  };

  factory SemesterModel.fromJson(Map<String, dynamic> json) {
    final rawCourses = json['courses'];

    return SemesterModel(
      name: json['name'] as String,
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
    );
  }

  SemesterModel copyWith({
    String? name,
    double? gpa,
    double? maxGpa,
    Map<String, CourseModel>? courses,
    double? cgpaOriginal,
    double? cgpaChanged,
    double? attemptedCredits,
    double? earnedCredits,
    String? note,
  }) {
    return SemesterModel(
      name: name ?? this.name,
      gpa: gpa ?? this.gpa,
      maxGpa: maxGpa ?? this.maxGpa,
      courses: courses ?? Map<String, CourseModel>.from(this.courses),
      cgpaOriginal: cgpaOriginal ?? this.cgpaOriginal,
      cgpaChanged: cgpaChanged ?? this.cgpaChanged,
      attemptedCredits: attemptedCredits ?? this.attemptedCredits,
      earnedCredits: earnedCredits ?? this.earnedCredits,
      note: note ?? this.note,
    );
  }
}
