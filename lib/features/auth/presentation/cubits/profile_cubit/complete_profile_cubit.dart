import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/networking/token_manager.dart';
import '../../../data/models/params/complete_profile_params.dart';
import '../../../domain/repositories/profile_repository/profile_repository.dart';
import 'complete_profile_state.dart';
import 'dart:developer' as dev;
import 'package:fitrix/core/services/hive_service.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  final ProfileRepository _repository;
  final HiveService _hiveService = HiveService();
  final TokenManager _tokenManager = TokenManager.instance;

  CompleteProfileCubit(this._repository) : super(const CompleteProfileState());

  Future<void> submitProfile(CompleteProfileParams params) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));

    final result = await _repository.completeProfile(params);

    result.fold(
      (failure) {
        dev.log(
          '❌ Profile completion failed: ${failure.errorMessage}',
          name: 'CompleteProfileCubit',
        );
        emit(
          state.copyWith(isLoading: false, errorMessage: failure.errorMessage),
        );
      },
      (profileModel) async {
        dev.log(
          '✅ Profile completed successfully',
          name: 'CompleteProfileCubit',
        );

        // 👇 Save updated profile to Hive
        await _hiveService.saveProfile(profileModel);

        // 👇 Cache user role
        if (profileModel.role != null) {
          await _tokenManager.saveUserRole(profileModel.role!);
          dev.log(
            '💾 User role cached: ${profileModel.role}',
            name: 'CompleteProfileCubit',
          );
        }

        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: null,
            isSuccess: true,
            userProfile: profileModel,
          ),
        );
      },
    );
  }

  void clearError() => emit(state.copyWith(errorMessage: null));
  void reset() => emit(const CompleteProfileState());
}
