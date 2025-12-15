import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/core/style/app_colors.dart';

class SearchInputField extends StatelessWidget {
  const SearchInputField({super.key});

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
              //focusNode: focusNode,
              //controller: controller,
              onChanged: (query) {
                //context.read<ApplicationAppBarCubit>().searchOnCourse(query);
                //showOverlay();
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
