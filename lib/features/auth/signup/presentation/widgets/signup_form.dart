import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/style/app_colors.dart';
import 'package:student_assistant/core/style/app_text_styles.dart';
import 'package:student_assistant/core/widgets/app_button.dart';
import 'package:student_assistant/core/widgets/email_text_form_field.dart';
import 'package:student_assistant/core/widgets/username_text_form_field.dart';
import 'package:student_assistant/features/auth/signup/presentation/cubits/signup_cubit.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(12.sp),
          color: AppColors.backgroundColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email Address', style: AppTextStyles.blackColor16FontSize),
              verticalSpace(8),
              EmailTextFormField(emailController: _emailController),
              verticalSpace(12),
              Text('Username', style: AppTextStyles.blackColor16FontSize),
              verticalSpace(8),
              UsernameTextFormField(usernameController: _usernameController),
              verticalSpace(18),
              AppButton(
                desc: 'Signup',
                descStyle: AppTextStyles.whiteColor16FontSize,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<SignupCubit>().signup(
                      _emailController.text,
                      _usernameController.text,
                    );
                  }
                },
                backgroundColor: AppColors.mainOrange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
