import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/helpers/extensions.dart';

void loadingState({required BuildContext context}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.transparent,
    builder: (context) {
      return Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(24.sp),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(0),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: const CircularProgressIndicator(),
          ),
        ),
      );
    },
  );
}

void errorState({
  required BuildContext context,
  required String desc,
  required String message,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(desc),
      content: Text(message),
      actions: [
        TextButton(onPressed: () => context.pop(), child: const Text("OK")),
      ],
    ),
  );
}
