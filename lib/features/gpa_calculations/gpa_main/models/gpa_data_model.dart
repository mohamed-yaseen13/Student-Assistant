class GpaDataModel {
  double cgpa;
  int totalCredits;

  GpaDataModel({this.cgpa = 0, this.totalCredits = 0});

  Map<String, dynamic> toJson() => {'cgpa': cgpa, 'totalCredits': totalCredits};

  factory GpaDataModel.fromJson(Map<String, dynamic> json) => GpaDataModel(
    cgpa: (json['cgpa'] as num?)?.toDouble() ?? 0,
    totalCredits: (json['totalCredits'] as int?) ?? 0,
  );

  GpaDataModel copyWith({double? cgpa, int? totalCredits}) {
    return GpaDataModel(
      cgpa: cgpa ?? this.cgpa,
      totalCredits: totalCredits ?? this.totalCredits,
    );
  }
}
