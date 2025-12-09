// ignore_for_file: use_build_context_synchronously

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
import 'package:student_assistant/features/auth/presentation/widgets/enter_form.dart';
import 'package:student_assistant/features/auth/presentation/widgets/loading_dialog.dart';
import 'package:student_assistant/features/auth/presentation/widgets/states.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainOrange,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          switch (state) {
            case AuthFirstStepLoading _:
              showAuthProgressDialog(context);
            case AuthFirstStepSuccess _:
              Navigator.of(context, rootNavigator: true).pop();
              showAuthProgressDialog(
                context,
                isSuccess: true,
                isUserHasAccount: state.isUserHasAccount,
              );
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.of(context, rootNavigator: true).pop();
                context.pushNamed(
                  AppRoutes.otpScreen,
                  arguments: {'email': state.email},
                );
              });
            case AuthFirstStepError _:
              Navigator.of(context, rootNavigator: true).pop();
              errorState(
                context: context,
                desc: "Error",
                message: state.apiErrorModel.message!,
              );
              break;

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
                  child: EnterForm(),
                ),
                verticalSpace(16),
                Text(
                  'By continuing, you agree to our Terms & Privacy Policy',
                  style: AppTextStyles.whiteColor16FontSize,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
