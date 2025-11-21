import 'dart:developer' as dev;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitrix/core/services/hive_service.dart';
import 'package:fitrix/features/auth/data/models/login_profile_model.dart';
import '../../../../auth/data/models/params/update_profile_params.dart';
import '../../../../auth/domain/repositories/profile_repository/profile_repository.dart';
import 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final ProfileRepository _profileRepository;
  final HiveService _hiveService = HiveService();

  UpdateProfileCubit(this._profileRepository)
    : super(const UpdateProfileState()) {
    loadCurrentProfile();
  }

  Future<void> loadCurrentProfile() async {
    emit(state.copyWith(isLoading: true));

    final result = await _profileRepository.getProfile();

    result.fold(
      (failure) {
        dev.log(
          '❌ Failed to load profile: ${failure.errorMessage}',
          name: 'UpdateProfileCubit',
        );
        emit(
          state.copyWith(isLoading: false, errorMessage: failure.errorMessage),
        );
      },
      (profile) {
        dev.log('✅ Profile loaded successfully', name: 'UpdateProfileCubit');
        emit(state.copyWith(isLoading: false, currentProfile: profile));
      },
    );
  }

  Future<void> updateProfile(UpdateProfileParams params) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _profileRepository.updateProfile(params);

    result.fold(
      (failure) {
        dev.log(
          '❌ Profile update failed: ${failure.errorMessage}',
          name: 'UpdateProfileCubit',
        );
        emit(
          state.copyWith(isLoading: false, errorMessage: failure.errorMessage),
        );
      },
      (updatedProfile) async {
        dev.log('✅ Profile updated successfully', name: 'UpdateProfileCubit');

        // Save updated profile to Hive
        await _hiveService.saveProfile(updatedProfile);

        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            currentProfile: updatedProfile,
          ),
        );
      },
    );
  }

  void clearError() => emit(state.copyWith(errorMessage: null));
  void clearSuccess() => emit(state.copyWith(isSuccess: false));
}
