import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/mock_exercises_data.dart';
import '../../data/models/section_model.dart';
import '../widgets/exercise_card.dart';

class SectionExercisesScreen extends StatefulWidget {
  final SectionModel section;

  const SectionExercisesScreen({required this.section, super.key});

  @override
  State<SectionExercisesScreen> createState() => _SectionExercisesScreenState();
}

class _SectionExercisesScreenState extends State<SectionExercisesScreen> {
  String _searchQuery = '';
  String _filterDifficulty = 'all';

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final exercises = MockExercisesData.getExercisesBySection(
      widget.section.id,
    );

    // Filter exercises
    final filteredExercises = exercises.where((exercise) {
      final matchesSearch = exercise.name.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      final matchesDifficulty =
          _filterDifficulty == 'all' ||
          exercise.difficulty.toLowerCase() == _filterDifficulty;
      return matchesSearch && matchesDifficulty;
    }).toList();

    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackground,
      body: CustomScrollView(
        slivers: [
          // App Bar with Gradient
          SliverAppBar(
            expandedHeight: 200.h,
            pinned: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                _getSectionName(s, widget.section.name),
                style: TextStyles.font20WhiteSemiBold,
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: ColorsManager.appBarBackgroundGradient,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40.h),
                    Icon(
                      _getIconData(widget.section.iconName),
                      size: 80.sp,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      _getSectionDescription(s, widget.section.name),
                      style: TextStyles.font14WhiteMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Search and Filter
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  // Search Bar
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: s.search_exercises,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: ColorsManager.primaryGreen,
                      ),
                      filled: true,
                      fillColor: ColorsManager.inputBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Filter Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip(s.all, 'all', s),
                        SizedBox(width: 8.w),
                        _buildFilterChip(s.beginner, 'beginner', s),
                        SizedBox(width: 8.w),
                        _buildFilterChip(s.intermediate, 'intermediate', s),
                        SizedBox(width: 8.w),
                        _buildFilterChip(s.advanced, 'advanced', s),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Exercise Count
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${filteredExercises.length} ${s.exercises}',
                        style: TextStyles.subtitle1,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.sort,
                          color: ColorsManager.primaryGreen,
                        ),
                        onPressed: () {
                          _showSortOptions(context, s);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Exercise List
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: filteredExercises.isNotEmpty
                ? SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: ExerciseCard(
                          exercise: filteredExercises[index],
                          onTap: () {
                            _showExerciseDetails(
                              context,
                              filteredExercises[index],
                              s,
                            );
                          },
                        ),
                      );
                    }, childCount: filteredExercises.length),
                  )
                : SliverToBoxAdapter(child: _buildEmptyState(s)),
          ),

          // Bottom Padding
          SliverToBoxAdapter(child: SizedBox(height: 80.h)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showCreateCustomExercise(context, s);
        },
        backgroundColor: ColorsManager.primaryGreen,
        icon: const Icon(Icons.add),
        label: Text(s.create_custom, style: TextStyles.buttonMedium),
      ),
    );
  }

  String _getSectionName(S s, String sectionName) {
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
        return sectionName;
    }
  }

  String _getSectionDescription(S s, String sectionName) {
    switch (sectionName.toLowerCase()) {
      case 'chest':
        return s.chest_description;
      case 'back':
        return s.back_description;
      case 'legs':
        return s.legs_description;
      case 'shoulders':
        return s.shoulders_description;
      case 'arms':
        return s.arms_description;
      case 'core':
        return s.core_description;
      default:
        return '';
    }
  }

  Widget _buildFilterChip(String label, String value, S s) {
    final isSelected = _filterDifficulty == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _filterDifficulty = value;
        });
      },
      backgroundColor: ColorsManager.cardBackground,
      selectedColor: ColorsManager.primaryGreen,
      labelStyle: TextStyles.bodyMedium.copyWith(
        color: isSelected ? Colors.white : ColorsManager.primaryText,
      ),
    );
  }

  Widget _buildEmptyState(S s) {
    return Container(
      margin: EdgeInsets.only(top: 40.h),
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        color: ColorsManager.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: ColorsManager.softShadow,
      ),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.search_off, size: 64.sp, color: ColorsManager.lightText),
            SizedBox(height: 16.h),
            Text(s.no_exercises_found, style: TextStyles.headline3),
            SizedBox(height: 8.h),
            Text(
              s.try_adjusting_search,
              style: TextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'fitness_center':
        return Icons.fitness_center;
      case 'accessibility_new':
        return Icons.accessibility_new;
      case 'directions_run':
        return Icons.directions_run;
      case 'sports_martial_arts':
        return Icons.sports_martial_arts;
      case 'sports_gymnastics':
        return Icons.sports_gymnastics;
      case 'self_improvement':
        return Icons.self_improvement;
      default:
        return Icons.fitness_center;
    }
  }

  void _showSortOptions(BuildContext context, S s) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorsManager.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(s.sort_by, style: TextStyles.headline3),
              SizedBox(height: 20.h),
              ListTile(
                leading: const Icon(
                  Icons.sort_by_alpha,
                  color: ColorsManager.primaryGreen,
                ),
                title: Text(s.name_a_z),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(
                  Icons.trending_up,
                  color: ColorsManager.primaryGreen,
                ),
                title: Text(s.difficulty),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(
                  Icons.favorite,
                  color: ColorsManager.primaryGreen,
                ),
                title: Text(s.most_popular),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showExerciseDetails(BuildContext context, exercise, S s) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: ColorsManager.cardBackground,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Handle bar
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: ColorsManager.lightText,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Exercise Name
                    Text(exercise.name, style: TextStyles.headline2),
                    SizedBox(height: 8.h),

                    // Tags Row
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        _buildTag(
                          _getDifficultyName(s, exercise.difficulty),
                          _getDifficultyColor(exercise.difficulty),
                        ),
                        _buildTag(exercise.equipment, ColorsManager.info),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    // Description
                    Text(s.description, style: TextStyles.subtitle1),
                    SizedBox(height: 8.h),
                    Text(exercise.description, style: TextStyles.bodyMedium),
                    SizedBox(height: 20.h),

                    // Muscle Groups
                    Text(s.target_muscles, style: TextStyles.subtitle1),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: exercise.muscleGroups
                          .map<Widget>(
                            (muscle) => Chip(
                              label: Text(muscle, style: TextStyles.bodySmall),
                              backgroundColor: ColorsManager.primaryGreen
                                  .withOpacity(0.1),
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 32.h),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(s.added_to_workout),
                                  backgroundColor: ColorsManager.success,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsManager.primaryGreen,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                            ),
                            child: Text(
                              s.add_to_workout,
                              style: TextStyles.buttonLarge,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_border),
                          color: ColorsManager.error,
                          iconSize: 28.sp,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _getDifficultyName(S s, String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return s.beginner;
      case 'intermediate':
        return s.intermediate;
      case 'advanced':
        return s.advanced;
      default:
        return difficulty;
    }
  }

  Widget _buildTag(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(label, style: TextStyles.bodySmall.copyWith(color: color)),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return ColorsManager.beginnerLevel;
      case 'intermediate':
        return ColorsManager.intermediateLevel;
      case 'advanced':
        return ColorsManager.advancedLevel;
      default:
        return ColorsManager.info;
    }
  }

  void _showCreateCustomExercise(BuildContext context, S s) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(s.create_custom_exercise, style: TextStyles.headline3),
        content: Text(
          'This feature will allow you to create your own custom exercises.',
          style: TextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(s.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.primaryGreen,
            ),
            child: Text(s.create),
          ),
        ],
      ),
    );
  }
}
