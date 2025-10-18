import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../data/workout_session_model.dart';

// class WorkoutStatsRow extends StatefulWidget {
//   final List<WorkoutSessionModel> sessions;
//
//   const WorkoutStatsRow({super.key, required this.sessions});
//
//   @override
//   State<WorkoutStatsRow> createState() => _WorkoutStatsRowState();
// }
//
// class _WorkoutStatsRowState extends State<WorkoutStatsRow>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   List<StatCardData> _stats = [];
//   List<StatCardData> _displayStats = [];
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );
//
//     _controller.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         Future.delayed(const Duration(milliseconds: 2000), () {
//           if (mounted) {
//             setState(() {
//               final first = _displayStats.removeAt(0);
//               _displayStats.add(first);
//             });
//             _controller.reset();
//             _controller.forward();
//           }
//         });
//       }
//     });
//
//     Future.delayed(const Duration(milliseconds: 2000), () {
//       if (mounted) {
//         _controller.forward();
//       }
//     });
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // ✅ Rebuild stats whenever locale changes
//     _initializeStats();
//   }
//
//   @override
//   void didUpdateWidget(WorkoutStatsRow oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     // ✅ Update stats if sessions data changes
//     if (oldWidget.sessions != widget.sessions) {
//       _initializeStats();
//     }
//   }
//
//   void _initializeStats() {
//     final s = S.of(context); // ✅ Gets current locale automatically
//     final totalWorkouts = widget.sessions.length;
//     final completedWorkouts = widget.sessions
//         .where((s) => s.isCompleted)
//         .length;
//     final avgDuration = _calculateAvgDuration();
//
//     _stats = [
//       StatCardData(
//         id: 'total',
//         icon: Icons.fitness_center,
//         value: totalWorkouts.toString(),
//         label: s.total_workouts, // ✅ Supports English & Arabic
//         color: ColorsManager.primaryGreen,
//       ),
//       StatCardData(
//         id: 'duration',
//         icon: Icons.timer,
//         value: avgDuration.toString(),
//         label: s.avg_duration, // ✅ Supports English & Arabic
//         color: ColorsManager.warning,
//       ),
//       StatCardData(
//         id: 'completed',
//         icon: Icons.check_circle,
//         value: completedWorkouts.toString(),
//         label: s.completed, // ✅ Supports English & Arabic
//         color: ColorsManager.info,
//       ),
//     ];
//
//     if (_displayStats.isEmpty) {
//       _displayStats = List.from(_stats);
//     } else {
//       // ✅ Update labels while keeping the same order
//       for (int i = 0; i < _displayStats.length; i++) {
//         final matchingStat = _stats.firstWhere(
//           (s) => s.id == _displayStats[i].id,
//         );
//         _displayStats[i] = matchingStat;
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   int _calculateAvgDuration() {
//     if (widget.sessions.isEmpty) return 0;
//
//     final sessionsWithDuration = widget.sessions.where(
//       (s) => s.durationMinutes != null,
//     );
//     if (sessionsWithDuration.isEmpty) return 0;
//
//     final totalDuration = sessionsWithDuration
//         .map((s) => s.durationMinutes!)
//         .fold<int>(0, (prev, curr) => prev + curr);
//
//     return totalDuration ~/ sessionsWithDuration.length;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_displayStats.isEmpty) {
//       return const SizedBox.shrink();
//     }
//
//     return SizedBox(
//       height: 150.h,
//       child: Row(
//         children: _displayStats.asMap().entries.map((entry) {
//           final stat = entry.value;
//
//           return Expanded(
//             child: AnimatedBuilder(
//               animation: _controller,
//               builder: (context, child) {
//                 return Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 6.w),
//                   child: AnimatedStatCard(
//                     key: ValueKey(stat.id),
//                     icon: stat.icon,
//                     value: stat.value,
//                     label: stat.label,
//                     color: stat.color,
//                   ),
//                 );
//               },
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
//
// class StatCardData {
//   final String id;
//   final IconData icon;
//   final String value;
//   final String label;
//   final Color color;
//
//   StatCardData({
//     required this.id,
//     required this.icon,
//     required this.value,
//     required this.label,
//     required this.color,
//   });
// }
//
// class AnimatedStatCard extends StatefulWidget {
//   final IconData icon;
//   final String value;
//   final String label;
//   final Color color;
//
//   const AnimatedStatCard({
//     super.key,
//     required this.icon,
//     required this.value,
//     required this.label,
//     required this.color,
//   });
//
//   @override
//   State<AnimatedStatCard> createState() => _AnimatedStatCardState();
// }
//
// class _AnimatedStatCardState extends State<AnimatedStatCard>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _breathController;
//   late Animation<double> _scaleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _breathController = AnimationController(
//       duration: const Duration(milliseconds: 2000),
//       vsync: this,
//     );
//
//     _scaleAnimation = Tween<double>(begin: 0.98, end: 1.02).animate(
//       CurvedAnimation(parent: _breathController, curve: Curves.easeInOut),
//     );
//
//     _breathController.repeat(reverse: true);
//   }
//
//   @override
//   void dispose() {
//     _breathController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _breathController,
//       builder: (context, child) {
//         return Transform.scale(
//           scale: _scaleAnimation.value,
//           child: Container(
//             padding: EdgeInsets.all(12.w),
//             decoration: BoxDecoration(
//               // gradient: LinearGradient(
//               //   colors: [
//               //     widget.color.withValues(alpha: 0.15),
//               //     widget.color.withValues(alpha: 0.08),
//               //   ],
//               //   begin: Alignment.topLeft,
//               //   end: Alignment.bottomRight,
//               // ),
//               color: widget.color.withValues(alpha: 0.8),
//               borderRadius: BorderRadius.circular(16.r),
//               border: Border.all(
//                 color: widget.color.withValues(alpha: 0.4),
//                 width: 2,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: widget.color.withValues(alpha: 0.25),
//                   blurRadius: 12 * _scaleAnimation.value,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(10.w),
//                   decoration: BoxDecoration(
//                     // color: widget.color.withValues(alpha: 0.2),
//                     color: widget.color,
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       // BoxShadow(
//                       //   color: widget.color.withValues(alpha:0.4),
//                       //   blurRadius: 8,
//                       //   spreadRadius: 2,
//                       // ),
//                     ],
//                   ),
//                   // child: Icon(widget.icon, color: widget.color, size: 24.sp),
//                   child: Icon(widget.icon, color: Colors.white, size: 24.sp),
//                 ),
//                 SizedBox(height: 8.h),
//
//                 Text(
//                   widget.value,
//                   // style: TextStyles.headline2.copyWith(
//                   //   color: widget.color,
//                   //   fontSize: 24.sp,
//                   //   fontWeight: FontWeight.bold,
//                   // ),
//                   style: GoogleFonts.aBeeZee(
//                     color: ColorsManager.white,
//                     fontSize: 20.sp,
//                   ),
//                 ),
//                 SizedBox(height: 4.h),
//
//                 Text(
//                   widget.label,
//                   style: GoogleFonts.aBeeZee(
//                     color: ColorsManager.black,
//                     fontSize: 10.sp,
//                   ),
//                   textAlign: TextAlign.center,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

class WorkoutStatsRow extends StatefulWidget {
  final List<WorkoutSessionModel> sessions;

  const WorkoutStatsRow({super.key, required this.sessions});

  @override
  State<WorkoutStatsRow> createState() => _WorkoutStatsRowState();
}

class _WorkoutStatsRowState extends State<WorkoutStatsRow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<StatCardData> _stats = [];
  List<StatCardData> _displayStats = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 2000), () {
          if (mounted) {
            setState(() {
              final first = _displayStats.removeAt(0);
              _displayStats.add(first);
            });
            _controller.reset();
            _controller.forward();
          }
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeStats();
  }

  @override
  void didUpdateWidget(WorkoutStatsRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.sessions != widget.sessions) {
      _initializeStats();
    }
  }

  void _initializeStats() {
    final s = S.of(context);
    final totalWorkouts = widget.sessions.length;
    final completedWorkouts = widget.sessions
        .where((s) => s.isCompleted)
        .length;
    final avgDuration = _calculateAvgDuration();

    _stats = [
      StatCardData(
        id: 'total',
        icon: Icons.fitness_center_rounded,
        value: totalWorkouts.toString(),
        label: s.total_workouts,
        status: s.active, // "Active" status
        color: ColorsManager.primaryGreen,
      ),
      StatCardData(
        id: 'duration',
        icon: Icons.timer_outlined,
        value: '$avgDuration${s.minutes_short}',
        label: s.avg_duration,
        status: s.average, // "Average" status
        color: ColorsManager.orange,
      ),
      StatCardData(
        id: 'completed',
        icon: Icons.check_circle_rounded,
        value: completedWorkouts.toString(),
        label: s.completed,
        status: s.done, // "Done" status
        color: ColorsManager.info,
      ),
    ];

    if (_displayStats.isEmpty) {
      _displayStats = List.from(_stats);
    } else {
      for (int i = 0; i < _displayStats.length; i++) {
        final matchingStat = _stats.firstWhere(
          (s) => s.id == _displayStats[i].id,
        );
        _displayStats[i] = matchingStat;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int _calculateAvgDuration() {
    if (widget.sessions.isEmpty) return 0;

    final sessionsWithDuration = widget.sessions.where(
      (s) => s.durationMinutes != null,
    );
    if (sessionsWithDuration.isEmpty) return 0;

    final totalDuration = sessionsWithDuration
        .map((s) => s.durationMinutes!)
        .fold<int>(0, (prev, curr) => prev + curr);

    return totalDuration ~/ sessionsWithDuration.length;
  }

  @override
  Widget build(BuildContext context) {
    if (_displayStats.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 160.h,
      child: Row(
        children: _displayStats.asMap().entries.map((entry) {
          final stat = entry.value;

          return Expanded(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: FramedStatCard(
                    key: ValueKey(stat.id),
                    icon: stat.icon,
                    value: stat.value,
                    label: stat.label,
                    status: stat.status,
                    color: stat.color,
                  ),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

class StatCardData {
  final String id;
  final IconData icon;
  final String value;
  final String label;
  final String status;
  final Color color;

  StatCardData({
    required this.id,
    required this.icon,
    required this.value,
    required this.label,
    required this.status,
    required this.color,
  });
}

// ✅ NEW: Framed Stat Card Design
class FramedStatCard extends StatefulWidget {
  final IconData icon;
  final String value;
  final String label;
  final String status;
  final Color color;

  const FramedStatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.status,
    required this.color,
  });

  @override
  State<FramedStatCard> createState() => _FramedStatCardState();
}

class _FramedStatCardState extends State<FramedStatCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _breathController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _breathController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.98, end: 1.02).animate(
      CurvedAnimation(parent: _breathController, curve: Curves.easeInOut),
    );

    _breathController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _breathController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _breathController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              color: ColorsManager.cardBackground,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: widget.color.withOpacity(0.4),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // ✅ Status Badge at Top
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(0.15),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(14.r),
                    ),
                  ),
                  child: Text(
                    widget.status,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.aBeeZee(
                      color: widget.color,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                // ✅ Main Content
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon
                        Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                widget.color,
                                widget.color.withOpacity(0.7),
                              ],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: widget.color.withOpacity(0.3),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Icon(
                            widget.icon,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),

                        // Value (Count)
                        Text(
                          widget.value,
                          style: GoogleFonts.aBeeZee(
                            color: ColorsManager.primaryText,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2.h),

                        // Label
                        Text(
                          widget.label,
                          style: GoogleFonts.aBeeZee(
                            color: ColorsManager.secondaryText,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
