import 'package:fitrix/core/common_ui/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/user_dto.dart';
import '../cubits/trainer_requests_cubit.dart';
import 'user_search_card.dart';

class FindClientsTab extends StatefulWidget {
  const FindClientsTab({super.key});

  @override
  State<FindClientsTab> createState() => _FindClientsTabState();
}

class _FindClientsTabState extends State<FindClientsTab> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<UserDto> _allUsers = [];
  List<UserDto> _filteredUsers = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 1;
  String _searchTerm = '';

  @override
  void initState() {
    super.initState();
    _loadUsers();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      if (!_isLoading && _hasMore && _searchTerm.isEmpty) {
        _loadMore();
      }
    }
  }

  Future<void> _loadUsers() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _currentPage = 1;
    });

    context.read<TrainerRequestsCubit>().getAllUsers(
      searchTerm: _searchTerm.isEmpty ? null : _searchTerm,
      pageNumber: _currentPage,
    );
  }

  Future<void> _loadMore() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
      _currentPage++;
    });

    context.read<TrainerRequestsCubit>().getAllUsers(
      searchTerm: _searchTerm.isEmpty ? null : _searchTerm,
      pageNumber: _currentPage,
    );
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchTerm = value;
    });

    // Filter locally first for instant feedback
    if (value.isEmpty) {
      setState(() {
        _filteredUsers = List.from(_allUsers);
      });
      _loadUsers(); // Load all users from server
    } else {
      // Filter locally
      setState(() {
        _filteredUsers = _allUsers.where((user) {
          final fullName = '${user.firstName} ${user.lastName}'.toLowerCase();
          final email = user.email.toLowerCase();
          final searchLower = value.toLowerCase();
          return fullName.contains(searchLower) || email.contains(searchLower);
        }).toList();
      });

      // Also search from server for more results
      _loadUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TrainerRequestsCubit, TrainerRequestsState>(
      listener: (context, state) {
        if (state is AllUsersLoaded) {
          setState(() {
            if (_currentPage == 1) {
              _allUsers = state.users;
              _filteredUsers = state.users;
            } else {
              _allUsers.addAll(state.users);
              _filteredUsers = _searchTerm.isEmpty
                  ? List.from(_allUsers)
                  : _allUsers.where((user) {
                      final fullName = '${user.firstName} ${user.lastName}'
                          .toLowerCase();
                      final email = user.email.toLowerCase();
                      final searchLower = _searchTerm.toLowerCase();
                      return fullName.contains(searchLower) ||
                          email.contains(searchLower);
                    }).toList();
            }
            _hasMore = state.users.length >= 10;
            _isLoading = false;
          });
        } else if (state is TrainerRequestsError) {
          setState(() {
            _isLoading = false;
          });
        }
      },
      child: Column(
        children: [
          // Search Input
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: S.of(context).search_by_name_or_email,
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: ColorsManager.getPrimaryGreen(context),
                ),
                filled: true,
                fillColor: Theme.of(context).cardTheme.color,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                      )
                    : null,
              ),
              onChanged: _onSearchChanged,
            ),
          ),

          // Users List
          Expanded(
            child: _filteredUsers.isEmpty && !_isLoading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _searchTerm.isEmpty ? Icons.search : Icons.search_off,
                          size: 64.sp,
                          color: ColorsManager.getSecondaryText(context),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          _searchTerm.isEmpty
                              ? S.of(context).start_searching_clients
                              : S.of(context).no_users_found,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: ColorsManager.getSecondaryText(context),
                          ),
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: _loadUsers,
                    color: ColorsManager.getPrimaryGreen(context),
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 8.h,
                      ),
                      itemCount: _filteredUsers.length + (_isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == _filteredUsers.length) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.h),
                              child: CircularProgressIndicator(
                                color: ColorsManager.getPrimaryGreen(context),
                              ),
                            ),
                          );
                        }

                        final user = _filteredUsers[index];
                        return UserSearchCard(
                          user: user,
                          onSendRequest: () => _showSendRequestDialog(user),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  void _showSendRequestDialog(UserDto user) {
    final messageController = TextEditingController();
    final s = S.of(context);
    final userName = '${user.firstName} ${user.lastName}'.trim();
    final displayName = userName.isNotEmpty ? userName : user.email;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(s.send_request),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send request to $displayName?',
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: messageController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: s.add_message_optional,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(s.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<TrainerRequestsCubit>().sendRequest(
                userId: user.userId,
                message: messageController.text.trim().isEmpty
                    ? null
                    : messageController.text.trim(),
              );
              Navigator.pop(dialogContext);
              showSuccessSnackBar(context: context, message: s.request_sent);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.getPrimaryGreen(context),
            ),
            child: Text(s.send),
          ),
        ],
      ),
    );
  }
}
