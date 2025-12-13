import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/style/app_colors.dart';
import 'package:student_assistant/core/style/app_text_styles.dart';
import 'package:student_assistant/core/widgets/app_button.dart';
import 'package:student_assistant/core/widgets/email_text_form_field.dart';
import 'package:student_assistant/features/auth/login/presentation/cubits/login_cubit.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

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
              verticalSpace(18),
              AppButton(
                desc: 'Login',
                descStyle: AppTextStyles.whiteColor16FontSize,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginCubit>().login(_emailController.text);
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
