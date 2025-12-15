import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/helpers/extensions.dart';
import 'package:student_assistant/core/routing/app_routes.dart';
import 'package:student_assistant/core/states/states.dart';
import 'package:student_assistant/core/style/app_colors.dart';
import 'package:student_assistant/features/auth/signup/presentation/cubits/signup_cubit.dart';
import 'package:student_assistant/features/auth/signup/presentation/cubits/signup_state.dart';
import 'package:student_assistant/features/auth/signup/presentation/views/signup_view.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      backgroundColor: AppColors.mainOrange,
      body: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          switch (state) {
            case SignupLoading _:
              return loadingState(context: context);

            case SignupError _:
              Navigator.of(context, rootNavigator: true).pop();
              return errorState(
                context: context,
                desc: 'Signup Failed',
                message: state.apiErrorModel.message!,
              );

            case SignupSuccess _:
              Navigator.of(context, rootNavigator: true).pop();
              context.pushReplacementNamed(
                AppRoutes.otpScreen,
                arguments: {'email': state.email},
              );

            default:
              return;
          }
        },
        builder: (context, state) {
          return SignupView();
        },
      ),
    );
  }
}
