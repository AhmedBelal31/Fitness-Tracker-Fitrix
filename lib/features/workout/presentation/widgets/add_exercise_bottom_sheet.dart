import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../../../exercises/presentation/cubit/exercises_cubit.dart';
import '../../../exercises/presentation/cubit/sections_cubit.dart';
import '../../../exercises/presentation/cubit/sections_state.dart';
import '../../../exercises/presentation/screens/section_exercises_screen.dart';
import '../cubit/workouts_cubit.dart';

class AddExerciseBottomSheet extends StatelessWidget {
  final String workoutId;
  final VoidCallback onExerciseAdded;

  const AddExerciseBottomSheet({
    super.key,
    required this.workoutId,
    required this.onExerciseAdded,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: ColorsManager.getSecondaryText(context),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    s.add_exercise,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.getPrimaryText(context),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                      color: ColorsManager.getPrimaryText(context),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: BlocBuilder<SectionsCubit, SectionsState>(
                builder: (context, state) {
                  if (state is SectionsLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: ColorsManager.getPrimaryGreen(context),
                      ),
                    );
                  }

                  if (state is SectionsLoaded) {
                    return GridView.builder(
                      controller: scrollController,
                      padding: EdgeInsets.all(20.w),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 12.h,
                        childAspectRatio: 1.1,
                      ),
                      itemCount: state.sections.length,
                      itemBuilder: (context, index) => _buildSectionCard(
                        context,
                        state.sections[index],
                        workoutId,
                        onExerciseAdded,
                        index,
                      ),
                    );
                  }

                  if (state is SectionsError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48.sp,
                            color: Colors.red,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            state.message,
                            style: TextStyle(
                              fontSize: 14,
                              color: ColorsManager.getPrimaryText(context),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16.h),
                          ElevatedButton(
                            onPressed: () =>
                                context.read<SectionsCubit>().loadSections(),
                            child: Text(s.retry),
                          ),
                        ],
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSectionCard(
    BuildContext context,
    dynamic section,
    String workoutId,
    VoidCallback onExerciseAdded,
    int index,
  ) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * 100)),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (routeContext) => MultiBlocProvider(
                        providers: [
                          BlocProvider(create: (_) => di.get<ExercisesCubit>()),
                          BlocProvider.value(
                            value: context.read<WorkoutsCubit>(),
                          ),
                        ],
                        child: SectionExercisesScreen(
                          sectionId: section.id,
                          sectionName: section.name,
                          workoutId: workoutId,
                        ),
                      ),
                    ),
                  )
                  .then((_) => onExerciseAdded());
            },
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: ColorsManager.getPrimaryGreen(
                    context,
                  ).withValues(alpha: isDark ? 0.3 : 0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withValues(alpha: 0.3)
                        : Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: ColorsManager.getPrimaryGreen(
                        context,
                      ).withValues(alpha: isDark ? 0.15 : 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _getSectionIcon(section.name),
                      size: 32.sp,
                      color: ColorsManager.getPrimaryGreen(context),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    _getLocalizedSectionName(s, section.name),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ColorsManager.getPrimaryText(context),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ✅ Get localized section name
  String _getLocalizedSectionName(S s, String sectionName) {
    switch (sectionName.toLowerCase()) {
      case 'chest':
        return s.chest;
      case 'back':
        return s.back;
      case 'legs':
        return s.legs;
      case 'shoulders':
        return s.shoulders;
      case 'arms':
        return s.arms;
      case 'core':
        return s.core;
      default:
        return sectionName; // Fallback to API name
    }
  }

  IconData _getSectionIcon(String name) {
    switch (name.toLowerCase()) {
      case 'chest':
        return Icons.accessibility_new;
      case 'back':
        return Icons.accessibility;
      case 'legs':
        return Icons.directions_run;
      case 'shoulders':
        return Icons.fitness_center;
      case 'arms':
        return Icons.sports_martial_arts;
      case 'core':
        return Icons.album;
      default:
        return Icons.fitness_center;
    }
  }
}
