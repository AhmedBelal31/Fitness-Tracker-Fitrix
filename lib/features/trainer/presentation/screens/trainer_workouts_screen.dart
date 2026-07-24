import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../workout/presentation/screens/user_workouts_screen.dart';
import '../cubits/trainees_cubit.dart';
import '../widgets/client_workouts_tab.dart';

class TrainerWorkoutsScreen extends StatefulWidget {
  const TrainerWorkoutsScreen({super.key});

  @override
  State<TrainerWorkoutsScreen> createState() => _TrainerWorkoutsScreenState();
}

class _TrainerWorkoutsScreenState extends State<TrainerWorkoutsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return BlocProvider(
      create: (context) => di.get<TraineesCubit>()..loadTrainees(), // ADD THIS
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: ColorsManager.getSecondaryGreen(context),
          title: Text(s.workouts),
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            labelColor: Colors.black,

            unselectedLabelColor: Colors.black.withValues(alpha: 0.7),
            tabs: [
              Tab(text: s.my_workouts),
              Tab(text: s.client_workouts),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          physics: BouncingScrollPhysics(),
          children: [
            // Personal workouts (same as regular user)
            UserWorkoutsScreen(isVisible: () => _tabController.index == 0),

            // Client workouts
            const ClientWorkoutsTab(),
          ],
        ),
      ),
    );
  }
}
