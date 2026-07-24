import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedIconWidget extends StatefulWidget {
  final bool isAddingToWorkout;
  final TickerProvider vsync;

  const AnimatedIconWidget({
    super.key,
    required this.isAddingToWorkout,
    required this.vsync,
  });

  @override
  State<AnimatedIconWidget> createState() => _AnimatedIconWidgetState();
}

class _AnimatedIconWidgetState extends State<AnimatedIconWidget> {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _setupRotationAnimation();
  }

  void _setupRotationAnimation() {
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: widget.vsync,
    );

    if (widget.isAddingToWorkout) {
      _rotationController.repeat();
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: widget.isAddingToWorkout
              ? _rotationController.value * 2 * 3.14159265359
              : 0.0,
          child: Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: TweenAnimationBuilder<double>(
              key: ValueKey(widget.isAddingToWorkout),
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutBack,
              builder: (context, value, scaleChild) {
                return Transform.scale(
                  scale: 0.5 + (value * 0.5),
                  child: Opacity(
                    opacity: value.clamp(0.0, 1.0),
                    child: Icon(
                      widget.isAddingToWorkout
                          ? Icons.add_circle_outline
                          : Icons.fitness_center,
                      size: 56.sp,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
