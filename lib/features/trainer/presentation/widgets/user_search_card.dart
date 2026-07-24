import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/user_dto.dart';

class UserSearchCard extends StatelessWidget {
  final UserDto user;
  final VoidCallback onSendRequest;

  const UserSearchCard({
    super.key,
    required this.user,
    required this.onSendRequest,
  });

  String _getInitials() {
    final firstName = user.firstName.trim();
    final lastName = user.lastName.trim();

    if (firstName.isEmpty && lastName.isEmpty) {
      return user.email.isNotEmpty ? user.email[0].toUpperCase() : '?';
    }

    String initials = '';
    if (firstName.isNotEmpty) initials += firstName[0];
    if (lastName.isNotEmpty) initials += lastName[0];

    return initials.toUpperCase();
  }

  String _getFullName() {
    final fullName = '${user.firstName} ${user.lastName}'.trim();
    return fullName.isNotEmpty ? fullName : user.email;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 28.r,
              backgroundColor: ColorsManager.getPrimaryGreen(
                context,
              ).withValues(alpha: 0.2),
              backgroundImage: user.image != null && user.image!.isNotEmpty
                  ? NetworkImage(user.image!)
                  : null,
              child: user.image == null || user.image!.isEmpty
                  ? Text(
                      _getInitials(),
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.getPrimaryGreen(context),
                      ),
                    )
                  : null,
            ),

            SizedBox(width: 16.w),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getFullName(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.getPrimaryText(context),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    user.email,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: ColorsManager.getSecondaryText(context),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (user.phoneNumber != null &&
                      user.phoneNumber!.isNotEmpty) ...[
                    SizedBox(height: 2.h),
                    Text(
                      user.phoneNumber!,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: ColorsManager.getSecondaryText(context),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Action Button
            if (user.isInRelation)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: ColorsManager.success.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 16.sp,
                      color: ColorsManager.success,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      S.of(context).client,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.success,
                      ),
                    ),
                  ],
                ),
              )
            else
              ElevatedButton.icon(
                onPressed: onSendRequest,
                icon: Icon(Icons.person_add, size: 18.sp),
                label: Text(S.of(context).add),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.getPrimaryGreen(context),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
