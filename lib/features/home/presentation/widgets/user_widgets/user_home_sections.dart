import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../generated/l10n.dart';
import '../../../../exercises/presentation/cubit/sections_cubit.dart';
import '../../../../exercises/presentation/cubit/sections_state.dart';
import '../../../../exercises/presentation/widgets/section_card.dart';
import 'user_home_section_header.dart';

class UserHomeSections extends StatelessWidget {
  const UserHomeSections({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 800),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeOutCubic,
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserHomeSectionHeader(title: s.workout_sections),
          SizedBox(height: 16.h),
          BlocBuilder<SectionsCubit, SectionsState>(
            builder: (context, state) {
              if (state is SectionsLoading) {
                return _buildLoadingGrid(context);
              }
              if (state is SectionsLoaded) {
                return _buildSectionsGrid(context, state.sections);
              }
              if (state is SectionsError) {
                return _buildErrorState(context, state.message);
              }
              return _buildLoadingGrid(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionsGrid(BuildContext context, List sections) {
    final itemCount = sections.length > 6 ? 6 : sections.length;

    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 600),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeOutCubic,
      builder: (context, double gridValue, child) {
        return Opacity(
          opacity: gridValue.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - gridValue)),
            child: child,
          ),
        );
      },
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 0.85,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final delay = index * 100;

          return TweenAnimationBuilder(
            key: ValueKey('section_$index'),
            duration: Duration(milliseconds: 700 + delay),
            tween: Tween<double>(begin: 0, end: 1),
            curve: Curves.easeOutBack,
            builder: (context, double value, child) {
              final clampedValue = value.clamp(0.0, 1.0);

              return Transform.scale(
                scale: 0.7 + (0.3 * clampedValue),
                child: Opacity(
                  opacity: clampedValue,
                  child: Transform.translate(
                    offset: Offset(
                      (index % 2 == 0 ? -50 : 50) * (1 - clampedValue),
                      60 * (1 - clampedValue),
                    ),
                    child: Transform.rotate(
                      angle: (1 - clampedValue) * 0.15,
                      child: child,
                    ),
                  ),
                ),
              );
            },
            child: SectionCard(
              section: sections[index],
              onTap: () {
                HapticFeedback.lightImpact();
                Navigator.pushNamed(
                  context,
                  Routes.sectionExercises,
                  arguments: sections[index],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingGrid(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeOutCubic,
      builder: (context, double gridValue, child) {
        return Opacity(
          opacity: gridValue.clamp(0.0, 1.0),
          child: Transform.scale(
            scale: 0.95 + (0.05 * gridValue),
            child: child,
          ),
        );
      },
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 0.85,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          final delay = index * 80;

          return TweenAnimationBuilder(
            duration: Duration(milliseconds: 600 + delay),
            tween: Tween<double>(begin: 0, end: 1),
            curve: Curves.easeInOut,
            builder: (context, double value, child) {
              final clampedValue = value.clamp(0.0, 1.0);

              return Opacity(
                opacity: 0.3 + (0.7 * clampedValue),
                child: Transform.scale(
                  scale: 0.85 + (0.15 * clampedValue),
                  child: Transform.translate(
                    offset: Offset(0, 30 * (1 - clampedValue)),
                    child: child,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isDark
                      ? ColorsManager.darkBorder.withValues(alpha: 0.3)
                      : ColorsManager.lightBorder.withValues(alpha: 0.5),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorsManager.getPrimaryGreen(
                      context,
                    ).withValues(alpha: isDark ? 0.1 : 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 1000),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double spinValue, child) {
                    return Transform.rotate(
                      angle: spinValue * 2 * 3.14159,
                      child: CircularProgressIndicator(
                        color: ColorsManager.getPrimaryGreen(context),
                        strokeWidth: 2.5,
                      ),
                    );
                  },
                  onEnd: () {},
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 600),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeOutBack,
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value.clamp(0.0, 1.0),
          child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
        );
      },
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: Colors.red.withValues(alpha: 0.3),
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
          children: [
            TweenAnimationBuilder(
              duration: const Duration(milliseconds: 1000),
              tween: Tween<double>(begin: 0, end: 1),
              curve: Curves.elasticOut,
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value.clamp(0.0, 1.0),
                  child: Transform.rotate(
                    angle: (1 - value) * 0.5,
                    child: child,
                  ),
                );
              },
              child: Icon(Icons.error_outline, size: 48.sp, color: Colors.red),
            ),
            SizedBox(height: 12.h),
            Text(
              message,
              style: TextStyle(
                fontSize: 12,
                color: ColorsManager.getSecondaryText(context),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            TweenAnimationBuilder(
              duration: const Duration(milliseconds: 800),
              tween: Tween<double>(begin: 0, end: 1),
              curve: Curves.easeOutBack,
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value.clamp(0.0, 1.0),
                  child: child,
                );
              },
              child: ElevatedButton.icon(
                onPressed: () {
                  HapticFeedback.mediumImpact();
                  context.read<SectionsCubit>().loadSections();
                },
                icon: const Icon(Icons.refresh),
                label: Text(s.retry),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.getPrimaryGreen(context),
                  foregroundColor: isDark
                      ? ColorsManager.darkScaffold
                      : Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
