import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/di/get_it.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../cubits/sound_cubit/sound_cubit.dart';
import '../../cubits/sound_cubit/sound_state.dart';
import 'animated_notification_switch.dart';
import 'profile_settings_tile.dart';

class SoundSwitchBlocProvider extends StatelessWidget {
  const SoundSwitchBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);

    return BlocProvider(
      create: (context) => di<SoundCubit>(),
      child: BlocConsumer<SoundCubit, SoundState>(
        listener: (context, state) {
          if (state is SoundError) {
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
          final isEnabled = state is SoundLoaded ? state.isEnabled : true;
          final isLoading = state is SoundLoading;

          return ProfileSettingsTile(
            icon: Icons.volume_up,
            title: s.sound_effects,
            trailing: AnimatedLoadSwitch(
              value: isEnabled,
              future: () => context.read<SoundCubit>().toggleSound(isEnabled),
              onChange: (newValue) {
                log('Sound setting changed to: $newValue');
              },
            ),
          );
        },
      ),
    );
  }
}
