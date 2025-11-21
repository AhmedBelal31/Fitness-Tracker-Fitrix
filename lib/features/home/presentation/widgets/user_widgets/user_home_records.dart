import 'package:fitrix/core/routing/export_routes.dart';
import 'package:fitrix/core/routing/navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/achievements_models.dart';
import '../../../data/mock_data.dart';
import '../../cubit/achievements_cubit.dart';
import '../../cubit/achievements_state.dart';
import '../../screens/all_records_screen.dart';
import 'user_home_section_header.dart';

// class UserHomeRecords extends StatelessWidget {
//   const UserHomeRecords({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final records = MockData.getMockUserDashboard().personalRecords;
//     final s = S.of(context);
//
//     return TweenAnimationBuilder(
//       duration: const Duration(milliseconds: 1200),
//       tween: Tween<double>(begin: 0, end: 1),
//       builder: (context, double value, child) {
//         return Opacity(
//           opacity: value,
//           child: Transform.translate(
//             offset: Offset(0, 50 * (1 - value)),
//             child: child,
//           ),
//         );
//       },
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           UserHomeSectionHeader(
//             title: s.personal_records,
//             onSeeAll: records != null && records.isNotEmpty
//                 ? () {
//                     // Navigate to full records screen
//                   }
//                 : null,
//           ),
//           SizedBox(height: 16.h),
//           if (records != null && records.isNotEmpty)
//             _buildRecordsList(context, records)
//           else
//             _buildEmptyState(s.no_personal_records_yet),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildRecordsList(BuildContext context, List records) {
//     final s = S.of(context);
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: ColorsManager.cardBackground,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: ColorsManager.cardShadow,
//       ),
//       child: Column(
//         children: records.take(3).toList().asMap().entries.map((entry) {
//           final index = entry.key;
//           final record = entry.value;
//
//           return TweenAnimationBuilder(
//             duration: Duration(milliseconds: 600 + (index * 150)),
//             tween: Tween<double>(begin: 0, end: 1),
//             builder: (context, double value, child) {
//               return Opacity(
//                 opacity: value,
//                 child: Transform.translate(
//                   offset: Offset(30 * (1 - value), 0),
//                   child: child,
//                 ),
//               );
//             },
//             child: Padding(
//               padding: EdgeInsets.only(bottom: index < 2 ? 12.h : 0),
//               child: Row(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(10.w),
//                     decoration: BoxDecoration(
//                       gradient: ColorsManager.primaryGradient,
//                       borderRadius: BorderRadius.circular(12.r),
//                     ),
//                     child: Icon(
//                       Icons.emoji_events,
//                       color: ColorsManager.whiteText,
//                       size: 24.sp,
//                     ),
//                   ),
//                   SizedBox(width: 12.w),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           record.exerciseName,
//                           style: TextStyles.font16PrimaryTextRegular,
//                         ),
//                         Text(
//                           '${record.value} ${s.kg} • ${record.achievedDate}',
//                           style: TextStyles.bodySmall,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Icon(
//                     Icons.chevron_right,
//                     color: ColorsManager.lightText,
//                     size: 24.sp,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
//
//   Widget _buildEmptyState(String message) {
//     return Container(
//       padding: EdgeInsets.all(24.w),
//       decoration: BoxDecoration(
//         color: ColorsManager.cardBackground,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: ColorsManager.softShadow,
//       ),
//       child: Center(
//         child: Column(
//           children: [
//             Icon(
//               Icons.inbox_outlined,
//               size: 48.sp,
//               color: ColorsManager.lightText,
//             ),
//             SizedBox(height: 12.h),
//             Text(message, style: TextStyles.bodyMedium),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:fitrix/core/theming/app_colors.dart';
import 'package:fitrix/core/theming/styles.dart';
import 'package:fitrix/generated/l10n.dart';
import '../../screens/record_detail_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:fitrix/core/di/get_it.dart';

// class UserHomeRecords extends StatelessWidget {
//   const UserHomeRecords({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//
//     return BlocProvider(
//       create: (_) => di<AchievementsCubit>()..loadAchievements(),
//       child: BlocBuilder<AchievementsCubit, AchievementsState>(
//         builder: (context, state) {
//           return TweenAnimationBuilder(
//             duration: const Duration(milliseconds: 800),
//             tween: Tween<double>(begin: 0, end: 1),
//             builder: (context, double value, child) {
//               return Opacity(
//                 opacity: value.clamp(0.0, 1.0),
//                 child: Transform.translate(
//                   offset: Offset(0, 30 * (1 - value)),
//                   child: child,
//                 ),
//               );
//             },
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 UserHomeSectionHeader(
//                   title: s.personal_records,
//                   onSeeAll: _shouldShowSeeAll(state)
//                       ? () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => const AllRecordsScreen(),
//                             ),
//                           );
//                         }
//                       : null,
//                 ),
//                 SizedBox(height: 16.h),
//                 _buildContent(context, state, s),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   bool _shouldShowSeeAll(AchievementsState state) {
//     if (state is AchievementsLoaded) {
//       return state.achievements.milestones.isNotEmpty;
//     }
//     if (state is AchievementsRefreshing) {
//       return state.currentAchievements.milestones.isNotEmpty;
//     }
//     return false;
//   }
//
//   Widget _buildContent(BuildContext context, AchievementsState state, S s) {
//     if (state is AchievementsLoading) {
//       return _buildLoadingState(context);
//     }
//     if (state is AchievementsError) {
//       return _buildErrorState(context, state.message, s);
//     }
//     if (state is AchievementsLoaded) {
//       final milestones = state.achievements.milestones;
//       if (milestones.isEmpty) {
//         return _buildEmptyState(context, s.no_personal_records_yet);
//       }
//       return _buildMilestonesList(context, milestones);
//     }
//     if (state is AchievementsRefreshing) {
//       final milestones = state.currentAchievements.milestones;
//       return Stack(
//         children: [
//           _buildMilestonesList(context, milestones),
//           Positioned(
//             top: 0,
//             right: 0,
//             child: _buildRefreshingIndicator(context),
//           ),
//         ],
//       );
//     }
//     if (state is AchievementsEmpty) {
//       return _buildEmptyState(context, state.message);
//     }
//     return const SizedBox.shrink();
//   }
//
//   Widget _buildLoadingState(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Container(
//       padding: EdgeInsets.all(40.w),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardTheme.color,
//         borderRadius: BorderRadius.circular(20.r),
//         boxShadow: isDark
//             ? [
//                 BoxShadow(
//                   color: Colors.black.withValues(alpha: 0.3),
//                   blurRadius: 8,
//                   offset: const Offset(0, 2),
//                 ),
//               ]
//             : [
//                 BoxShadow(
//                   color: Colors.black.withValues(alpha: 0.08),
//                   blurRadius: 10,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//       ),
//       child: Center(
//         child: Column(
//           children: [
//             SizedBox(
//               width: 40.w,
//               height: 40.h,
//               child: CircularProgressIndicator(
//                 color: ColorsManager.getPrimaryGreen(context),
//                 strokeWidth: 3,
//               ),
//             ),
//             SizedBox(height: 16.h),
//             Text(
//               'Loading achievements...',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: ColorsManager.getSecondaryText(context),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRefreshingIndicator(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Container(
//       padding: EdgeInsets.all(8.w),
//       decoration: BoxDecoration(
//         color: ColorsManager.getPrimaryGreen(
//           context,
//         ).withValues(alpha: isDark ? 0.2 : 0.1),
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       child: SizedBox(
//         width: 20.w,
//         height: 20.h,
//         child: CircularProgressIndicator(
//           color: ColorsManager.getPrimaryGreen(context),
//           strokeWidth: 2,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildErrorState(BuildContext context, String message, S s) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Container(
//       padding: EdgeInsets.all(24.w),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardTheme.color,
//         borderRadius: BorderRadius.circular(20.r),
//         boxShadow: isDark
//             ? [
//                 BoxShadow(
//                   color: Colors.black.withValues(alpha: 0.3),
//                   blurRadius: 8,
//                   offset: const Offset(0, 2),
//                 ),
//               ]
//             : [
//                 BoxShadow(
//                   color: Colors.black.withValues(alpha: 0.08),
//                   blurRadius: 10,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//         border: Border.all(
//           color: ColorsManager.error.withValues(alpha: 0.3),
//           width: 1,
//         ),
//       ),
//       child: Column(
//         children: [
//           Icon(Icons.error_outline, size: 48.sp, color: ColorsManager.error),
//           SizedBox(height: 12.h),
//           Text(
//             message,
//             style: TextStyle(
//               fontSize: 14,
//               color: ColorsManager.getPrimaryText(context),
//             ),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 16.h),
//           ElevatedButton(
//             onPressed: () {
//               context.read<AchievementsCubit>().loadAchievements();
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: ColorsManager.getPrimaryGreen(context),
//               foregroundColor: isDark
//                   ? ColorsManager.darkScaffold
//                   : Colors.white,
//               padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//             ),
//             child: Text(
//               s.retry,
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//                 color: isDark ? ColorsManager.darkScaffold : Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMilestonesList(
//     BuildContext context,
//     List<MilestoneModel> milestones,
//   ) {
//     return Column(
//       children: milestones.take(3).toList().asMap().entries.map((entry) {
//         final index = entry.key;
//         final milestone = entry.value;
//
//         return TweenAnimationBuilder(
//           duration: Duration(milliseconds: 600 + (index * 150)),
//           tween: Tween<double>(begin: 0, end: 1),
//           curve: Curves.easeOutCubic,
//           builder: (context, double value, child) {
//             final clampedValue = value.clamp(0.0, 1.0);
//             return Opacity(
//               opacity: clampedValue,
//               child: Transform.scale(
//                 scale: 0.9 + (0.1 * clampedValue),
//                 child: child,
//               ),
//             );
//           },
//           child: Padding(
//             padding: EdgeInsets.only(bottom: 12.h),
//             child: _buildMilestoneCard(context, milestone, index),
//           ),
//         );
//       }).toList(),
//     );
//   }
//
//   Widget _buildMilestoneCard(
//     BuildContext context,
//     MilestoneModel milestone,
//     int index,
//   ) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final colors = [
//       ColorsManager.orange,
//       ColorsManager.getPrimaryGreen(context),
//       ColorsManager.info,
//     ];
//     final color = colors[index % colors.length];
//
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => RecordDetailScreen(milestone: milestone),
//           ),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               color.withValues(alpha: isDark ? 0.2 : 0.12),
//               color.withValues(alpha: isDark ? 0.1 : 0.04),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(16.r),
//           border: Border.all(
//             color: color.withValues(alpha: isDark ? 0.3 : 0.25),
//             width: 1.5,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: color.withValues(alpha: isDark ? 0.2 : 0.15),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Stack(
//           children: [
//             Positioned(
//               right: -10.w,
//               top: -10.h,
//               child: Opacity(
//                 opacity: isDark ? 0.05 : 0.08,
//                 child: Text(milestone.icon, style: TextStyle(fontSize: 60.sp)),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(16.w),
//               child: Row(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(12.w),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [color, color.withValues(alpha: 0.7)],
//                       ),
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: color.withValues(alpha: 0.3),
//                           blurRadius: 8,
//                           spreadRadius: 1,
//                         ),
//                       ],
//                     ),
//                     child: Text(
//                       milestone.icon,
//                       style: TextStyle(fontSize: 24.sp),
//                     ),
//                   ),
//                   SizedBox(width: 12.w),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           milestone.title,
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: color,
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         SizedBox(height: 4.h),
//                         Text(
//                           milestone.description,
//                           style: TextStyle(
//                             fontSize: 13,
//                             color: ColorsManager.getPrimaryText(context),
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         SizedBox(height: 6.h),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.calendar_today_rounded,
//                               size: 11.sp,
//                               color: ColorsManager.getSecondaryText(context),
//                             ),
//                             SizedBox(width: 4.w),
//                             Text(
//                               DateFormat('MMM d, yyyy').format(milestone.date),
//                               style: TextStyle(
//                                 fontSize: 11,
//                                 color: ColorsManager.getSecondaryText(context),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Icon(Icons.chevron_right_rounded, color: color, size: 24.sp),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEmptyState(BuildContext context, String message) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Container(
//       padding: EdgeInsets.all(32.w),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardTheme.color,
//         borderRadius: BorderRadius.circular(20.r),
//         boxShadow: isDark
//             ? [
//                 BoxShadow(
//                   color: Colors.black.withValues(alpha: 0.3),
//                   blurRadius: 8,
//                   offset: const Offset(0, 2),
//                 ),
//               ]
//             : [
//                 BoxShadow(
//                   color: Colors.black.withValues(alpha: 0.08),
//                   blurRadius: 10,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//       ),
//       child: Center(
//         child: Column(
//           children: [
//             Icon(
//               Icons.emoji_events_outlined,
//               size: 56.sp,
//               color: ColorsManager.getSecondaryText(
//                 context,
//               ).withValues(alpha: 0.5),
//             ),
//             SizedBox(height: 16.h),
//             Text(
//               message,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: ColorsManager.getSecondaryText(context),
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//

class UserHomeRecords extends StatelessWidget {
  const UserHomeRecords({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return BlocProvider(
      create: (_) => di<AchievementsCubit>()..loadAchievements(),
      child: BlocBuilder<AchievementsCubit, AchievementsState>(
        builder: (context, state) {
          return TweenAnimationBuilder(
            duration: const Duration(milliseconds: 800),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, double value, child) {
              return Opacity(
                opacity: value.clamp(0.0, 1.0),
                child: Transform.translate(
                  offset: Offset(0, 30 * (1 - value)),
                  child: child,
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserHomeSectionHeader(
                  title: s.personal_records,
                  onSeeAll: _shouldShowSeeAll(state)
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AllRecordsScreen(),
                            ),
                          );
                        }
                      : null,
                ),
                SizedBox(height: 16.h),
                _buildContent(context, state, s),
              ],
            ),
          );
        },
      ),
    );
  }

  bool _shouldShowSeeAll(AchievementsState state) {
    if (state is AchievementsLoaded) {
      return state.achievements.milestones.isNotEmpty;
    }
    if (state is AchievementsRefreshing) {
      return state.currentAchievements.milestones.isNotEmpty;
    }
    return false;
  }

  Widget _buildContent(BuildContext context, AchievementsState state, S s) {
    if (state is AchievementsLoading) {
      return _buildLoadingState(context);
    }
    if (state is AchievementsError) {
      return _buildErrorState(context, state.message, s);
    }
    if (state is AchievementsLoaded) {
      final milestones = state.achievements.milestones;
      if (milestones.isEmpty) {
        return _buildEmptyState(context, s.no_personal_records_yet);
      }
      return _MilestonesListAnimated(milestones: milestones);
    }
    if (state is AchievementsRefreshing) {
      final milestones = state.currentAchievements.milestones;
      return Stack(
        children: [
          _MilestonesListAnimated(milestones: milestones),
          Positioned(
            top: 0,
            right: 0,
            child: _buildRefreshingIndicator(context),
          ),
        ],
      );
    }
    if (state is AchievementsEmpty) {
      return _buildEmptyState(context, state.message);
    }
    return const SizedBox.shrink();
  }

  Widget _buildLoadingState(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(40.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: isDark
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              width: 40.w,
              height: 40.h,
              child: CircularProgressIndicator(
                color: ColorsManager.getPrimaryGreen(context),
                strokeWidth: 3,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Loading achievements...',
              style: TextStyle(
                fontSize: 14,
                color: ColorsManager.getSecondaryText(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRefreshingIndicator(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: ColorsManager.getPrimaryGreen(
          context,
        ).withValues(alpha: isDark ? 0.2 : 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: SizedBox(
        width: 20.w,
        height: 20.h,
        child: CircularProgressIndicator(
          color: ColorsManager.getPrimaryGreen(context),
          strokeWidth: 2,
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message, S s) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: isDark
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
        border: Border.all(
          color: ColorsManager.error.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(Icons.error_outline, size: 48.sp, color: ColorsManager.error),
          SizedBox(height: 12.h),
          Text(
            message,
            style: TextStyle(
              fontSize: 14,
              color: ColorsManager.getPrimaryText(context),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () =>
                context.read<AchievementsCubit>().loadAchievements(),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.getPrimaryGreen(context),
              foregroundColor: isDark
                  ? ColorsManager.darkScaffold
                  : Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              s.retry,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? ColorsManager.darkScaffold : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, String message) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: isDark
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.emoji_events_outlined,
              size: 56.sp,
              color: ColorsManager.getSecondaryText(
                context,
              ).withValues(alpha: 0.5),
            ),
            SizedBox(height: 16.h),
            Text(
              message,
              style: TextStyle(
                fontSize: 14,
                color: ColorsManager.getSecondaryText(context),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ ANIMATED MILESTONES LIST WITH STAGGERED ANIMATION
class _MilestonesListAnimated extends StatefulWidget {
  final List<MilestoneModel> milestones;

  const _MilestonesListAnimated({required this.milestones});

  @override
  State<_MilestonesListAnimated> createState() =>
      _MilestonesListAnimatedState();
}

class _MilestonesListAnimatedState extends State<_MilestonesListAnimated>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    // ✅ Take only first 3 milestones
    final count = widget.milestones.length.clamp(0, 3);

    // Create animation controllers
    _controllers = List.generate(
      count,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      ),
    );

    // Create curved animations
    _animations = _controllers
        .map(
          (controller) =>
              CurvedAnimation(parent: controller, curve: Curves.easeOutCubic),
        )
        .toList();

    // ✅ Start animations sequentially with 150ms delay
    for (int i = 0; i < count; i++) {
      Future.delayed(Duration(milliseconds: i * 150), () {
        if (mounted) _controllers[i].forward();
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayMilestones = widget.milestones.take(3).toList();

    return Column(
      children: displayMilestones.asMap().entries.map((entry) {
        final index = entry.key;
        final milestone = entry.value;

        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return Opacity(
              opacity: _animations[index].value,
              child: Transform.translate(
                offset: Offset(0, 30 * (1 - _animations[index].value)),
                child: Transform.scale(
                  scale: 0.9 + (0.1 * _animations[index].value),
                  child: child,
                ),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: _MilestoneCard(milestone: milestone, index: index),
          ),
        );
      }).toList(),
    );
  }
}

// ✅ MILESTONE CARD
class _MilestoneCard extends StatelessWidget {
  final MilestoneModel milestone;
  final int index;

  const _MilestoneCard({required this.milestone, required this.index});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = [
      ColorsManager.orange,
      ColorsManager.getPrimaryGreen(context),
      ColorsManager.info,
    ];
    final color = colors[index % colors.length];

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => RecordDetailScreen(milestone: milestone),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: isDark ? 0.2 : 0.12),
              color.withValues(alpha: isDark ? 0.1 : 0.04),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: color.withValues(alpha: isDark ? 0.3 : 0.25),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: isDark ? 0.2 : 0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -10.w,
              top: -10.h,
              child: Opacity(
                opacity: isDark ? 0.05 : 0.08,
                child: Text(milestone.icon, style: TextStyle(fontSize: 60.sp)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color, color.withValues(alpha: 0.7)],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.3),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Text(
                      milestone.icon,
                      style: TextStyle(fontSize: 24.sp),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          milestone.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          milestone.description,
                          style: TextStyle(
                            fontSize: 13,
                            color: ColorsManager.getPrimaryText(context),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_rounded,
                              size: 11.sp,
                              color: ColorsManager.getSecondaryText(context),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              DateFormat('MMM d, yyyy').format(milestone.date),
                              style: TextStyle(
                                fontSize: 11,
                                color: ColorsManager.getSecondaryText(context),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded, color: color, size: 24.sp),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
