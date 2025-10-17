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
                return _buildLoadingGrid();
              }

              if (state is SectionsLoaded) {
                return _buildSectionsGrid(context, state.sections);
              }

              if (state is SectionsError) {
                return _buildErrorState(context, state.message);
              }

              return _buildLoadingGrid();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionsGrid(BuildContext context, List sections) {
    final itemCount = sections.length > 6 ? 6 : sections.length;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.0,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        // ✅ Staggered delay for each item
        final delay = index * 80;

        return TweenAnimationBuilder(
          key: ValueKey('section_$index'),
          duration: Duration(milliseconds: 600 + delay),
          tween: Tween<double>(begin: 0, end: 1),
          curve: Curves.easeOutBack, // ✅ Changed from elasticOut to easeOutBack
          builder: (context, double value, child) {
            // ✅ Clamp opacity to valid range (0.0 - 1.0)
            final clampedOpacity = value.clamp(0.0, 1.0);

            return Transform.scale(
              scale: 0.8 + (0.2 * value), // ✅ Scale from 0.8 to 1.0
              child: Transform.rotate(
                angle: (1 - value) * 0.1, // Subtle rotation
                child: Opacity(
                  opacity: clampedOpacity, // ✅ Use clamped value
                  child: Transform.translate(
                    offset: Offset(
                      // Alternate left-right slide based on position
                      (index % 2 == 0 ? -30 : 30) * (1 - value),
                      40 * (1 - value), // Vertical slide
                    ),
                    child: child,
                  ),
                ),
              ),
            );
          },
          child: SectionCard(
            section: sections[index],
            onTap: () {
              // ✅ Add haptic feedback on tap
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
    );
  }

  Widget _buildLoadingGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.0,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return TweenAnimationBuilder(
          duration: Duration(milliseconds: 800 + (index * 100)),
          tween: Tween<double>(begin: 0, end: 1),
          curve: Curves.easeInOut,
          builder: (context, double value, child) {
            return Opacity(
              opacity: 0.3 + (0.7 * value),
              child: Transform.scale(scale: 0.9 + (0.1 * value), child: child),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: ColorsManager.cardBackground,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: ColorsManager.primaryGreen.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: CircularProgressIndicator(
                color: ColorsManager.primaryGreen,
                strokeWidth: 2,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    final s = S.of(context);

    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.elasticOut,
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: ColorsManager.cardBackground,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.red.withOpacity(0.3), width: 1),
        ),
        child: Column(
          children: [
            // ✅ Animated error icon
            TweenAnimationBuilder(
              duration: const Duration(milliseconds: 800),
              tween: Tween<double>(begin: 0, end: 1),
              curve: Curves.elasticOut,
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
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
              style: TextStyles.bodySmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            // ✅ Animated retry button
            TweenAnimationBuilder(
              duration: const Duration(milliseconds: 600),
              tween: Tween<double>(begin: 0, end: 1),
              curve: Curves.easeOutBack,
              builder: (context, double value, child) {
                return Transform.scale(scale: value, child: child);
              },
              child: ElevatedButton.icon(
                onPressed: () {
                  HapticFeedback.mediumImpact();
                  context.read<SectionsCubit>().loadSections();
                },
                icon: const Icon(Icons.refresh),
                label: Text(s.retry),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.primaryGreen,
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
