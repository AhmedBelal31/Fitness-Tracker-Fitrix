import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/screens/trainer_home_screen.dart';
import '../cubits/host_cubit.dart';
import '../cubits/host_state.dart';
import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/screens/trainer_home_screen.dart';
import '../../../trainees/presentation/screens/trainer_trainees_screen.dart';
import '../../../workouts/presentation/screens/trainer_workouts_screen.dart';
import '../../../profile/presentation/screens/trainer_profile_screen.dart';

//
// class TrainerHostScreen extends StatelessWidget {
//   const TrainerHostScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => di.get<HostCubit>(),
//       child: TrainerHostScreenBody(),
//     );
//   }
// }
//
// class TrainerHostScreenBody extends StatelessWidget {
//   TrainerHostScreenBody({super.key});
//
//   final List<Widget> _screens = [
//     const TrainerHomeScreen(),
//     const Placeholder(), // Trainees Screen
//     const Placeholder(), // Workouts Screen
//     const Placeholder(), // Profile Screen
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//
//     return BlocBuilder<HostCubit, HostState>(
//       builder: (context, state) {
//         return Scaffold(
//           body: IndexedStack(index: state.currentIndex, children: _screens),
//           bottomNavigationBar: Container(
//             decoration: BoxDecoration(boxShadow: ColorsManager.cardShadow),
//             child: BottomNavigationBar(
//               currentIndex: state.currentIndex,
//               onTap: (index) {
//                 context.read<HostCubit>().changeTab(index);
//               },
//               type: BottomNavigationBarType.fixed,
//               backgroundColor: ColorsManager.cardBackground,
//               selectedItemColor: ColorsManager.primaryGreen,
//               unselectedItemColor: ColorsManager.lightText,
//               selectedFontSize: 12,
//               unselectedFontSize: 12,
//               elevation: 8,
//               items: [
//                 BottomNavigationBarItem(
//                   icon: const Icon(Icons.home_outlined),
//                   activeIcon: const Icon(Icons.home),
//                   label: s.home,
//                 ),
//                 BottomNavigationBarItem(
//                   icon: const Icon(Icons.people_outline),
//                   activeIcon: const Icon(Icons.people),
//                   label: s.trainees,
//                 ),
//                 BottomNavigationBarItem(
//                   icon: const Icon(Icons.fitness_center_outlined),
//                   activeIcon: const Icon(Icons.fitness_center),
//                   label: s.workouts,
//                 ),
//                 BottomNavigationBarItem(
//                   icon: const Icon(Icons.person_outline),
//                   activeIcon: const Icon(Icons.person),
//                   label: s.profile,
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

class TrainerHostScreen extends StatefulWidget {
  const TrainerHostScreen({super.key});

  @override
  State<TrainerHostScreen> createState() => _TrainerHostScreenState();
}

class _TrainerHostScreenState extends State<TrainerHostScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const TrainerHomeScreen(),
    const TrainerTraineesScreen(),
    const TrainerWorkoutsScreen(),
    const TrainerProfileScreen(),
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
              icon: const Icon(Icons.people_outline),
              activeIcon: const Icon(Icons.people),
              label: s.trainees,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.fitness_center_outlined),
              activeIcon: const Icon(Icons.fitness_center),
              label: s.workouts,
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
