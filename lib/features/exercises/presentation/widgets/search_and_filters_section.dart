import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/theming/app_colors.dart';
import '../cubit/exercises_cubit.dart';
import '../cubit/exercises_state.dart';
import 'section_exercise_widgets.dart';
import 'sort_options_sheet.dart';

class SearchAndFiltersSection extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onFilterChanged;
  final String currentFilter;
  final String currentSort;
  final ValueChanged<String> onSortChanged;
  final bool isAddingToWorkout;

  const SearchAndFiltersSection({
    super.key,
    required this.onSearchChanged,
    required this.onFilterChanged,
    required this.currentFilter,
    required this.currentSort,
    required this.onSortChanged,
    required this.isAddingToWorkout,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          AnimatedSearchBar(
            hintText: s.search_exercises,
            onChanged: onSearchChanged,
          ),
          SizedBox(height: 16.h),
          _buildFilterChips(s),
          SizedBox(height: 16.h),
          _buildCountAndSort(s, context),
        ],
      ),
    );
  }

  Widget _buildFilterChips(S s) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          AnimatedFilterChip(
            label: s.all,
            isSelected: currentFilter == 'all',
            onTap: () => onFilterChanged('all'),
            index: 0,
          ),
          SizedBox(width: 8.w),
          AnimatedFilterChip(
            label: s.beginner,
            isSelected: currentFilter == 'Beginner',
            onTap: () => onFilterChanged('Beginner'),
            index: 1,
          ),
          SizedBox(width: 8.w),
          AnimatedFilterChip(
            label: s.intermediate,
            isSelected: currentFilter == 'Intermediate',
            onTap: () => onFilterChanged('Intermediate'),
            index: 2,
          ),
          SizedBox(width: 8.w),
          AnimatedFilterChip(
            label: s.advanced,
            isSelected: currentFilter == 'Advanced',
            onTap: () => onFilterChanged('Advanced'),
            index: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildCountAndSort(S s, BuildContext context) {
    return BlocBuilder<ExercisesCubit, ExercisesState>(
      builder: (context, state) {
        final count = state is ExercisesLoaded ? state.exercises.length : 0;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TweenAnimationBuilder<int>(
              tween: IntTween(begin: 0, end: count),
              duration: const Duration(milliseconds: 600),
              builder: (context, value, child) {
                return Text(
                  '$value ${s.exercises}',
                  style: TextStyles.subtitle1,
                );
              },
            ),
            if (!isAddingToWorkout)
              IconButton(
                icon: const Icon(Icons.sort, color: ColorsManager.primaryGreen),
                onPressed: () {
                  showSortOptionsSheet(
                    context: context,
                    currentSort: currentSort,
                    onSortChanged: onSortChanged,
                  );
                },
              ),
          ],
        );
      },
    );
  }
}
