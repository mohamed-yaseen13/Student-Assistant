import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/style/app_text_styles.dart';
import 'package:student_assistant/core/widgets/home_app_drawer.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/cubits/scales_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/cubits/scales_state.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/widgets/add_custom_scale_button.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/widgets/scale_container.dart';

class ScalesScreen extends StatelessWidget {
  const ScalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scales', style: AppTextStyles.whiteColor24FontSize),
      ),
      drawer: HomeAppDrawer(selectedRoute: HomeDrawerEnum.gpa),
      body: SingleChildScrollView(
        child: BlocListener<ScalesCubit, ScalesState>(
          listener: (context, state) {
            if (state is ScalesSaveScaleSuccess ||
                state is ScalesDeleteScaleSuccess ||
                state is ScalesChangeScaleSuccess) {
              context.read<ScalesCubit>().getAllScales();
            }
          },
          child: BlocBuilder<ScalesCubit, ScalesState>(
            buildWhen: (previous, current) =>
                current is ScalesGetAllScalesLoading ||
                current is ScalesGetAllScalesSuccess ||
                current is ScalesGetAllScalesError,
            builder: (context, state) {
              if (state is ScalesGetAllScalesLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is ScalesGetAllScalesSuccess) {
                return Column(
                  children: [
                    verticalSpace(4),
                    ...state.scales.map(
                      (scale) => ScaleContainer(scale: scale),
                    ),
                    verticalSpace(32),
                    AddCustomScaleButton(),
                    verticalSpace(12),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
