import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/helpers/extensions.dart';
import 'package:student_assistant/core/states/states.dart';
import 'package:student_assistant/core/widgets/home_app_drawer.dart';
import 'package:student_assistant/core/models/scale_model.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/cubits/scales_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/cubits/scales_state.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/presentation/widgets/custom_scale_form.dart';

class CustomScaleScreen extends StatelessWidget {
  final ScaleModel? scale;

  const CustomScaleScreen({super.key, this.scale});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          scale == null ? 'Add Custom Scale' : 'Edit ${scale!.title}',
        ),
      ),
      drawer: HomeAppDrawer(selectedRoute: HomeDrawerEnum.gpa),
      body: BlocListener<ScalesCubit, ScalesState>(
        listenWhen: (previous, current) =>
            current is ScalesSaveScaleLoading ||
            current is ScalesSaveScaleSuccess ||
            current is ScalesSaveScaleError,
        listener: (context, state) {
          switch (state) {
            case ScalesSaveScaleLoading _:
              return loadingState(context: context);
            case ScalesSaveScaleError _:
              Navigator.of(context, rootNavigator: true).pop();
              errorState(
                context: context,
                desc: 'Failed to save scale',
                message: state.apiErrorModel.message,
              );
            case ScalesSaveScaleSuccess _:
              Navigator.of(context, rootNavigator: true).pop();
              context.pop();
            default:
              return;
          }
        },
        child: CustomScaleForm(scale: scale),
      ),
    );
  }
}
