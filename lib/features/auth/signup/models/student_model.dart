import 'package:student_assistant/features/gpa_calculations/gpa_main/models/semester_model.dart';

class StudentModel {
  String name;
  double cgpa;
  int totalCredits;
  List<SemesterModel> semesters;

  StudentModel({
    required this.name,
    this.cgpa = 0,
    this.semesters = const [],
    this.totalCredits = 0,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'cgpa': cgpa,
    'totalCredits': totalCredits,
    'semesters': semesters.map((s) => s.toJson()).toList(),
  };

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    name: json['name'] as String,
    cgpa: (json['cgpa'] as num?)?.toDouble() ?? 0,
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
  }) {
    return StudentModel(
      name: name ?? this.name,
      cgpa: cgpa ?? this.cgpa,
      totalCredits: totalCredits ?? this.totalCredits,
      semesters: semesters ?? List<SemesterModel>.from(this.semesters),
    );
  }
}
