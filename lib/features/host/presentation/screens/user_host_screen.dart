import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/screens/user_home_screen.dart';
import '../../../profile/presentation/screens/user_profile_screen.dart';
import '../../../progress/presentation/screens/user_progress_screen.dart';
import '../../../workout/presentation/screens/user_workouts_screen.dart';
import '../cubits/host_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ntp/ntp.dart';

// class UserHostScreen extends StatelessWidget {
//   const UserHostScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [BlocProvider(create: (context) => di.get<HostCubit>())],
//       child: const UserHostScreenBody(),
//     );
//   }
// }
//
// class UserHostScreenBody extends StatefulWidget {
//   const UserHostScreenBody({super.key});
//
//   @override
//   State<UserHostScreenBody> createState() => _UserHostScreenBodyState();
// }
//
// class _UserHostScreenBodyState extends State<UserHostScreenBody>
//     with WidgetsBindingObserver {
//   // ✅ Add lifecycle observer
//   int _currentIndex = 0;
//   static const String _lastGreetingKey = 'last_greeting_date';
//   AudioPlayer? _audioPlayer;
//
//   final List<Widget> _screens = [
//     const UserHomeScreen(),
//     const UserWorkoutsScreen(),
//     const UserProgressScreen(),
//     const UserProfileScreen(),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//
//     // ✅ Add observer for app lifecycle events
//     WidgetsBinding.instance.addObserver(this);
//
//     // Play good morning audio only in AM and once per day
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _playMorningAudio();
//     });
//   }
//
//   @override
//   void dispose() {
//     // ✅ Remove observer and stop audio
//     WidgetsBinding.instance.removeObserver(this);
//     _stopAudio();
//     _audioPlayer?.dispose();
//     super.dispose();
//   }
//
//   // ✅ Handle app lifecycle changes (background/foreground)
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);
//
//     if (state == AppLifecycleState.paused ||
//         state == AppLifecycleState.inactive) {
//       // App going to background - stop audio
//       debugPrint('📱 App going to background - stopping audio');
//       _stopAudio();
//     }
//   }
//
//   // ✅ Stop audio helper method
//   void _stopAudio() {
//     if (_audioPlayer != null) {
//       _audioPlayer!.stop();
//       debugPrint('⏹️ Audio stopped');
//     }
//   }
//
//   Future<void> _playMorningAudio() async {
//     try {
//       // Get accurate server time from NTP
//       DateTime now;
//       try {
//         now = await NTP.now();
//         debugPrint('⏰ Using NTP time: $now');
//       } catch (e) {
//         now = DateTime.now();
//         debugPrint('⚠️ NTP failed, using device time: $now');
//       }
//
//       // Check if it's morning (AM hours: 12:00 AM - 11:59 AM)
//       final isMorning = now.hour < 12;
//
//       if (!isMorning) {
//         debugPrint(
//           '🌙 Not morning time (${now.hour}:${now.minute.toString().padLeft(2, '0')}). Skipping audio.',
//         );
//         return;
//       }
//
//       // // Check if audio was already played today
//       final prefs = await SharedPreferences.getInstance();
//       final lastGreetingDate = prefs.getString(_lastGreetingKey);
//       final todayDate = '${now.year}-${now.month}-${now.day}';
//
//       if (lastGreetingDate == todayDate) {
//         debugPrint('✅ Morning audio already played today. Skipping.');
//         return;
//       }
//
//       // Play the audio
//       _audioPlayer = AudioPlayer();
//       await _audioPlayer!.setAsset('assets/sounds/good_morning.mp3');
//       await _audioPlayer!.play();
//
//       debugPrint(
//         '🔊 Playing good morning audio at ${now.hour}:${now.minute.toString().padLeft(2, '0')}',
//       );
//
//       // ✅ Listen to player state to stop when complete
//       _audioPlayer!.playerStateStream.listen((playerState) {
//         if (playerState.processingState == ProcessingState.completed) {
//           debugPrint('✅ Audio playback completed');
//         }
//       });
//
//       // Save today's date
//       await prefs.setString(_lastGreetingKey, todayDate);
//     } catch (e) {
//       debugPrint('❌ Error playing morning audio: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//
//     return Scaffold(
//       body: _screens[_currentIndex],
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(boxShadow: ColorsManager.cardShadow),
//         child: BottomNavigationBar(
//           currentIndex: _currentIndex,
//           onTap: (index) {
//             // ✅ Stop audio when switching away from home screen
//             if (_currentIndex == 0 && index != 0) {
//               debugPrint('🏠 Leaving home screen - stopping audio');
//               _stopAudio();
//             }
//
//             setState(() {
//               _currentIndex = index;
//             });
//           },
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: ColorsManager.cardBackground,
//           selectedItemColor: ColorsManager.primaryGreen,
//           unselectedItemColor: ColorsManager.lightText,
//           selectedFontSize: 12,
//           unselectedFontSize: 12,
//           elevation: 8,
//           items: [
//             BottomNavigationBarItem(
//               icon: const Icon(Icons.home_outlined),
//               activeIcon: const Icon(Icons.home),
//               label: s.home,
//             ),
//             BottomNavigationBarItem(
//               icon: const Icon(Icons.fitness_center_outlined),
//               activeIcon: const Icon(Icons.fitness_center),
//               label: s.workouts,
//             ),
//             BottomNavigationBarItem(
//               icon: const Icon(Icons.trending_up_outlined),
//               activeIcon: const Icon(Icons.trending_up),
//               label: s.progress,
//             ),
//             BottomNavigationBarItem(
//               icon: const Icon(Icons.person_outline),
//               activeIcon: const Icon(Icons.person),
//               label: s.profile,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class UserHostScreen extends StatelessWidget {
  const UserHostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => di.get<HostCubit>())],
      child: const UserHostScreenBody(),
    );
  }
}

class UserHostScreenBody extends StatefulWidget {
  const UserHostScreenBody({super.key});

  @override
  State<UserHostScreenBody> createState() => _UserHostScreenBodyState();
}

class _UserHostScreenBodyState extends State<UserHostScreenBody>
    with WidgetsBindingObserver {
  int _currentIndex = 0;
  static const String _lastGreetingKey = 'last_greeting_date';
  AudioPlayer? _audioPlayer;

  final List<Widget> _screens = [
    const UserHomeScreen(),
    const UserWorkoutsScreen(),
    const UserProgressScreen(),
    const UserProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playMorningAudio();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopAudio();
    _audioPlayer?.dispose();
    super.dispose();
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
    if (_audioPlayer != null) {
      _audioPlayer!.stop();
      debugPrint('⏹️ Audio stopped');
    }
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

      _audioPlayer = AudioPlayer();
      await _audioPlayer!.setAsset('assets/sounds/good_morning.mp3');
      await _audioPlayer!.play();

      debugPrint(
        '🔊 Playing good morning audio at ${now.hour}:${now.minute.toString().padLeft(2, '0')}',
      );

      _audioPlayer!.playerStateStream.listen((playerState) {
        if (playerState.processingState == ProcessingState.completed) {
          debugPrint('✅ Audio playback completed');
        }
      });

      await prefs.setString(_lastGreetingKey, todayDate);
    } catch (e) {
      debugPrint('❌ Error playing morning audio: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackground,
      body: _screens[_currentIndex],

      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //       colors: [
      //         ColorsManager.primaryGreen.withValues(alpha: 0.05),
      //         ColorsManager.secondaryGreen.withValues(alpha: 0.02),
      //       ],
      //       begin: Alignment.topCenter,
      //       end: Alignment.bottomCenter,
      //     ),
      //     boxShadow: [
      //       BoxShadow(
      //         color: ColorsManager.primaryGreen.withValues(alpha: 0.1),
      //         blurRadius: 30,
      //         offset: const Offset(0, -10),
      //       ),
      //     ],
      //   ),
      //   child: ClipRRect(
      //     child: BackdropFilter(
      //       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      //       child: Container(
      //         decoration: BoxDecoration(
      //           color: ColorsManager.cardBackground.withValues(alpha: 0.8),
      //           border: Border(
      //             top: BorderSide(
      //               color: ColorsManager.primaryGreen.withValues(alpha: 0.2),
      //               width: 1,
      //             ),
      //           ),
      //         ),
      //         child: SafeArea(
      //           child: Padding(
      //             padding: EdgeInsets.symmetric(
      //               horizontal: 12.w,
      //               vertical: 10.h,
      //             ),
      //             child: GNav(
      //               rippleColor: ColorsManager.primaryGreen.withValues(
      //                 alpha: 0.2,
      //               ),
      //               hoverColor: ColorsManager.primaryGreen.withValues(
      //                 alpha: 0.1,
      //               ),
      //               haptic: true,
      //               tabBorderRadius: 20.r,
      //               curve: Curves.easeOutCubic,
      //               duration: const Duration(milliseconds: 500),
      //               gap: 10.w,
      //               color: ColorsManager.secondaryText,
      //               activeColor: Colors.white,
      //               iconSize: 24.sp,
      //               tabBackgroundGradient: ColorsManager.primaryGradient,
      //               padding: EdgeInsets.symmetric(
      //                 horizontal: 16.w,
      //                 vertical: 14.h,
      //               ),
      //               tabMargin: EdgeInsets.symmetric(horizontal: 4.w),
      //               selectedIndex: _currentIndex,
      //               onTabChange: (index) {
      //                 if (_currentIndex == 0 && index != 0) {
      //                   _stopAudio();
      //                 }
      //                 setState(() => _currentIndex = index);
      //               },
      //               tabs: [
      //                 GButton(
      //                   icon: Icons.home_rounded,
      //                   text: s.home,
      //                   iconActiveColor: Colors.white,
      //                   textStyle: TextStyles.font12Bold.copyWith(
      //                     color: Colors.white,
      //                   ),
      //                 ),
      //                 GButton(
      //                   icon: Icons.fitness_center_rounded,
      //                   text: s.workouts,
      //                   iconActiveColor: Colors.white,
      //                   textStyle: TextStyles.font12Bold.copyWith(
      //                     color: Colors.white,
      //                   ),
      //                 ),
      //                 GButton(
      //                   icon: Icons.trending_up_rounded,
      //                   text: s.progress,
      //                   iconActiveColor: Colors.white,
      //                   textStyle: TextStyles.font12Bold.copyWith(
      //                     color: Colors.white,
      //                   ),
      //                 ),
      //                 GButton(
      //                   icon: Icons.person_rounded,
      //                   text: s.profile,
      //                   iconActiveColor: Colors.white,
      //                   textStyle: TextStyles.font12Bold.copyWith(
      //                     color: Colors.white,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),

      ///Second Design
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
          child: Container(
            decoration: BoxDecoration(
              color: ColorsManager.cardBackground,
              borderRadius: BorderRadius.circular(30.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                  spreadRadius: -5,
                ),
                BoxShadow(
                  color: ColorsManager.primaryGreen.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
              child: GNav(
                rippleColor: ColorsManager.primaryGreen.withValues(alpha: 0.15),
                hoverColor: ColorsManager.primaryGreen.withValues(alpha: 0.08),
                haptic: true,
                tabBorderRadius: 25.r,
                curve: Curves.easeInOutCubic,
                duration: const Duration(milliseconds: 400),
                gap: 8.w,
                color: ColorsManager.lightText,
                activeColor: ColorsManager.primaryGreen,
                iconSize: 26.sp,
                tabBackgroundColor: ColorsManager.primaryGreen.withValues(
                  alpha: 0.12,
                ),
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
                    textStyle: TextStyles.font12Bold.copyWith(
                      color: ColorsManager.primaryGreen,
                    ),
                  ),
                  GButton(
                    icon: Icons.fitness_center,
                    text: s.workouts,
                    textStyle: TextStyles.font12Bold.copyWith(
                      color: ColorsManager.primaryGreen,
                    ),
                  ),
                  GButton(
                    icon: Icons.show_chart_rounded,
                    text: s.progress,
                    textStyle: TextStyles.font12Bold.copyWith(
                      color: ColorsManager.primaryGreen,
                    ),
                  ),
                  GButton(
                    icon: Icons.person,
                    text: s.profile,
                    textStyle: TextStyles.font12Bold.copyWith(
                      color: ColorsManager.primaryGreen,
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
