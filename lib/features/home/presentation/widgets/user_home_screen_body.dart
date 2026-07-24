import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/networking/token_manager.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../../../chat/presentation/cubits/chat_cubit.dart';
import '../../../exercises/presentation/cubit/sections_cubit.dart';
import '../../../notifications/presentation/cubit/notifications_cubit.dart';
import '../widgets/user_widgets/user_home_custom_exercises.dart';
import '../widgets/user_widgets/user_home_header.dart';
import '../widgets/user_widgets/user_home_records.dart';
import '../widgets/user_widgets/user_home_sections.dart';
import 'animated_chat_fab.dart';
import 'user_widgets/quick_actions_card.dart';

class UserHomeScreenBody extends StatefulWidget {
  const UserHomeScreenBody({super.key});

  @override
  State<UserHomeScreenBody> createState() => _UserHomeScreenBodyState();
}

class _UserHomeScreenBodyState extends State<UserHomeScreenBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _refreshController.forward();
    context.read<NotificationsCubit>().fetchUnreadCount();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    _refreshController.reset();
    await context.read<SectionsCubit>().loadSections();
    _refreshController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          color: ColorsManager.getPrimaryGreen(context),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
                  child: const UserHomeHeader(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                  child: const QuickActionsCard(),
                ),
              ),

              // SliverToBoxAdapter(
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(
              //       horizontal: 20.w,
              //       vertical: 24.h,
              //     ),
              //     child: _buildMotivationalBanner(),
              //   ),
              // ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                  child: const UserHomeRecords(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: const UserHomeSections(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: const UserHomeCustomExercises(),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 50.h)),
            ],
          ),
        ),
      ),
      // floatingActionButton: BlocProvider(
      //   create: (_) => di.get<ChatCubit>()..getUnreadCount(),
      //   child: BlocBuilder<ChatCubit, ChatState>(
      //     builder: (context, state) {
      //       final unreadCount = state is UnreadCountLoaded ? state.count : null;
      //       return AnimatedChatFAB(unreadCount: unreadCount);
      //     },
      //   ),
      // ),
    );
  }

  Widget _buildMotivationalBanner() {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final quotes = [
      s.motivational_quote_1,
      s.motivational_quote_2,
      s.motivational_quote_3,
      s.motivational_quote_4,
    ];
    final randomQuote = quotes[DateTime.now().second % quotes.length];

    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1000),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeOutCubic,
      builder: (context, double value, child) {
        final clampedValue = value.clamp(0.0, 1.0);
        return Transform.scale(
          scale: 0.95 + (0.05 * clampedValue),
          child: Opacity(opacity: clampedValue, child: child),
        );
      },
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorsManager.getPrimaryGreen(
                context,
              ).withValues(alpha: isDark ? 0.2 : 0.1),
              ColorsManager.success.withValues(alpha: isDark ? 0.15 : 0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: ColorsManager.getPrimaryGreen(
              context,
            ).withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: ColorsManager.getPrimaryGreen(
                  context,
                ).withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.auto_awesome,
                color: ColorsManager.getPrimaryGreen(context),
                size: 24.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                randomQuote,
                style: TextStyle(
                  fontSize: 14,
                  color: ColorsManager.getPrimaryText(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
