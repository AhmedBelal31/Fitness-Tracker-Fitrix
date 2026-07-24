import 'package:equatable/equatable.dart';
import 'package:fitrix/features/auth/data/models/login_profile_model.dart';

class UpdateProfileState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final LoginProfileModel? currentProfile;

  const UpdateProfileState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.currentProfile,
  });

  UpdateProfileState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    LoginProfileModel? currentProfile,
  }) {
    return UpdateProfileState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
      currentProfile: currentProfile ?? this.currentProfile,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSuccess,
    errorMessage,
    currentProfile,
  ];
}
