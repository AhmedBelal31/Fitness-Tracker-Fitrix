import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theming/app_colors.dart';

class HeroExerciseImage extends StatefulWidget {
  final String heroTag;
  final String? imageUrl;

  const HeroExerciseImage({
    super.key,
    required this.heroTag,
    required this.imageUrl,
  });

  @override
  State<HeroExerciseImage> createState() => _HeroExerciseImageState();
}

class _HeroExerciseImageState extends State<HeroExerciseImage>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late AnimationController _scaleController;

  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    // Pulse animation - smooth breathing effect
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Rotation animation - slow continuous spin
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * 3.14159,
    ).animate(_rotationController);

    // Scale animation - pop in effect
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );

    _scaleController.forward();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.heroTag,
      child: widget.imageUrl != null && widget.imageUrl!.isNotEmpty
          ? _buildImage()
          : _buildAnimatedPlaceholder(),
    );
  }

  Widget _buildImage() {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Animated gradient overlay
        AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ColorsManager.primaryGreen.withValues(
                      alpha: 0.1 * _pulseAnimation.value,
                    ),
                    ColorsManager.primaryGreen.withValues(
                      alpha: 0.3 * _pulseAnimation.value,
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        // Actual image
        CachedNetworkImage(
          imageUrl: widget.imageUrl!,
          fit: BoxFit.cover,
          placeholder: (context, url) => _buildAnimatedPlaceholder(),
          errorWidget: (context, url, error) => _buildAnimatedPlaceholder(),
        ),

        // Animated shine effect
        AnimatedBuilder(
          animation: _rotationController,
          builder: (context, child) {
            return Positioned(
              left: -100 + (_rotationController.value * 500),
              child: Transform.rotate(
                angle: 0.5,
                child: Container(
                  width: 100,
                  height: 500,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0),
                        Colors.white.withValues(alpha: 0.9),
                        Colors.white.withValues(alpha: 0),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAnimatedPlaceholder() {
    return AnimatedBuilder(
      animation: _scaleController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(gradient: ColorsManager.cardGradient),
            child: Center(
              child: AnimatedBuilder(
                animation: Listenable.merge([
                  _pulseController,
                  _rotationController,
                ]),
                builder: (context, child) {
                  return Transform.scale(
                    scale: _pulseAnimation.value,
                    child: Transform.rotate(
                      angle: _rotationAnimation.value,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer glow
                          Container(
                            width: 120.w,
                            height: 120.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withValues(
                                    alpha: 0.3 * _pulseAnimation.value,
                                  ),
                                  blurRadius: 30,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                          ),
                          // Icon
                          Icon(
                            Icons.fitness_center,
                            size: 100.sp,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
