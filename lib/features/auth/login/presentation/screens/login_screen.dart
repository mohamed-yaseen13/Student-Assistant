import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/helpers/extensions.dart';
import 'package:student_assistant/core/routing/app_routes.dart';
import 'package:student_assistant/core/states/states.dart';
import 'package:student_assistant/core/style/app_colors.dart';
import 'package:student_assistant/features/auth/login/presentation/cubits/login_cubit.dart';
import 'package:student_assistant/features/auth/login/presentation/cubits/login_state.dart';
import 'package:student_assistant/features/auth/login/presentation/views/login_view.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      backgroundColor: AppColors.mainOrange,
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          switch (state) {
            case LoginLoading _:
              return loadingState(context: context);
            case LoginError _:
              Navigator.of(context, rootNavigator: true).pop();
              return errorState(
                context: context,
                desc: 'Login Failed',
                message: state.apiErrorModel.message,
              );
            case LoginSuccess _:
              Navigator.of(context, rootNavigator: true).pop();
              context.pushNamed(
                AppRoutes.otpScreen,
                arguments: {'email': state.email, 'isLoggingIn': true},
              );
            default:
              return;
          }
        },
        builder: (context, state) {
          return const LoginView();
        },
      ),
    );
  }
}
