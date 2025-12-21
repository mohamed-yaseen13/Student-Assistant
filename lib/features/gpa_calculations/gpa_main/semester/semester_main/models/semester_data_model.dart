class SemesterDataModel {
  double attemptedCredits;
  double earnedCredits;
  double gpa;
  double maxGpa;

  SemesterDataModel({
    this.attemptedCredits = 0.0,
    this.earnedCredits = 0.0,
    this.gpa = 0.0,
    this.maxGpa = 0.0,
  });

  Map<String, dynamic> toJson() => {
    'attemptedCredits': attemptedCredits,
    'earnedCredits': earnedCredits,
    'gpa': gpa,
    'maxGpa': maxGpa,
  };

  factory SemesterDataModel.fromJson(Map<String, dynamic> json) =>
      SemesterDataModel(
        attemptedCredits: (json['attemptedCredits'] as num?)?.toDouble() ?? 0,
        earnedCredits: (json['earnedCredits'] as num?)?.toDouble() ?? 0,
        gpa: (json['gpa'] as num?)?.toDouble() ?? 0.0,
        maxGpa: (json['maxGpa'] as num?)?.toDouble() ?? 0.0,
      );

  SemesterDataModel copyWith({
    double? attemptedCredits,
    double? earnedCredits,
    double? gpa,
    double? maxGpa,
  }) {
    return SemesterDataModel(
      attemptedCredits: attemptedCredits ?? this.attemptedCredits,
      earnedCredits: earnedCredits ?? this.earnedCredits,
      gpa: gpa ?? this.gpa,
      maxGpa: maxGpa ?? this.maxGpa,
    );
  }
}
