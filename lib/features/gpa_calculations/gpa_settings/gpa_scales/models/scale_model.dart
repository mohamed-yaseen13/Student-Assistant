class ScaleModel {
  Map<String, Map<String, double>> grades;
  bool isSelected;
  String title;

  ScaleModel({
    required this.title,
    required this.grades,
    this.isSelected = false,
  });

  Map<String, dynamic> toMap() {
    return {"title": title, "isSelected": isSelected, "grades": grades};
  }

  Map<String, dynamic> toJson() => toMap();

  factory ScaleModel.fromJson(Map<String, dynamic> json) {
    return ScaleModel(
      title: json["title"] as String,
      isSelected: json["isSelected"] ?? false,
      grades: (json["grades"] as Map).map(
        (range, value) => MapEntry(range, Map<String, double>.from(value)),
      ),
    );
  }

  ScaleModel copyWith({
    String? title,
    Map<String, Map<String, double>>? grades,
    bool? isSelected,
  }) {
    return ScaleModel(
      title: title ?? this.title,
      grades: grades ?? Map.from(this.grades),
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
