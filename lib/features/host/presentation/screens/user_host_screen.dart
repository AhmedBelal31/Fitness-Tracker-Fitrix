import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/screens/user_home_screen.dart';
import '../../../profile/presentation/screens/user_profile_screen.dart';
import '../../../progress/presentation/screens/user_progress_screen.dart';
import '../../../workouts/presentation/screens/user_workouts_screen.dart';
import '../cubits/host_cubit.dart';
import '../cubits/host_state.dart';

class UserHostScreen extends StatelessWidget {
  const UserHostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.get<HostCubit>(),
      child: UserHostScreenBody(),
    );
  }
}

class UserHostScreenBody extends StatefulWidget {
  const UserHostScreenBody({super.key});

  @override
  State<UserHostScreenBody> createState() => _UserHostScreenBodyState();
}

class _UserHostScreenBodyState extends State<UserHostScreenBody> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const UserHomeScreen(),
    const UserWorkoutsScreen(),
    const UserProgressScreen(),
    const UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: ColorsManager.cardShadow),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: ColorsManager.cardBackground,
          selectedItemColor: ColorsManager.primaryGreen,
          unselectedItemColor: ColorsManager.lightText,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          elevation: 8,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label: s.home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.fitness_center_outlined),
              activeIcon: const Icon(Icons.fitness_center),
              label: s.workouts,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.trending_up_outlined),
              activeIcon: const Icon(Icons.trending_up),
              label: s.progress,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline),
              activeIcon: const Icon(Icons.person),
              label: s.profile,
            ),
          ],
        ),
      ),
    );
  }
}
