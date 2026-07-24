// lib/features/chat/presentation/screens/chat_screen.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/networking/token_manager.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/chat_message.dart';
import '../cubits/chat_cubit.dart';

import '../../../../core/services/signalr_service.dart';

class ChatScreen extends StatelessWidget {
  final String? conversationId;
  final String otherUserId;
  final String otherUserName;
  final String? otherUserImage;

  const ChatScreen({
    super.key,
    this.conversationId,
    required this.otherUserId,
    required this.otherUserName,
    this.otherUserImage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = di.get<ChatCubit>();

        // Only load messages if conversation exists
        if (conversationId != null && conversationId!.isNotEmpty) {
          log(
            '🔄 Loading messages for conversation: $conversationId',
            name: 'ChatScreen',
          );
          cubit.loadMessages(conversationId: conversationId!);
        } else {
          log('⚠️ No conversation ID, starting fresh chat', name: 'ChatScreen');
        }

        return cubit;
      },
      child: ChatScreenBody(
        conversationId: conversationId,
        otherUserId: otherUserId,
        otherUserName: otherUserName,
        otherUserImage: otherUserImage,
      ),
    );
  }
}

class ChatScreenBody extends StatefulWidget {
  final String? conversationId;
  final String otherUserId;
  final String otherUserName;
  final String? otherUserImage;

  const ChatScreenBody({
    super.key,
    this.conversationId,
    required this.otherUserId,
    required this.otherUserName,
    this.otherUserImage,
  });

  @override
  State<ChatScreenBody> createState() => _ChatScreenBodyState();
}

class _ChatScreenBodyState extends State<ChatScreenBody> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? _currentUserId;
  String? _activeConversationId;
  final List<ChatMessage> _localMessages = [];
  bool _isUserIdLoaded = false;

  @override
  void initState() {
    super.initState();
    _activeConversationId = widget.conversationId;
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    await _loadCurrentUserId();
    await _setupSignalR();
  }

  Future<void> _loadCurrentUserId() async {
    // ALWAYS use the token's user ID - this is the source of truth
    _currentUserId = await TokenManager.instance.getUserId();
    log('👤 Current user ID from JWT: $_currentUserId', name: 'ChatScreen');

    if (mounted) {
      setState(() {
        _isUserIdLoaded = true;
      });
    }
  }

  bool _isMyMessage(String senderId) {
    if (_currentUserId == null) return false;

    final normalizedCurrent = _currentUserId!.toLowerCase().trim();
    final normalizedSender = senderId.toLowerCase().trim();

    return normalizedCurrent == normalizedSender;
  }

  Future<void> _setupSignalR() async {
    try {
      await SignalRService.instance.connect();

      if (SignalRService.instance.isConnected) {
        // CRITICAL: Set up the listener BEFORE joining
        SignalRService.instance.onReceiveMessage((messageData) {
          final message = ChatMessage.fromJson(messageData);

          log('📨 SignalR message received:', name: 'ChatScreen');
          log('   Message ID: ${message.id}', name: 'ChatScreen');
          log('   From: ${message.senderId}', name: 'ChatScreen');
          log('   Conversation: ${message.conversationId}', name: 'ChatScreen');
          log(
            '   Active conversation: $_activeConversationId',
            name: 'ChatScreen',
          );

          // Add to local messages if it's for this conversation
          if (message.conversationId == _activeConversationId) {
            setState(() {
              if (!_localMessages.any((m) => m.id == message.id)) {
                _localMessages.insert(0, message);
                log('✅ Added message to local list', name: 'ChatScreen');
              }
            });
            _scrollToBottom();
          }
        });

        // Try to join the conversation
        if (_activeConversationId != null &&
            _activeConversationId!.isNotEmpty) {
          await SignalRService.instance.joinConversation(
            _activeConversationId!,
          );
        }

        log('✅ SignalR listeners set up', name: 'ChatScreen');
      } else {
        log('⚠️ SignalR not available', name: 'ChatScreen');
      }
    } catch (e) {
      log('❌ SignalR setup failed: $e', name: 'ChatScreen');
    }
  }

  @override
  void dispose() {
    if (_activeConversationId != null && _activeConversationId!.isNotEmpty) {
      SignalRService.instance.leaveConversation(_activeConversationId!);
    }
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final content = _messageController.text.trim();
    _messageController.clear();

    final targetId = _activeConversationId ?? widget.otherUserId;

    log('📤 Sending message', name: 'ChatScreen');
    log('   From: $_currentUserId', name: 'ChatScreen');
    log('   To conversation: $targetId', name: 'ChatScreen');

    try {
      await context.read<ChatCubit>().sendMessage(
        conversationId: targetId,
        content: content,
      );

      final state = context.read<ChatCubit>().state;

      if (state is MessageSent) {
        log('✅ Message sent!', name: 'ChatScreen');
        log(
          '   Returned sender ID: ${state.message.senderId}',
          name: 'ChatScreen',
        );
        log('   Expected sender ID: $_currentUserId', name: 'ChatScreen');

        // Check if backend returned different user ID
        if (state.message.senderId != _currentUserId) {
          log(
            '⚠️ WARNING: Backend returned different sender ID!',
            name: 'ChatScreen',
          );
          log('   JWT has: $_currentUserId', name: 'ChatScreen');
          log(
            '   Backend returned: ${state.message.senderId}',
            name: 'ChatScreen',
          );
        }

        if (_activeConversationId == null) {
          setState(() {
            _activeConversationId = state.message.conversationId;
          });

          if (_activeConversationId != null &&
              _activeConversationId!.isNotEmpty) {
            await SignalRService.instance.joinConversation(
              _activeConversationId!,
            );
          }
        }
      }
    } catch (e) {
      log('❌ Failed to send message: $e', name: 'ChatScreen');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send message'),
            backgroundColor: ColorsManager.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (!_isUserIdLoaded) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: ColorsManager.getSecondaryGreen(
            context,
          ).withValues(alpha: 0.65),
          title: Text(widget.otherUserName),
        ),
        body: const Center(
          child: CircularProgressIndicator(color: ColorsManager.primaryGreen),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorsManager.getSecondaryGreen(
          context,
        ).withValues(alpha: 0.65),
        title: Row(
          children: [
            if (widget.otherUserImage != null &&
                widget.otherUserImage!.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: CircleAvatar(
                  radius: 16.r,
                  backgroundImage: NetworkImage(widget.otherUserImage!),
                ),
              )
            else
              Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: CircleAvatar(
                  radius: 16.r,
                  backgroundColor: Colors.white.withValues(alpha: 0.3),
                  child: Text(
                    widget.otherUserName[0].toUpperCase(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            Expanded(
              child: Text(
                widget.otherUserName,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is MessageSent) {
                  setState(() {
                    if (!_localMessages.any((m) => m.id == state.message.id)) {
                      _localMessages.insert(0, state.message);
                    }
                  });
                  _scrollToBottom();
                }
                if (state is MessagesLoaded && _activeConversationId == null) {
                  setState(() {
                    _activeConversationId = state.conversation.id;
                  });
                }
                if (state is ChatError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: ColorsManager.error,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is ChatLoading && _localMessages.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: ColorsManager.primaryGreen,
                    ),
                  );
                }

                List<ChatMessage> allMessages = [];
                if (state is MessagesLoaded) {
                  allMessages = [...state.messages];
                }

                // Add local messages that aren't in API response
                for (final localMsg in _localMessages) {
                  if (!allMessages.any(
                    (m) => m.id.toString() == localMsg.id.toString(),
                  )) {
                    allMessages.insert(0, localMsg);
                  }
                }

                // Sort by date (newest first)
                allMessages.sort((a, b) => b.sentAt.compareTo(a.sentAt));

                if (allMessages.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 64.sp,
                          color: ColorsManager.getSecondaryText(context),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          s.no_messages_yet,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.getPrimaryText(context),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          s.start_conversation,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: ColorsManager.getSecondaryText(context),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  padding: EdgeInsets.all(16.w),
                  itemCount: allMessages.length,
                  itemBuilder: (context, index) {
                    final message = allMessages[index];
                    final isMine = _isMyMessage(message.senderId);

                    final showDate =
                        index == allMessages.length - 1 ||
                        !_isSameDay(
                          message.sentAt,
                          allMessages[index + 1].sentAt,
                        );

                    return Column(
                      children: [
                        if (showDate) _buildDateDivider(message.sentAt),
                        _MessageBubble(message: message, isMine: isMine),
                      ],
                    );
                  },
                );
              },
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              border: Border(
                top: BorderSide(
                  color: isDark
                      ? ColorsManager.darkBorder
                      : ColorsManager.lightBorder,
                ),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: ColorsManager.getPrimaryText(context),
                      ),
                      decoration: InputDecoration(
                        hintText: s.type_message,
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: ColorsManager.getSecondaryText(context),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  CircleAvatar(
                    backgroundColor: ColorsManager.getPrimaryGreen(context),
                    radius: 24.r,
                    child: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: isDark
                            ? ColorsManager.darkScaffold
                            : Colors.white,
                        size: 20.sp,
                      ),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateDivider(DateTime date) {
    final now = DateTime.now();
    final isToday = _isSameDay(date, now);
    final isYesterday = _isSameDay(date, now.subtract(const Duration(days: 1)));

    String label;
    if (isToday) {
      label = S.of(context).today;
    } else if (isYesterday) {
      label = S.of(context).yesterday;
    } else {
      label = DateFormat('MMM d, yyyy').format(date);
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: ColorsManager.getSecondaryText(
                context,
              ).withValues(alpha: 0.3),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: ColorsManager.getSecondaryText(context),
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: ColorsManager.getSecondaryText(
                context,
              ).withValues(alpha: 0.3),
            ),
          ),
        ],
      ),
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isMine;

  const _MessageBubble({required this.message, required this.isMine});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        constraints: BoxConstraints(maxWidth: 280.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isMine
              ? ColorsManager.getPrimaryGreen(context)
              : (isDark
                    ? ColorsManager.darkCardBackground
                    : Colors.grey.shade200),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: isMine ? Radius.circular(16.r) : Radius.zero,
            bottomRight: isMine ? Radius.zero : Radius.circular(16.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              style: TextStyle(
                fontSize: 14.sp,
                color: isMine
                    ? (isDark ? ColorsManager.darkScaffold : Colors.white)
                    : ColorsManager.getPrimaryText(context),
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat('HH:mm').format(message.sentAt),
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: isMine
                        ? (isDark
                              ? ColorsManager.darkScaffold.withValues(
                                  alpha: 0.7,
                                )
                              : Colors.white.withValues(alpha: 0.7))
                        : ColorsManager.getSecondaryText(context),
                  ),
                ),
                if (isMine) ...[
                  SizedBox(width: 4.w),
                  Icon(
                    message.isRead ? Icons.done_all : Icons.done,
                    size: 14.sp,
                    color: message.isRead
                        ? ColorsManager.info
                        : (isDark
                              ? ColorsManager.darkScaffold.withValues(
                                  alpha: 0.7,
                                )
                              : Colors.white.withValues(alpha: 0.7)),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
