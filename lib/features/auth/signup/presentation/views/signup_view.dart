import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/helpers/extensions.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/routing/app_routes.dart';
import 'package:student_assistant/core/style/app_text_styles.dart';
import 'package:student_assistant/features/auth/signup/presentation/widgets/signup_form.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

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
                        'Student Assistant',
                        style: AppTextStyles.whiteColor32FontSizeBold,
                      ),
                      verticalSpace(12),
                      Text(
                        'Track and calculate your academic progress',
                        style: AppTextStyles.whiteColor16FontSize,
                      ),
                      verticalSpace(32),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: SignupForm(),
                      ),
                      verticalSpace(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'you already have an account?',
                            style: AppTextStyles.whiteColor16FontSize,
                          ),
                          TextButton(
                            onPressed: () {
                              context.pushNamed(AppRoutes.loginScreen);
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(32),
                      Text(
                        'By continuing, you agree to our Terms & Privacy Policy',
                        style: AppTextStyles.whiteColor16FontSize,
                        textAlign: TextAlign.center,
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
