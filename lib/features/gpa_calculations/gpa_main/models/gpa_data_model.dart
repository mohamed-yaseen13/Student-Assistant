class GpaDataModel {
  double cgpa;
  int totalCredits;
  double maxCgpa;

  GpaDataModel({this.cgpa = 0, this.totalCredits = 0, this.maxCgpa = 0});

  Map<String, dynamic> toJson() => {
    'cgpa': cgpa,
    'totalCredits': totalCredits,
    'maxCgpa': maxCgpa,
  };

  factory GpaDataModel.fromJson(Map<String, dynamic> json) => GpaDataModel(
    cgpa: (json['cgpa'] as num?)?.toDouble() ?? 0,
    totalCredits: (json['totalCredits'] as int?) ?? 0,
    maxCgpa: (json['maxCgpa'] as num?)?.toDouble() ?? 0,
  );

  GpaDataModel copyWith({double? cgpa, int? totalCredits, double? maxCgpa}) {
    return GpaDataModel(
      cgpa: cgpa ?? this.cgpa,
      totalCredits: totalCredits ?? this.totalCredits,
      maxCgpa: maxCgpa ?? this.maxCgpa,
    );
  }
}
