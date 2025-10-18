import 'package:fitrix/features/profile/presentation/widgets/update_profile_widgets/update_profile_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../generated/l10n.dart';
import '../../../../auth/presentation/widgets/login_widgets/animated_fitness_icon.dart';
import '../../cubits/update_profile_cubit/update_profile_cubit.dart';
import '../../cubits/update_profile_cubit/update_profile_state.dart';
import 'update_profile_form.dart';

class UpdateProfileScreenBody extends StatefulWidget {
  const UpdateProfileScreenBody({super.key});

  @override
  State<UpdateProfileScreenBody> createState() =>
      _UpdateProfileScreenBodyState();
}

class _UpdateProfileScreenBodyState extends State<UpdateProfileScreenBody> {
  final _formKey = GlobalKey<FormState>();
  late UpdateProfileFormController _controller;

  @override
  void initState() {
    super.initState();
    _controller = UpdateProfileFormController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackground,
      appBar: AppBar(
        title: Text(s.updateProfile, style: TextStyles.headline3),
        backgroundColor: ColorsManager.scaffoldBackground,
        elevation: 0,
      ),
      body: BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
        builder: (context, state) {
          if (state.isLoading && state.currentProfile == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorsManager.primaryGreen,
              ),
            );
          }

          // Initialize form with current profile data
          if (state.currentProfile != null && !_controller.isInitialized) {
            _controller.initializeWithProfile(state.currentProfile!);
          }

          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  const PulsingFitnessIcon(),
                  SizedBox(height: 24.h),
                  // Text(s.updateProfile, style: TextStyles.headline2),
                  // SizedBox(height: 8.h),
                  Text(
                    s.updateYourProfileInformation,
                    style: TextStyles.subtitle2,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),
                  UpdateProfileForm(formKey: _formKey, controller: _controller),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
