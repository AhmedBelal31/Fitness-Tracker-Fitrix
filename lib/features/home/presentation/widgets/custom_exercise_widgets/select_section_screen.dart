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
import '../section_selection_card.dart';

class SelectSectionScreen extends StatefulWidget {
  const SelectSectionScreen({super.key});

  @override
  State<SelectSectionScreen> createState() => _SelectSectionScreenState();
}

class _SelectSectionScreenState extends State<SelectSectionScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SectionsCubit>().loadSections();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackground,
      appBar: _buildAppBar(s),
      body: _buildBody(s),
    );
  }

  AppBar _buildAppBar(S s) {
    return AppBar(
      title: Text(s.select_section, style: TextStyles.headline3),
      backgroundColor: ColorsManager.scaffoldBackground,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: ColorsManager.primaryText),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildBody(S s) {
    return BlocBuilder<SectionsCubit, SectionsState>(
      builder: (context, state) {
        if (state is SectionsLoading) {
          return _buildLoadingState();
        }

        if (state is SectionsLoaded) {
          return _buildSectionsList(state.sections, s);
        }

        if (state is SectionsError) {
          return _buildErrorState(context, state.message, s);
        }

        return _buildLoadingState();
      },
    );
  }

  Widget _buildSectionsList(List sections, S s) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(s),
            SizedBox(height: 20.h),
            _buildSectionsGrid(sections),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(S s) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 600),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeOut,
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(s.choose_section_for_exercise, style: TextStyles.headline3),
          SizedBox(height: 8.h),
          Text(
            s.select_category_for_custom_exercise,
            style: TextStyles.bodyMedium.copyWith(
              color: ColorsManager.secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionsGrid(List sections) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.0,
      ),
      itemCount: sections.length,
      itemBuilder: (context, index) {
        final delay = index * 80;

        return TweenAnimationBuilder(
          key: ValueKey('section_$index'),
          duration: Duration(milliseconds: 600 + delay),
          tween: Tween<double>(begin: 0, end: 1),
          curve: Curves.easeOutBack,
          builder: (context, double value, child) {
            final clampedOpacity = value.clamp(0.0, 1.0);

            return Transform.scale(
              scale: 0.8 + (0.2 * value),
              child: Opacity(
                opacity: clampedOpacity,
                child: Transform.translate(
                  offset: Offset(
                    (index % 2 == 0 ? -30 : 30) * (1 - value),
                    40 * (1 - value),
                  ),
                  child: child,
                ),
              ),
            );
          },
          child: SectionSelectionCard(
            section: sections[index],
            onTap: () {
              HapticFeedback.lightImpact();
              _navigateToCreateExercise(sections[index].id);
            },
          ),
        );
      },
    );
  }

  void _navigateToCreateExercise(String sectionId) {
    // Navigate directly to your existing CreateCustomExerciseScreen
    Navigator.pushNamed(
      context,
      Routes.createCustomExercise,
      arguments: sectionId,
    ).then((created) {
      // If exercise was created, pop back to CustomExercisesScreen with refresh flag
      if (created == true && mounted) {
        Navigator.pop(context, true); // Return true to refresh list
      }
    });
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: ColorsManager.primaryGreen),
          SizedBox(height: 16.h),
          Text(S.of(context).loading_sections, style: TextStyles.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message, S s) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64.sp, color: ColorsManager.error),
            SizedBox(height: 24.h),
            Text(
              message,
              style: TextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: () {
                HapticFeedback.mediumImpact();
                context.read<SectionsCubit>().loadSections();
              },
              icon: const Icon(Icons.refresh),
              label: Text(s.retry),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.primaryGreen,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
