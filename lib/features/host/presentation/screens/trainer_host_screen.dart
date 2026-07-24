import 'package:fitrix/features/host/presentation/screens/user_host_screen.dart';
import 'package:fitrix/features/profile/presentation/screens/user_profile_screen.dart';
import 'package:fitrix/features/workout/presentation/screens/user_workouts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/screens/trainer_home_screen.dart';
import '../../../progress/presentation/screens/user_progress_screen.dart';
import '../../../trainer/presentation/cubits/trainees_cubit.dart';
import '../../../trainer/presentation/screens/trainer_clients_screen.dart';
import '../../../trainer/presentation/screens/trainer_workouts_screen.dart';
import '../cubits/host_cubit.dart';

// class TrainerHostScreen extends StatefulWidget {
//   const TrainerHostScreen({super.key});
//
//   @override
//   State<TrainerHostScreen> createState() => _TrainerHostScreenState();
// }
//
// class _TrainerHostScreenState extends State<TrainerHostScreen> {
//   int _currentIndex = 0;
//
//   final List<Widget> _screens = [
//     const TrainerHomeScreen(),
//     const TrainerTraineesScreen(),
//     UserProgressScreen(isVisible: () => _currentIndex == 2),
//     const UserProfileScreen(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//
//     return Scaffold(
//       body: IndexedStack(index: _currentIndex, children: _screens),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(boxShadow: ColorsManager.cardShadow),
//         child: BottomNavigationBar(
//           currentIndex: _currentIndex,
//           onTap: (index) {
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
//               icon: const Icon(Icons.people_outline),
//               activeIcon: const Icon(Icons.people),
//               label: s.trainees,
//             ),
//             BottomNavigationBarItem(
//               icon: const Icon(Icons.fitness_center_outlined),
//               activeIcon: const Icon(Icons.fitness_center),
//               label: s.workouts,
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

// class TrainerHostScreen extends StatelessWidget {
//   const TrainerHostScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [BlocProvider(create: (context) => di.get<HostCubit>())],
//       child: const UserHostScreenBody(),
//     );
//   }
// }
// Update TrainerHostScreen to use similar structure
class TrainerHostScreen extends StatelessWidget {
  const TrainerHostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.get<HostCubit>()),
        BlocProvider(create: (context) => di.get<TraineesCubit>()),
      ],
      child: const TrainerHostScreenBody(),
    );
  }
}

class TrainerHostScreenBody extends StatefulWidget {
  const TrainerHostScreenBody({super.key});

  @override
  State<TrainerHostScreenBody> createState() => _TrainerHostScreenBodyState();
}

class _TrainerHostScreenBodyState extends State<TrainerHostScreenBody> {
  int _currentIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _screens = [
      const TrainerHomeScreen(), // Dashboard
      const TrainerClientsScreen(), // Manage clients
      UserWorkoutsScreen(),
      // const TrainerWorkoutsScreen(), // NEW: Separate workouts screen with tabs
      UserProgressScreen(isVisible: () => _currentIndex == 3),
      const UserProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final showText = screenWidth > 380; // Show text only on wider screens

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // body: IndexedStack(index: _currentIndex, children: _screens),
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
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
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: showText ? 4.w : 8.w,
                vertical: 10.h,
              ),
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
                gap: showText ? 6.w : 0, // No gap if icons only
                color: isDark
                    ? ColorsManager.darkSecondaryText
                    : ColorsManager.lightSecondaryText,
                activeColor: ColorsManager.getPrimaryGreen(context),
                iconSize: 24.sp,
                tabBackgroundColor: ColorsManager.getPrimaryGreen(
                  context,
                ).withValues(alpha: isDark ? 0.2 : 0.12),
                padding: EdgeInsets.symmetric(
                  horizontal: showText ? 12.w : 16.w,
                  vertical: 12.h,
                ),
                tabMargin: EdgeInsets.symmetric(horizontal: 1.w),
                selectedIndex: _currentIndex,
                onTabChange: (index) => setState(() => _currentIndex = index),
                tabs: [
                  GButton(
                    icon: Icons.dashboard_rounded,
                    text: showText ? s.home : '',
                    textStyle: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.getPrimaryGreen(context),
                    ),
                  ),
                  GButton(
                    icon: Icons.people_rounded,
                    text: showText ? s.clients : '',
                    textStyle: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.getPrimaryGreen(context),
                    ),
                  ),
                  GButton(
                    icon: Icons.fitness_center,
                    text: showText ? s.workouts : '',
                    textStyle: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.getPrimaryGreen(context),
                    ),
                  ),
                  GButton(
                    icon: Icons.show_chart_rounded,
                    text: showText ? s.progress : '',
                    textStyle: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.getPrimaryGreen(context),
                    ),
                  ),
                  GButton(
                    icon: Icons.person,
                    text: showText ? s.profile : '',
                    textStyle: TextStyle(
                      fontSize: 11.sp,
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
