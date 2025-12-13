import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/helpers/extensions.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/style/app_text_styles.dart';
import 'package:student_assistant/features/auth/otp/presentation/widgets/otp_form.dart';

class OtpView extends StatelessWidget {
  final String email;

  const OtpView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Verification Code',
                        style: AppTextStyles.whiteColor32FontSizeBold,
                      ),
                      verticalSpace(12),
                      Text(
                        "We've sent a 4-digit code to your email",
                        style: AppTextStyles.whiteColor16FontSize,
                      ),
                      verticalSpace(32),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: OtpForm(email: email),
                      ),
                      verticalSpace(24),
                      TextButton(
                        onPressed: context.pop,
                        child: Text(
                          'Back to Login',
                          style: AppTextStyles.whiteColor16FontSize,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
