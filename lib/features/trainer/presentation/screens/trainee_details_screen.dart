import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../chat/presentation/cubits/chat_cubit.dart';
import '../../../workout/data/workout_session_model.dart';
import '../../../workout/presentation/cubit/workouts_cubit.dart';
import '../../../workout/presentation/cubit/workouts_state.dart';
import '../../data/models/trainee_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../generated/l10n.dart';
import '../cubits/trainee_progress_cubit.dart';
import 'package:intl/intl.dart';

class TraineeDetailsScreen extends StatelessWidget {
  final TraineeData trainee;

  const TraineeDetailsScreen({super.key, required this.trainee});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              di.get<TraineeProgressCubit>()
                ..loadProgress(traineeId: trainee.id),
        ),
        // Create a NEW WorkoutsCubit instance specifically for this trainee
        BlocProvider(
          create: (_) =>
              WorkoutsCubit(repository: di.get())
                ..loadWorkoutHistoryForTrainee(traineeId: trainee.id),
        ),
      ],
      child: TraineeDetailsScreenBody(trainee: trainee),
    );
  }
}

class TraineeDetailsScreenBody extends StatefulWidget {
  final TraineeData trainee;

  const TraineeDetailsScreenBody({super.key, required this.trainee});

  @override
  State<TraineeDetailsScreenBody> createState() =>
      _TraineeDetailsScreenBodyState();
}

class _TraineeDetailsScreenBodyState extends State<TraineeDetailsScreenBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _navigatingToWorkoutId; // Track navigation

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

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            // App Bar with Trainee Info
            SliverAppBar(
              expandedHeight: 200.h,
              pinned: true,
              backgroundColor: ColorsManager.getSecondaryGreen(
                context,
              ).withValues(alpha: 0.6),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    // Start chat with this trainee
                    final cubit = ChatCubit(repository: di.get());
                    await cubit.getOrCreateConversation(
                      otherUserId: widget.trainee.id,
                    );

                    final state = cubit.state;
                    if (state is MessagesLoaded && mounted) {
                      Navigator.pushNamed(
                        context,
                        Routes.chat,
                        arguments: {
                          'conversationId': state.conversation.id,
                          'otherUserId': widget.trainee.id,
                          'otherUserName':
                              widget.trainee.fullName ??
                              '${widget.trainee.firstName} ${widget.trainee.lastName}',
                        },
                      );
                    }
                  },
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorsManager.getSecondaryGreen(
                          context,
                        ).withValues(alpha: 0.5),
                        ColorsManager.getSecondaryGreen(
                          context,
                        ).withValues(alpha: 0.7),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40.r,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              widget.trainee.image != null &&
                                  widget.trainee.image!.isNotEmpty
                              ? NetworkImage(widget.trainee.image!)
                              : null,
                          child:
                              widget.trainee.image == null ||
                                  widget.trainee.image!.isEmpty
                              ? Text(
                                  '${widget.trainee.firstName[0]}${widget.trainee.lastName[0]}'
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.bold,
                                    color: ColorsManager.getPrimaryGreen(
                                      context,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          widget.trainee.fullName ??
                              '${widget.trainee.firstName} ${widget.trainee.lastName}',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          widget.trainee.email,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverTabBarDelegate(
                TabBar(
                  controller: _tabController,
                  indicatorColor: ColorsManager.getPrimaryGreen(context),
                  labelColor: ColorsManager.getPrimaryText(context),
                  unselectedLabelColor: ColorsManager.getSecondaryText(context),
                  tabs: [
                    Tab(text: s.overview),
                    Tab(text: s.workouts),
                  ],
                ),
                Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [_buildOverviewTab(context), _buildWorkoutsTab(context)],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(
            context,
            Routes.createWorkoutForClient,
            arguments: widget.trainee,
          ).then((_) {
            // Reload workouts after creating new one
            if (mounted) {
              context.read<WorkoutsCubit>().loadWorkoutHistoryForTrainee(
                traineeId: widget.trainee.id,
              );
            }
          });
        },
        backgroundColor: ColorsManager.getSecondaryGreen(context),
        icon: const Icon(Icons.add, color: Colors.black),
        label: Text(
          s.create_workout,
          style: TextStyles.font16WhiteRegular.copyWith(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildOverviewTab(BuildContext context) {
    final s = S.of(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.overview,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: ColorsManager.getPrimaryText(context),
            ),
          ),
          SizedBox(height: 16.h),
          _InfoCard(
            label: s.total_workouts,
            value: '${widget.trainee.totalWorkouts ?? 0}',
            icon: Icons.fitness_center,
          ),
          if (widget.trainee.currentWeight != null)
            _InfoCard(
              label: s.current_weight,
              value: '${widget.trainee.currentWeight} kg',
              icon: Icons.monitor_weight,
            ),
          if (widget.trainee.age != null)
            _InfoCard(
              label: s.age,
              value: '${widget.trainee.age}',
              icon: Icons.cake,
            ),
          _InfoCard(
            label: s.personal_records,
            value: '${widget.trainee.personalRecords ?? 0}',
            icon: Icons.emoji_events,
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutsTab(BuildContext context) {
    final s = S.of(context);

    return BlocBuilder<WorkoutsCubit, WorkoutsState>(
      buildWhen: (previous, current) {
        // Don't rebuild when navigating to workout details
        if (_navigatingToWorkoutId != null) {
          return false;
        }
        return true;
      },
      builder: (context, state) {
        if (state is WorkoutsLoading) {
          return const Center(
            child: CircularProgressIndicator(color: ColorsManager.primaryGreen),
          );
        }

        if (state is WorkoutsError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64.sp,
                  color: ColorsManager.error,
                ),
                SizedBox(height: 16.h),
                Text(
                  state.message,
                  style: TextStyle(fontSize: 14.sp, color: ColorsManager.error),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: () {
                    context.read<WorkoutsCubit>().loadWorkoutHistoryForTrainee(
                      traineeId: widget.trainee.id,
                    );
                  },
                  child: Text(s.retry),
                ),
              ],
            ),
          );
        }

        if (state is WorkoutHistoryLoaded) {
          if (state.sessions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.fitness_center_outlined,
                    size: 64.sp,
                    color: ColorsManager.getSecondaryText(context),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    s.no_workouts_yet,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.getPrimaryText(context),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    s.create_first_workout_for_client,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorsManager.getSecondaryText(context),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await context.read<WorkoutsCubit>().loadWorkoutHistoryForTrainee(
                traineeId: widget.trainee.id,
              );
            },
            color: ColorsManager.getPrimaryGreen(context),
            child: ListView.builder(
              padding: EdgeInsets.all(20.w),
              itemCount: state.sessions.length,
              itemBuilder: (context, index) {
                final workout = state.sessions[index];
                return _TraineeWorkoutCard(
                  workout: workout,
                  onTap: () async {
                    // Set flag before navigation
                    setState(() {
                      _navigatingToWorkoutId = workout.id;
                    });

                    await Navigator.pushNamed(
                      context,
                      Routes.workoutDetails,
                      arguments: workout.id,
                    );

                    // Clear flag and reload workouts after returning
                    if (mounted) {
                      setState(() {
                        _navigatingToWorkoutId = null;
                      });

                      // Reload trainee's workouts
                      context
                          .read<WorkoutsCubit>()
                          .loadWorkoutHistoryForTrainee(
                            traineeId: widget.trainee.id,
                          );
                    }
                  },
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _InfoCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: ColorsManager.getPrimaryGreen(
                context,
              ).withValues(alpha: isDark ? 0.2 : 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              color: ColorsManager.getPrimaryGreen(context),
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: ColorsManager.getSecondaryText(context),
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: ColorsManager.getPrimaryText(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _TraineeWorkoutCard extends StatelessWidget {
  final WorkoutSessionModel workout;
  final VoidCallback onTap;

  const _TraineeWorkoutCard({required this.workout, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dateFormat = DateFormat('EEEE, MMM d');
    final timeFormat = DateFormat('h:mm a');

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: workout.isCompleted
                ? ColorsManager.success.withValues(alpha: isDark ? 0.4 : 0.3)
                : ColorsManager.info.withValues(alpha: isDark ? 0.4 : 0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.3)
                  : Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color:
                        (workout.isCompleted
                                ? ColorsManager.success
                                : ColorsManager.info)
                            .withValues(alpha: isDark ? 0.15 : 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    workout.isCompleted
                        ? Icons.check_circle
                        : Icons.play_circle,
                    color: workout.isCompleted
                        ? ColorsManager.success
                        : ColorsManager.info,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dateFormat.format(workout.date),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorsManager.getPrimaryText(context),
                        ),
                      ),
                      if (workout.startTime != null)
                        Text(
                          timeFormat.format(workout.startTime!),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: ColorsManager.getSecondaryText(context),
                          ),
                        ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: ColorsManager.getSecondaryText(context),
                ),
              ],
            ),
            if (workout.notes != null && workout.notes!.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Text(
                workout.notes!,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: ColorsManager.getSecondaryText(context),
                  fontStyle: FontStyle.italic,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (workout.workoutExercises.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Row(
                children: [
                  Icon(
                    Icons.fitness_center,
                    size: 16.sp,
                    color: ColorsManager.getPrimaryGreen(context),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '${workout.workoutExercises.length} ${s.exercises}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: ColorsManager.getSecondaryText(context),
                    ),
                  ),
                  if (workout.durationMinutes != null) ...[
                    SizedBox(width: 16.w),
                    Icon(
                      Icons.timer,
                      size: 16.sp,
                      color: ColorsManager.getPrimaryGreen(context),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${workout.durationMinutes} ${s.minutes}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: ColorsManager.getSecondaryText(context),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final Color backgroundColor;

  _SliverTabBarDelegate(this.tabBar, this.backgroundColor);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: backgroundColor, child: tabBar);
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}
