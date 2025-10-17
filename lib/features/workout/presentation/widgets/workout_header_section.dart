import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../domain/entities/workout_session_entity.dart';

class WorkoutHeaderSection extends StatefulWidget {
  final WorkoutSessionEntity workout;

  const WorkoutHeaderSection({super.key, required this.workout});

  @override
  State<WorkoutHeaderSection> createState() => _WorkoutHeaderSectionState();
}

class _WorkoutHeaderSectionState extends State<WorkoutHeaderSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEEE, MMMM d, yyyy');

    return SliverAppBar(
      expandedHeight: 200.h,
      pinned: true,
      backgroundColor: ColorsManager.primaryGreen,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Container(
          width: 36.w,
          height: 36.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: FadeTransition(
          opacity: _animation,
          child: Container(
            decoration: const BoxDecoration(
              gradient: ColorsManager.appBarBackgroundGradient,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 60.h),
                Icon(
                  widget.workout.isCompleted
                      ? Icons.check_circle
                      : Icons.fitness_center,
                  size: 60.sp,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
                SizedBox(height: 12.h),
                Text(
                  dateFormat.format(widget.workout.date),
                  style: GoogleFonts.aBeeZee(
                    fontSize: 20.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (widget.workout.startTime != null)
                  Text(
                    DateFormat('h:mm a').format(widget.workout.startTime!),
                    style: TextStyles.font14WhiteMedium,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
