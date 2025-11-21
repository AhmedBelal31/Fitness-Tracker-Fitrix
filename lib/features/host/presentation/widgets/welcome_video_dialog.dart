import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';

class WelcomeVideoDialog extends StatefulWidget {
  const WelcomeVideoDialog({super.key});

  @override
  State<WelcomeVideoDialog> createState() => _WelcomeVideoDialogState();
}

class _WelcomeVideoDialogState extends State<WelcomeVideoDialog> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();

    const videoUrl =
        'https://youtube.com/shorts/gaUfb5iLqAo?si=odLCRdO6QzQYlOJO';
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);

    _controller =
        YoutubePlayerController(
          initialVideoId: videoId!,
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
            enableCaption: false,
            loop: false,
          ),
        )..addListener(() {
          if (_controller.value.isReady && !_isPlayerReady) {
            setState(() {
              _isPlayerReady = true;
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
    // Get screen dimensions
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: 16.w, // Smaller horizontal padding for wider dialog
        vertical: screenHeight * 0.1, // 10% padding from top and bottom
      ),
      child: Container(
        width: screenWidth * 0.95, // 95% of screen width
        height: screenHeight * 0.8, // 80% of screen height
        decoration: BoxDecoration(
          color: ColorsManager.scaffoldBackground,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with close button
            _buildHeader(context),

            // Expanded Video Player (takes up most space)
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: AspectRatio(
                    aspectRatio: 9 / 16, // Vertical video (Shorts)
                    child: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: ColorsManager.primaryGreen,
                      progressColors: ProgressBarColors(
                        playedColor: ColorsManager.primaryGreen,
                        handleColor: ColorsManager.primaryGreen,
                      ),
                      onReady: () {
                        setState(() {
                          _isPlayerReady = true;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),

            // Footer message
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
              child: Text(
                'Welcome to Fitrix! Watch this quick intro.',
                style: TextStyles.font16LightTextRegular.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        gradient: ColorsManager.primaryGradient,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.play_circle_outline,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(width: 12.w),
              Text(
                'Welcome Video',
                style: TextStyles.font18WhiteMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 24),
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

// Fix for ClipRRectangle typo
class ClipRRectangle extends StatelessWidget {
  final BorderRadius borderRadius;
  final Widget child;

  const ClipRRectangle({
    super.key,
    required this.borderRadius,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(borderRadius: borderRadius, child: child);
  }
}
