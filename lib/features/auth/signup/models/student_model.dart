import 'package:student_assistant/features/gpa_calculations/gpa_main/models/semester_model.dart';

class StudentModel {
  String name;
  double cgpa;
  int totalCredits;
  double maxCgpa;
  List<SemesterModel> semesters;

  StudentModel({
    required this.name,
    this.cgpa = 0,
    this.semesters = const [],
    this.totalCredits = 0,
    this.maxCgpa = 0,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'cgpa': cgpa,
    'totalCredits': totalCredits,
    'semesters': semesters.map((s) => s.toJson()).toList(),
    'maxCgpa': maxCgpa,
  };

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    name: json['name'] as String,
    cgpa: (json['cgpa'] as num?)?.toDouble() ?? 0,
    maxCgpa: (json['maxCgpa'] as num?)?.toDouble() ?? 0,
    totalCredits: (json['totalCredits'] as int?) ?? 0,
    semesters:
        (json['semesters'] as List<dynamic>?)
            ?.map((s) => SemesterModel.fromJson(s as Map<String, dynamic>))
            .toList() ??
        [],
  );

  StudentModel copyWith({
    String? name,
    double? cgpa,
    int? totalCredits,
    List<SemesterModel>? semesters,
    double? maxCgpa,
  }) {
    return StudentModel(
      name: name ?? this.name,
      cgpa: cgpa ?? this.cgpa,
      totalCredits: totalCredits ?? this.totalCredits,
      semesters: semesters ?? List<SemesterModel>.from(this.semesters),
      maxCgpa: maxCgpa ?? this.maxCgpa,
    );
  }
}
