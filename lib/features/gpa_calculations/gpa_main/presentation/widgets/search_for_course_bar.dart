import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/cubits/semesters_cubit.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/widgets/search_input_field.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/presentation/widgets/search_result_container.dart';

class SearchForCourseBar extends StatefulWidget {
  const SearchForCourseBar({super.key});

  @override
  State<SearchForCourseBar> createState() => _SearchForCourseBarState();
}

class _SearchForCourseBarState extends State<SearchForCourseBar> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _overlayEntry?.remove();
        _overlayEntry = null;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  final _controller = TextEditingController();
  final _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void _showOverlay() {
    if (!mounted) return;

    final overlay = Overlay.of(context);

    _overlayEntry?.remove();

    _overlayEntry = OverlayEntry(
      builder: (overlayContext) {
        final appBarCubit = context.read<SemestersCubit>();
        return Positioned(
          width: MediaQuery.of(context).size.width - 24.w,
          child: CompositedTransformFollower(
            link: _layerLink,
            offset: Offset(12.w, 52.h),
            showWhenUnlinked: false,
            child: BlocProvider.value(
              value: appBarCubit,
              child: const SearchResultContainer(),
            ),
          ),
        );
      },
    );

    overlay.insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: SearchInputField(
        controller: _controller,
        focusNode: _focusNode,
        showOverlay: _showOverlay,
      ),
    );
  }
}
