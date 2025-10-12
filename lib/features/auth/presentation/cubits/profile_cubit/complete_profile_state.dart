import 'package:equatable/equatable.dart';
import 'package:fitrix/features/auth/data/models/login_profile_model.dart';

class CompleteProfileState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final LoginProfileModel? userProfile;

  const CompleteProfileState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.userProfile,
  });

  CompleteProfileState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    LoginProfileModel? userProfile,
  }) {
    return CompleteProfileState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
      userProfile: userProfile ?? this.userProfile,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage, userProfile];
}
