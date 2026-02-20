import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/helpers/spacing.dart';
import 'package:student_assistant/core/models/student_model.dart';
import 'package:student_assistant/core/style/app_text_styles.dart';
import 'package:student_assistant/core/widgets/home_app_drawer.dart';
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
        child: ValueListenableBuilder(
          valueListenable: AppConstants.box.listenable(),
          builder: (context, Box<StudentModel> box, _) {
            final scales = box.values.first.scales.values.toList();
            return Column(
              children: [
                verticalSpace(4),
                ...scales.map((scale) => ScaleContainer(scale: scale)),
                verticalSpace(32),
                AddCustomScaleButton(),
                verticalSpace(12),
              ],
            );
          },
        ),
      ),
    );
  }
}
