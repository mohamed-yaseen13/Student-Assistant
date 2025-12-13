import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/style/app_colors.dart';
import 'package:student_assistant/core/style/app_text_styles.dart';
import 'package:student_assistant/core/widgets/app_button.dart';
import 'package:student_assistant/features/auth/otp/presentation/cubits/otp_cubit.dart';

class OtpForm extends StatefulWidget {
  final String email;

  const OtpForm({super.key, required this.email});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  String otp = '1234';

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.h,
      textStyle: TextStyle(fontSize: 20.sp, color: Colors.black),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12.r),
      ),
    );

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12.sp),
        color: AppColors.backgroundColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Pinput(
                length: 4,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightOrange),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                showCursor: true,
                separatorBuilder: (index) => horizontalSpace(28),
                onCompleted: (value) => setState(() => otp = value),
              ),
            ),
            verticalSpace(32),
            AppButton(
              desc: 'Verify Code',
              descStyle: AppTextStyles.whiteColor16FontSize,
              onPressed: () {
                context.read<OtpCubit>().verifyOtp(widget.email, otp);
              },
              backgroundColor: AppColors.mainOrange,
            ),
          ],
        ),
      ),
    );
  }
}
