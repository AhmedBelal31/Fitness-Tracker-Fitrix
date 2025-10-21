import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/services/sound_service.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/screens/user_home_screen.dart';
import '../../../profile/presentation/screens/user_profile_screen.dart';
import '../../../progress/presentation/screens/user_progress_screen.dart';
import '../../../workout/presentation/screens/user_workouts_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ntp/ntp.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class UserHostScreenBody extends StatefulWidget {
  const UserHostScreenBody({super.key});

  @override
  State<UserHostScreenBody> createState() => _UserHostScreenBodyState();
}

class _UserHostScreenBodyState extends State<UserHostScreenBody>
    with WidgetsBindingObserver {
  int _currentIndex = 0;
  static const String _lastGreetingKey = 'last_greeting_date';

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _screens = [
      const UserHomeScreen(),
      const UserWorkoutsScreen(),
      UserProgressScreen(isVisible: () => _currentIndex == 2),
      const UserProfileScreen(),
    ];

    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playMorningAudio();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      debugPrint('📱 App going to background - stopping audio');
      _stopAudio();
    }
  }

  void _stopAudio() {
    SoundService.instance.stopSound();
    debugPrint('⏹️ Audio stopped');
  }

  Future<void> _playMorningAudio() async {
    try {
      DateTime now;
      try {
        now = await NTP.now();
        debugPrint('⏰ Using NTP time: $now');
      } catch (e) {
        now = DateTime.now();
        debugPrint('⚠️ NTP failed, using device time: $now');
      }

      final isMorning = now.hour < 12;

      if (!isMorning) {
        debugPrint(
          '🌙 Not morning time (${now.hour}:${now.minute.toString().padLeft(2, '0')}). Skipping audio.',
        );
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      final lastGreetingDate = prefs.getString(_lastGreetingKey);
      final todayDate = '${now.year}-${now.month}-${now.day}';

      if (lastGreetingDate == todayDate) {
        debugPrint('✅ Morning audio already played today. Skipping.');
        return;
      }

      await SoundService.instance.playSound(
        'assets/sounds/good_morning.mp3',
        volume: 0.8,
      );

      debugPrint(
        '🔊 Playing good morning audio at ${now.hour}:${now.minute.toString().padLeft(2, '0')}',
      );

      await prefs.setString(_lastGreetingKey, todayDate);
    } catch (e) {
      debugPrint('❌ Error playing morning audio: $e');
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(30.r),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.4)
                      : Colors.black.withValues(alpha: 0.15),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                  spreadRadius: -5,
                ),
                BoxShadow(
                  color: ColorsManager.getPrimaryGreen(
                    context,
                  ).withValues(alpha: isDark ? 0.2 : 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
              child: GNav(
                rippleColor: ColorsManager.getPrimaryGreen(
                  context,
                ).withValues(alpha: 0.15),
                hoverColor: ColorsManager.getPrimaryGreen(
                  context,
                ).withValues(alpha: 0.08),
                haptic: true,
                tabBorderRadius: 25.r,
                curve: Curves.easeInOutCubic,
                duration: const Duration(milliseconds: 400),
                gap: 8.w,
                color: isDark
                    ? ColorsManager.darkSecondaryText
                    : ColorsManager.lightSecondaryText,
                activeColor: ColorsManager.getPrimaryGreen(context),
                iconSize: 26.sp,
                tabBackgroundColor: ColorsManager.getPrimaryGreen(
                  context,
                ).withValues(alpha: isDark ? 0.2 : 0.12),
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
                tabMargin: EdgeInsets.symmetric(horizontal: 2.w),
                selectedIndex: _currentIndex,
                onTabChange: (index) {
                  if (_currentIndex == 0 && index != 0) {
                    _stopAudio();
                  }
                  setState(() => _currentIndex = index);
                },
                tabs: [
                  GButton(
                    icon: Icons.home_filled,
                    text: s.home,
                    textStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.getPrimaryGreen(context),
                    ),
                  ),
                  GButton(
                    icon: Icons.fitness_center,
                    text: s.workouts,
                    textStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.getPrimaryGreen(context),
                    ),
                  ),
                  GButton(
                    icon: Icons.show_chart_rounded,
                    text: s.progress,
                    textStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.getPrimaryGreen(context),
                    ),
                  ),
                  GButton(
                    icon: Icons.person,
                    text: s.profile,
                    textStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.getPrimaryGreen(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
