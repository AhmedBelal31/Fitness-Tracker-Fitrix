import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../home/data/dashboard_model.dart';

class RecentWorkoutCard extends StatefulWidget {
  final RecentWorkoutModel workout;
  final VoidCallback? onTap;
  final int index;

  const RecentWorkoutCard({
    required this.workout,
    this.onTap,
    this.index = 0,
    super.key,
  });

  @override
  State<RecentWorkoutCard> createState() => _RecentWorkoutCardState();
}

class _RecentWorkoutCardState extends State<RecentWorkoutCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatingAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Create animation controller with different duration based on index
    final baseDuration = 2500 + (widget.index * 400); // 2.5s, 2.9s, 3.3s
    _controller = AnimationController(
      duration: Duration(milliseconds: baseDuration),
      vsync: this,
    );

    // Floating animation (up and down movement)
    _floatingAnimation = Tween<double>(
      begin: -10.0,
      end: 10.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Subtle scale animation for breathing effect
    _scaleAnimation = Tween<double>(
      begin: 0.98,
      end: 1.02,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Start animation immediately after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Add delay based on index for staggered effect
        Future.delayed(Duration(milliseconds: widget.index * 150), () {
          if (mounted) {
            _controller.repeat(reverse: true);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatingAnimation.value),
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: InkWell(
              onTap: widget.onTap ?? () {},
              borderRadius: BorderRadius.circular(16.r),
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: ColorsManager.cardBackground,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 15,
                      spreadRadius: 1,
                      offset: Offset(0, 4 + _floatingAnimation.value / 3),
                    ),
                    BoxShadow(
                      color: ColorsManager.primaryGreen.withOpacity(0.1),
                      blurRadius: 8,
                      spreadRadius: 0,
                      offset: Offset(0, 2 + _floatingAnimation.value / 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: widget.workout.isCompleted
                                    ? ColorsManager.success.withOpacity(0.1)
                                    : ColorsManager.info.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Icon(
                                widget.workout.isCompleted
                                    ? Icons.check_circle
                                    : Icons.pending,
                                color: widget.workout.isCompleted
                                    ? ColorsManager.success
                                    : ColorsManager.info,
                                size: 20.sp,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _formatDate(widget.workout.date),
                                  style: TextStyles.font16PrimaryTextRegular,
                                ),
                                Text(
                                  widget.workout.isCompleted
                                      ? s.completed
                                      : s.in_progress,
                                  style: TextStyles.caption.copyWith(
                                    color: widget.workout.isCompleted
                                        ? ColorsManager.success
                                        : ColorsManager.info,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: ColorsManager.lightText,
                          size: 24.sp,
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Divider(color: ColorsManager.lightBorder, height: 1),
                    SizedBox(height: 12.h),

                    // Stats Row
                    Row(
                      children: [
                        _buildStatItem(
                          context,
                          icon: Icons.fitness_center,
                          label: s.exercises,
                          value: widget.workout.exercises.length.toString(),
                        ),
                        SizedBox(width: 16.w),
                        _buildStatItem(
                          context,
                          icon: Icons.list,
                          label: s.sets,
                          value: widget.workout.totalSets.toString(),
                        ),
                        SizedBox(width: 16.w),
                        _buildStatItem(
                          context,
                          icon: Icons.timer,
                          label: s.duration,
                          value: _formatDuration(widget.workout.duration),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),

                    // Exercises List
                    if (widget.workout.exercises.isNotEmpty) ...[
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: widget.workout.exercises
                            .take(3)
                            .map(
                              (exercise) => Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 6.h,
                                ),
                                decoration: BoxDecoration(
                                  color: ColorsManager.primaryGreen.withOpacity(
                                    0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Text(
                                  exercise,
                                  style: TextStyles.caption.copyWith(
                                    color: ColorsManager.primaryGreen,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      if (widget.workout.exercises.length > 3)
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            '+${widget.workout.exercises.length - 3} more',
                            style: TextStyles.caption,
                          ),
                        ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 16.sp, color: ColorsManager.primaryGreen),
          SizedBox(width: 4.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: TextStyles.font14PrimaryTextMedium),
              Text(label, style: TextStyles.caption),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date).inDays;

      if (difference == 0) return 'Today';
      if (difference == 1) return 'Yesterday';
      if (difference < 7) return '$difference days ago';

      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  String _formatDuration(int minutes) {
    if (minutes < 60) return '${minutes}m';
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    return '${hours}h ${mins}m';
  }
}
