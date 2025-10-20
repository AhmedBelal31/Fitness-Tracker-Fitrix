import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/di/get_it.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../cubits/notifications_cubit/notifications_cubit.dart';
import '../../cubits/notifications_cubit/notifications_state.dart';
import 'animated_notification_switch.dart';
import 'profile_settings_tile.dart';

class NotificationSwitchBlocprovider extends StatelessWidget {
  const NotificationSwitchBlocprovider({super.key});

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return BlocProvider(
      create: (context) => di<NotificationsCubit>(),
      child: BlocConsumer<NotificationsCubit, NotificationsState>(
        listener: (context, state) {
          if (state is NotificationsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: ColorsManager.error,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          final isEnabled = state is NotificationsLoaded
              ? state.isEnabled
              : true;

          return ProfileSettingsTile(
            icon: Icons.notifications,
            title: s.notifications,
            trailing: NotificationLoadSwitch(
              value: isEnabled,
              future: () => context
                  .read<NotificationsCubit>()
                  .toggleNotifications(isEnabled),
              onChange: (newValue) {
                log('Notification setting changed to: $newValue');
              },
            ),
          );
        },
      ),
    );
  }
}
