import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../chat/presentation/cubits/chat_cubit.dart';
import '../../../exercises/presentation/cubit/sections_cubit.dart';
import '../../../host/presentation/widgets/trainee_card.dart';
import '../../../notifications/presentation/cubit/notifications_cubit.dart';
import '../../../trainer/presentation/cubits/trainer_dashboard_cubit.dart';
import '../../../trainer/presentation/widgets/active_trainees_section.dart';
import '../../../trainer/presentation/widgets/pending_requests_section.dart';
import '../../../trainer/presentation/widgets/trainer_home_header.dart';
import '../../../trainer/presentation/widgets/trainer_quick_actions.dart';
import '../../../trainer/presentation/widgets/trainer_stats_card.dart';
import '../widgets/animated_chat_fab.dart';
import '../widgets/user_widgets/quick_actions_card.dart';
import '../widgets/user_widgets/user_home_custom_exercises.dart';
import '../widgets/user_widgets/user_home_header.dart';
import '../widgets/user_widgets/user_home_records.dart';
import '../widgets/user_widgets/user_home_sections.dart';

class TrainerHomeScreen extends StatelessWidget {
  const TrainerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.get<TrainerDashboardCubit>()..loadDashboard(),
        ),
        BlocProvider(create: (_) => di.get<SectionsCubit>()..loadSections()),
        BlocProvider(
          create: (_) => di.get<NotificationsCubit>()..fetchUnreadCount(),
        ),
      ],
      child: const TrainerHomeScreenBody(),
    );
  }
}

class TrainerHomeScreenBody extends StatefulWidget {
  const TrainerHomeScreenBody({super.key});

  @override
  State<TrainerHomeScreenBody> createState() => _TrainerHomeScreenBodyState();
}

class _TrainerHomeScreenBodyState extends State<TrainerHomeScreenBody>
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

  Future<void> _onRefresh() async {
    await Future.wait([
      context.read<TrainerDashboardCubit>().loadDashboard(),
      context.read<SectionsCubit>().loadSections(),
      context.read<NotificationsCubit>().fetchUnreadCount(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: BlocProvider(
        create: (_) => di.get<ChatCubit>()..getUnreadCount(),
        child: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            final unreadCount = state is UnreadCountLoaded ? state.count : null;
            return AnimatedChatFAB(unreadCount: unreadCount);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
              child: const UserHomeHeader(), // Same header for both
            ),

            // Tab Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: ColorsManager.getPrimaryGreen(
                      context,
                    ).withValues(alpha: 0.2),
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: ColorsManager.getSecondaryGreen(
                      context,
                    ).withValues(alpha: .8),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: ColorsManager.getSecondaryText(context),
                  labelStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person, size: 18.sp),
                          SizedBox(width: 8.w),
                          Text(s.my_training),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.dashboard, size: 18.sp),
                          SizedBox(width: 8.w),
                          Text(s.trainer_mode),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Tab Views
            Expanded(
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                color: ColorsManager.getPrimaryGreen(context),
                child: TabBarView(
                  controller: _tabController,
                  children: [_buildMyTrainingTab(), _buildTrainerModeTab()],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Trainer Mode Tab (Dashboard for managing clients)
  Widget _buildTrainerModeTab() {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        // Dashboard Stats
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: const TrainerStatsCard(),
          ),
        ),

        // Pending Requests
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: const PendingRequestsSection(),
          ),
        ),

        // Active Trainees
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: const ActiveTraineesSection(),
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 50.h)),
      ],
    );
  }

  // My Training Tab (Personal workout tracking)
  Widget _buildMyTrainingTab() {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        // Quick Actions Card
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: const QuickActionsCard(),
          ),
        ),

        // Personal Records
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
            child: const UserHomeRecords(),
          ),
        ),

        // Exercise Sections
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: const UserHomeSections(),
          ),
        ),

        // Custom Exercises
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: const UserHomeCustomExercises(),
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 50.h)),
      ],
    );
  }
}
