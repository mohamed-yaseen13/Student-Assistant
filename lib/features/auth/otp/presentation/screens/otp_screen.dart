import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/helpers/extensions.dart';
import 'package:student_assistant/core/routing/app_routes.dart';
import 'package:student_assistant/core/states/states.dart';
import 'package:student_assistant/core/style/app_colors.dart';
import 'package:student_assistant/features/auth/otp/presentation/cubits/otp_cubit.dart';
import 'package:student_assistant/features/auth/otp/presentation/cubits/otp_state.dart';
import 'package:student_assistant/features/auth/otp/presentation/views/otp_view.dart';

class OtpScreen extends StatelessWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainOrange,
      body: BlocConsumer<OtpCubit, OtpState>(
        listener: (context, state) {
          switch (state) {
            case OtpLoading _:
              return loadingState(context: context);

            case OtpSuccess _:
              Navigator.of(context, rootNavigator: true).pop();
              context.pushReplacementNamed(AppRoutes.homeScreen);

            case OtpError _:
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
          return OtpView(email: email);
        },
      ),
    );
  }
}
