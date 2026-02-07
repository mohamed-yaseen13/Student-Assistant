import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RangeTextFormField extends StatelessWidget {
  final String value;
  final int rowIndex;
  final List<List<String>> rows;
  final ValueChanged<String> onChanged;

  const RangeTextFormField({
    super.key,
    required this.onChanged,
    required this.rowIndex,
    required this.rows,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(4.sp),
        child: TextFormField(
          initialValue: value,
          decoration: InputDecoration(hintText: 'Range'),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please add a range';
            }
            final parts = value.split('-');
            if (parts.length != 2) return null;
            final first = int.tryParse(parts[0]);
            final second = int.tryParse(parts[1]);
            if (first == null || second == null) return null;
            if (second < first) return 'Second must be >= first';
            return null;
          },
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[\d\-]')),
            DashFormatter(rowIndex: rowIndex, rows: rows),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class DashFormatter extends TextInputFormatter {
  final int rowIndex;
  final List<List<String>> rows;

  DashFormatter({required this.rowIndex, required this.rows});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;
    if (text.length == 2 && !text.contains('-')) {
      if (rowIndex == 0) {
        text = '$text-';
      } else {
        final prev = rows[rowIndex - 1][1];
        final prevParts = prev.split('-');
        if (prevParts.length == 2) {
          final prevStart = prevParts[0];
          text = '$text-$prevStart';
        } else {
          text = '$text-';
        }
      }
    }
    if (text.indexOf('-') != text.lastIndexOf('-')) {
      text = text.replaceFirst('-', '');
    }
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
