// lib/features/chat/presentation/screens/conversations_screen.dart
import 'package:fitrix/features/user_requests/data/trainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/routing/routes.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../trainer/data/models/trainee_data.dart';
import '../../../trainer/presentation/cubits/trainees_states.dart';
import '../../../user_requests/presentation/cubit/user_requests_cubit.dart';
import '../../../user_requests/presentation/cubit/user_requests_state.dart';
import '../../data/models/chat_conversation.dart';
import '../cubits/chat_cubit.dart';
// lib/features/chat/presentation/screens/conversations_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/networking/token_manager.dart';
import '../../../../core/routing/routes.dart';
import '../../../../generated/l10n.dart';
import '../../../trainer/presentation/cubits/trainees_cubit.dart';
import '../cubits/chat_cubit.dart';

class ConversationsScreen extends StatelessWidget {
  const ConversationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: TokenManager.instance.isTrainer,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: ColorsManager.primaryGreen,
              ),
            ),
          );
        }

        final isTrainer = snapshot.data!;

        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => di.get<ChatCubit>()..loadConversations(),
            ),
            if (isTrainer)
              BlocProvider(
                create: (_) => di.get<TraineesCubit>()..loadTrainees(),
              )
            else
              BlocProvider(
                create: (_) =>
                    di.get<UserRequestsCubit>()..getAllTrainers(pageSize: 50),
              ),
          ],
          child: ConversationsScreenBody(isTrainer: isTrainer),
        );
      },
    );
  }
}

class ConversationsScreenBody extends StatefulWidget {
  final bool isTrainer;

  const ConversationsScreenBody({super.key, required this.isTrainer});

  @override
  State<ConversationsScreenBody> createState() =>
      _ConversationsScreenBodyState();
}

class _ConversationsScreenBodyState extends State<ConversationsScreenBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorsManager.getSecondaryGreen(
          context,
        ).withValues(alpha: 0.65),
        title: Text(s.messages),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(110.h),
          child: Column(
            children: [
              // Search Bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value.toLowerCase();
                    });
                  },
                  style: TextStyle(fontSize: 14.sp, color: ColorsManager.white),
                  decoration: InputDecoration(
                    hintText: s.search_conversations,
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: ColorsManager.white,
                    ),
                    prefixIcon: Icon(Icons.search, color: ColorsManager.white),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear, color: ColorsManager.red),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.15),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              // Tab Bar
              TabBar(
                controller: _tabController,
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white.withValues(alpha: 0.6),
                labelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
                tabs: [
                  Tab(text: s.recent_chats),
                  Tab(text: widget.isTrainer ? s.all_clients : s.all_trainers),
                ],
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRecentChatsTab(),
          widget.isTrainer ? _buildAllClientsTab() : _buildAllTrainersTab(),
        ],
      ),
    );
  }

  Widget _buildRecentChatsTab() {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return RefreshIndicator(
      onRefresh: () async {
        await context.read<ChatCubit>().loadConversations();
      },
      color: ColorsManager.getPrimaryGreen(context),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorsManager.primaryGreen,
              ),
            );
          }

          if (state is ChatError) {
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
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorsManager.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ChatCubit>().loadConversations();
                    },
                    child: Text(s.retry),
                  ),
                ],
              ),
            );
          }

          if (state is ConversationsLoaded) {
            final filteredConversations = _searchQuery.isEmpty
                ? state.conversations
                : state.conversations
                      .where(
                        (conv) => conv.otherUserName.toLowerCase().contains(
                          _searchQuery,
                        ),
                      )
                      .toList();

            if (filteredConversations.isEmpty) {
              return Center(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _searchQuery.isEmpty
                            ? Icons.chat_bubble_outline
                            : Icons.search_off,
                        size: 64.sp,
                        color: ColorsManager.getSecondaryText(context),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        _searchQuery.isEmpty
                            ? s.no_conversations
                            : s.no_results_found,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.getPrimaryText(context),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        _searchQuery.isEmpty
                            ? s.start_chatting_with_clients_tab
                            : s.try_different_search,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: ColorsManager.getSecondaryText(context),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (_searchQuery.isEmpty) ...[
                        SizedBox(height: 16.h),
                        ElevatedButton.icon(
                          onPressed: () {
                            _tabController.animateTo(1);
                          },
                          icon: const Icon(Icons.people),
                          label: Text(
                            widget.isTrainer
                                ? s.view_all_clients
                                : s.view_all_trainers,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsManager.getPrimaryGreen(
                              context,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }

            return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemCount: filteredConversations.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                indent: 88.w,
                color: isDark
                    ? ColorsManager.darkBorder
                    : ColorsManager.lightBorder,
              ),
              itemBuilder: (context, index) {
                final conversation = filteredConversations[index];
                return _ConversationTile(conversation: conversation);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildAllClientsTab() {
    final s = S.of(context);

    return RefreshIndicator(
      onRefresh: () async {
        await context.read<TraineesCubit>().loadTrainees();
      },
      color: ColorsManager.getPrimaryGreen(context),
      child: BlocBuilder<TraineesCubit, TraineesState>(
        builder: (context, state) {
          if (state is TraineesLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorsManager.primaryGreen,
              ),
            );
          }

          if (state is TraineesError) {
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
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorsManager.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () {
                      context.read<TraineesCubit>().loadTrainees();
                    },
                    child: Text(s.retry),
                  ),
                ],
              ),
            );
          }

          if (state is TraineesLoaded) {
            final filteredTrainees = _searchQuery.isEmpty
                ? state.trainees
                : state.trainees
                      .where(
                        (trainee) =>
                            trainee.fullName?.toLowerCase().contains(
                              _searchQuery,
                            ) ??
                            trainee.firstName.toLowerCase().contains(
                                  _searchQuery,
                                ) ||
                                trainee.lastName.toLowerCase().contains(
                                  _searchQuery,
                                ),
                      )
                      .toList();

            if (filteredTrainees.isEmpty) {
              return Center(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _searchQuery.isEmpty
                            ? Icons.people_outline
                            : Icons.search_off,
                        size: 64.sp,
                        color: ColorsManager.getSecondaryText(context),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        _searchQuery.isEmpty
                            ? s.no_clients
                            : s.no_results_found,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.getPrimaryText(context),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        _searchQuery.isEmpty
                            ? s.add_clients_to_chat
                            : s.try_different_search,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: ColorsManager.getSecondaryText(context),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }

            return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemCount: filteredTrainees.length,
              separatorBuilder: (context, index) =>
                  Divider(height: 1, indent: 88.w),
              itemBuilder: (context, index) {
                final trainee = filteredTrainees[index];
                return _TraineeTile(trainee: trainee);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildAllTrainersTab() {
    final s = S.of(context);

    return RefreshIndicator(
      onRefresh: () async {
        // ✅ Use getAllTrainers from UserRequestsCubit
        await context.read<UserRequestsCubit>().getAllTrainers(pageSize: 50);
      },
      color: ColorsManager.getPrimaryGreen(context),
      child: BlocBuilder<UserRequestsCubit, UserRequestsState>(
        builder: (context, state) {
          // ✅ Check if state is UserRequestsData
          if (state is UserRequestsData) {
            // Show loading if trainers are being loaded
            if (state.isTrainersLoading &&
                (state.trainers == null || state.trainers!.isEmpty)) {
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.primaryGreen,
                ),
              );
            }

            // Show error if there's an error and no trainers
            if (state.error != null &&
                (state.trainers == null || state.trainers!.isEmpty)) {
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
                      state.error!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: ColorsManager.error,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () {
                        context.read<UserRequestsCubit>().getAllTrainers(
                          pageSize: 50,
                        );
                      },
                      child: Text(s.retry),
                    ),
                  ],
                ),
              );
            }

            // Get trainers list
            final trainers = state.trainers ?? [];

            // Filter trainers by search query
            // In _buildAllTrainersTab method, update the filter:

            final filteredTrainers = _searchQuery.isEmpty
                ? trainers
                : trainers
                      .where(
                        (trainer) =>
                            trainer.name.toLowerCase().contains(_searchQuery),
                      )
                      .toList();

            if (filteredTrainers.isEmpty) {
              return Center(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _searchQuery.isEmpty
                            ? Icons.people_outline
                            : Icons.search_off,
                        size: 64.sp,
                        color: ColorsManager.getSecondaryText(context),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        _searchQuery.isEmpty
                            ? s.no_trainers
                            : s.no_results_found,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.getPrimaryText(context),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        _searchQuery.isEmpty
                            ? s.no_trainers_available
                            : s.try_different_search,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: ColorsManager.getSecondaryText(context),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }

            return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemCount: filteredTrainers.length,
              separatorBuilder: (context, index) =>
                  Divider(height: 1, indent: 88.w),
              itemBuilder: (context, index) {
                final trainer = filteredTrainers[index];
                return _TrainerTile(trainer: trainer);
              },
            );
          }

          // Initial state - show loading
          return const Center(
            child: CircularProgressIndicator(color: ColorsManager.primaryGreen),
          );
        },
      ),
    );
  }
}
// lib/features/chat/presentation/screens/conversations_screen.dart

// Add this widget class at the end of the file

// lib/features/chat/presentation/screens/conversations_screen.dart

class _TrainerTile extends StatelessWidget {
  final Trainer trainer;

  const _TrainerTile({required this.trainer});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      leading: CircleAvatar(
        radius: 28.r,
        backgroundColor: ColorsManager.getPrimaryGreen(
          context,
        ).withValues(alpha: 0.2),
        backgroundImage: trainer.image != null && trainer.image!.isNotEmpty
            ? NetworkImage(trainer.image!)
            : null,
        child: trainer.image == null || trainer.image!.isEmpty
            ? Text(
                trainer.name.isNotEmpty ? trainer.name[0].toUpperCase() : 'T',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.getPrimaryGreen(context),
                ),
              )
            : null,
      ),
      title: Text(
        trainer.name,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: ColorsManager.getPrimaryText(context),
        ),
      ),
      subtitle: Text(
        trainer.email ?? 'No email',
        style: TextStyle(
          fontSize: 14.sp,
          color: ColorsManager.getSecondaryText(context),
        ),
      ),
      trailing: Icon(
        Icons.chat_bubble_outline,
        color: ColorsManager.getPrimaryGreen(context),
      ),
      onTap: () async {
        final s = S.of(context);

        // Show loading
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(color: ColorsManager.primaryGreen),
          ),
        );

        // Get or create conversation
        await context.read<ChatCubit>().getOrCreateConversation(
          otherUserId: trainer.id,
        );

        // Hide loading
        if (context.mounted) Navigator.pop(context);

        final state = context.read<ChatCubit>().state;

        if (state is MessagesLoaded && context.mounted) {
          Navigator.pushNamed(
            context,
            Routes.chat,
            arguments: {
              'conversationId': state.conversation.id,
              'otherUserId': trainer.id,
              'otherUserName': trainer.name,
              'otherUserImage': trainer.image,
            },
          );
        } else if (state is ChatError && context.mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: ColorsManager.warning,
                    size: 28.sp,
                  ),
                  SizedBox(width: 12.w),
                  Text(s.cannot_start_chat),
                ],
              ),
              content: Text(state.message),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(s.ok),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class _ConversationTile extends StatelessWidget {
  final ChatConversation conversation;

  const _ConversationTile({required this.conversation});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasUnread = conversation.unreadCount > 0;

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 28.r,
            backgroundColor: ColorsManager.getPrimaryGreen(
              context,
            ).withValues(alpha: 0.2),
            backgroundImage:
                conversation.otherUserImage != null &&
                    conversation.otherUserImage!.isNotEmpty
                ? NetworkImage(conversation.otherUserImage!)
                : null,
            child:
                conversation.otherUserImage == null ||
                    conversation.otherUserImage!.isEmpty
                ? Text(
                    conversation.otherUserName[0].toUpperCase(),
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.getPrimaryGreen(context),
                    ),
                  )
                : null,
          ),
          if (conversation.isOnline)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 14.w,
                height: 14.w,
                decoration: BoxDecoration(
                  color: ColorsManager.success,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              conversation.otherUserName,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: hasUnread ? FontWeight.bold : FontWeight.w600,
                color: ColorsManager.getPrimaryText(context),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (conversation.lastMessageAt != null)
            Text(
              _formatTime(conversation.lastMessageAt!),
              style: TextStyle(
                fontSize: 12.sp,
                color: hasUnread
                    ? ColorsManager.getPrimaryGreen(context)
                    : ColorsManager.getSecondaryText(context),
                fontWeight: hasUnread ? FontWeight.bold : FontWeight.normal,
              ),
            ),
        ],
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Text(
              conversation.lastMessage ?? 'No messages yet',
              style: TextStyle(
                fontSize: 14.sp,
                color: hasUnread
                    ? ColorsManager.getPrimaryText(context)
                    : ColorsManager.getSecondaryText(context),
                fontWeight: hasUnread ? FontWeight.w600 : FontWeight.normal,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (hasUnread)
            Container(
              margin: EdgeInsets.only(left: 8.w),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: ColorsManager.getPrimaryGreen(context),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                '${conversation.unreadCount}',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: isDark ? ColorsManager.darkScaffold : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.chat,
          arguments: {
            'conversationId': conversation.id,
            'otherUserId': conversation.otherUserId,
            'otherUserName': conversation.otherUserName,
          },
        );
      },
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return DateFormat('HH:mm').format(dateTime);
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return DateFormat('EEE').format(dateTime);
    } else {
      return DateFormat('MMM d').format(dateTime);
    }
  }
}
// lib/features/chat/presentation/screens/conversations_screen.dart

// lib/features/chat/presentation/screens/conversations_screen.dart

class _TraineeTile extends StatelessWidget {
  final TraineeData trainee;

  const _TraineeTile({required this.trainee});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      leading: CircleAvatar(
        radius: 28.r,
        backgroundColor: ColorsManager.getPrimaryGreen(
          context,
        ).withValues(alpha: 0.2),
        backgroundImage: trainee.image != null && trainee.image!.isNotEmpty
            ? NetworkImage(trainee.image!)
            : null,
        child: trainee.image == null || trainee.image!.isEmpty
            ? Text(
                '${trainee.firstName[0]}${trainee.lastName[0]}'.toUpperCase(),
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.getPrimaryGreen(context),
                ),
              )
            : null,
      ),
      title: Text(
        trainee.fullName ?? '${trainee.firstName} ${trainee.lastName}',
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: ColorsManager.getPrimaryText(context),
        ),
      ),
      subtitle: Text(
        trainee.email,
        style: TextStyle(
          fontSize: 14.sp,
          color: ColorsManager.getSecondaryText(context),
        ),
      ),
      trailing: Icon(
        Icons.chat_bubble_outline,
        color: ColorsManager.getPrimaryGreen(context),
      ),
      onTap: () async {
        final s = S.of(context);

        // Show loading
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(color: ColorsManager.primaryGreen),
          ),
        );

        // Get or create conversation
        await context.read<ChatCubit>().getOrCreateConversation(
          otherUserId: trainee.id,
        );

        // Hide loading
        if (context.mounted) Navigator.pop(context);

        final state = context.read<ChatCubit>().state;

        if (state is MessagesLoaded && context.mounted) {
          Navigator.pushNamed(
            context,
            Routes.chat,
            arguments: {
              'conversationId': state.conversation.id,
              'otherUserId': trainee.id,
              'otherUserName':
                  trainee.fullName ??
                  '${trainee.firstName} ${trainee.lastName}',
              'otherUserImage': trainee.image,
            },
          );
        } else if (state is ChatError && context.mounted) {
          // Show error dialog with more details
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: ColorsManager.warning,
                    size: 28.sp,
                  ),
                  SizedBox(width: 12.w),
                  Text(s.cannot_start_chat),
                ],
              ),
              content: Text(state.message),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(s.ok),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
