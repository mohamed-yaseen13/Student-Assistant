import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/style/app_colors.dart';
import 'package:student_assistant/core/models/scale_model.dart';

class ScaleTable extends StatelessWidget {
  final ScaleModel scale;

  const ScaleTable({super.key, required this.scale});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 24.w),
      child: Table(
        border: TableBorder.all(),
        columnWidths: const {
          0: FractionColumnWidth(0.33),
          1: FractionColumnWidth(0.33),
          2: FractionColumnWidth(0.33),
        },
        children: [tableHeaderRow, ...buildScaleRows(scale)],
      ),
    );
  }
}

final List<String> header = ['Grade', 'Range', 'Points'];

final TableRow tableHeaderRow = TableRow(
  children: header.map((cell) => buildCell(cell, isHeader: true)).toList(),
);

Widget buildCell(String text, {bool isHeader = false}) {
  final style = TextStyle(fontSize: 18.sp);
  return Container(
    color: isHeader ? AppColors.lightOrange : null,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 8.w),
      child: Center(child: Text(text, style: style)),
    ),
  );
}

List<TableRow> buildScaleRows(ScaleModel scale) {
  final sortedEntries = scale.grades.entries.toList()
    ..sort((a, b) {
      final double pointsA = a.value.values.first;
      final double pointsB = b.value.values.first;
      return pointsB.compareTo(pointsA);
    });

  return sortedEntries.map((entry) {
    final String range = entry.key;
    final String grade = entry.value.keys.first;
    final String points = entry.value.values.first.toString();

    return TableRow(
      children: [buildCell(grade), buildCell(range), buildCell(points)],
    );
  }).toList();
}
