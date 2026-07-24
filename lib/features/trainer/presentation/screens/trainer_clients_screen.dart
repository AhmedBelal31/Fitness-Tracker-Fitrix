// lib/features/trainer/presentation/screens/trainer_clients_screen.dart
import 'package:fitrix/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/get_it.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../trainer_requests/presentation/cubit/trainer_requests_cubit.dart'
    hide TrainerRequestsCubit;
import '../cubits/trainees_cubit.dart';
import '../widgets/active_trainees_tab.dart';
import '../widgets/find_clients_tab.dart';
import '../widgets/requests_tab.dart';

import '../cubits/trainer_requests_cubit.dart';

class TrainerClientsScreen extends StatelessWidget {
  const TrainerClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide BOTH cubits at the top level
    return MultiBlocProvider(
      providers: [
        BlocProvider<TraineesCubit>(
          create: (context) => di.get<TraineesCubit>()..loadTrainees(),
        ),
        BlocProvider<TrainerRequestsCubit>(
          create: (context) => di.get<TrainerRequestsCubit>(),
        ),
      ],
      child: const TrainerClientsScreenBody(),
    );
  }
}

class TrainerClientsScreenBody extends StatefulWidget {
  const TrainerClientsScreenBody({super.key});

  @override
  State<TrainerClientsScreenBody> createState() =>
      _TrainerClientsScreenBodyState();
}

class _TrainerClientsScreenBodyState extends State<TrainerClientsScreenBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorsManager.getSecondaryGreen(
          context,
        ).withValues(alpha: .85),
        title: Text(s.my_clients, style: TextStyles.font20WhiteBold),
        actions: [
          IconButton(
            onPressed: () {
              _showAddClientDialog(context);
            },
            icon: const Icon(
              Icons.person_add_rounded,
              color: ColorsManager.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 16.h),

          // Tabs
          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: 16.w),
          //   decoration: BoxDecoration(
          //     color: Theme.of(context).cardTheme.color,
          //     borderRadius: BorderRadius.circular(16.r),
          //   ),
          //   child: TabBar(
          //     controller: _tabController,
          //     indicator: BoxDecoration(
          //       color: ColorsManager.getPrimaryGreen(context),
          //       borderRadius: BorderRadius.circular(16.r),
          //     ),
          //     dividerColor: Colors.transparent,
          //     labelColor: Colors.white,
          //     unselectedLabelColor: ColorsManager.getSecondaryText(context),
          //     labelStyle: TextStyle(
          //       fontSize: 13.sp,
          //       fontWeight: FontWeight.bold,
          //     ),
          //     tabs: const [
          //       Tab(text: 'Active'),
          //       Tab(text: 'Requests'),
          //       Tab(text: 'Find'),
          //     ],
          //   ),
          // ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTabItem("Active", 0),
                _buildTabItem("Requests", 1),
                _buildTabItem("Find", 2),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ActiveTraineesTab(),
                RequestsTab(),
                FindClientsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          _tabController.animateTo(index);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 18.w),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorsManager.getSecondaryGreen(context)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected
                ? Colors.black
                : ColorsManager.getSecondaryText(context),
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }

  void _showAddClientDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(S.of(context).add_client),
        content: Text(S.of(context).add_client_description),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(S.of(context).cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              _tabController.animateTo(2);
            },
            child: Text(S.of(context).find_clients),
          ),
        ],
      ),
    );
  }
}
