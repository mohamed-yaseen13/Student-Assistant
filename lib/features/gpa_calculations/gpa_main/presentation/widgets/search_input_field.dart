import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/style/app_colors.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/semesters_cubit.dart';

class SearchInputField extends StatelessWidget {
  final TextEditingController controller;
  final Function showOverlay;
  final FocusNode focusNode;

  const SearchInputField({
    super.key,
    required this.controller,
    required this.showOverlay,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.black),
            ),
            child: TextField(
              focusNode: focusNode,
              controller: controller,
              onChanged: (query) {
                context.read<SemestersCubit>().searchForCourse(query);
                showOverlay();
              },
              decoration: const InputDecoration(
                icon: Icon(Icons.search),
                hintText: 'Search',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
