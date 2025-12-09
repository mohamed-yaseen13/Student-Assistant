import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/helpers/extensions.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/routing/app_routes.dart';
import 'package:student_assistant/core/style/app_colors.dart';
import 'package:student_assistant/core/style/app_text_styles.dart';
import 'package:student_assistant/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:student_assistant/features/auth/presentation/cubit/auth_state.dart';
import 'package:student_assistant/features/auth/presentation/widgets/loading_dialog.dart';
import 'package:student_assistant/features/auth/presentation/widgets/otp_form.dart';
import 'package:student_assistant/features/auth/presentation/widgets/states.dart';

class OtpScreen extends StatelessWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainOrange,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          switch (state) {
            case AuthSecondStepLoading _:
              showAuthProgressDialog(context);

            case AuthSecondStepSuccess _:
              Navigator.of(context, rootNavigator: true).pop();
              context.pushReplacementNamed(AppRoutes.homeScreen);

            case AuthSecondStepError _:
              Navigator.of(context, rootNavigator: true).pop();
              errorState(
                context: context,
                desc: "Error",
                message: state.apiErrorModel.message!,
              );

            default:
              return;
          }
        },
        builder: (context, state) {
          return Center(
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
          );
        },
      ),
    );
  }
}
