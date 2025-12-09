import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showAuthProgressDialog(
  BuildContext context, {
  bool isSuccess = false,
  bool? isUserHasAccount,
}) {
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
            width: 250.w,
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: Colors.white.withOpacity(0),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                if (isSuccess) ...[
                  SizedBox(height: 20.h),
                  Text(
                    isUserHasAccount! ? "Old User" : "New User",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      );
    },
  );
}
