// lib/features/profile/presentation/cubit/complete_profile_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/complete_profile_params.dart';
import '../../../domain/profile_repository.dart';
import 'complete_profile_state.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  final ProfileRepository _repository;

  CompleteProfileCubit(this._repository) : super(const CompleteProfileState());

  Future<void> submitProfile(CompleteProfileParams params) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));
    final result = await _repository.completeProfile(params);
    result.fold(
      (failure) => emit(
        state.copyWith(isLoading: false, errorMessage: failure.errorMessage),
      ),
      (_) => emit(
        state.copyWith(isLoading: false, errorMessage: null, isSuccess: true),
      ),
    );
  }

  void clearError() => emit(state.copyWith(errorMessage: null));
  void reset() => emit(const CompleteProfileState());
}
