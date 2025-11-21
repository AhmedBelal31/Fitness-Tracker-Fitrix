part of 'login_cubit.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final bool isPasswordVisible;
  final bool rememberMe;
  final String? savedEmail;
  final String? errorMessage;
  final LoginResponseModel? loginResponse;
  final LoginProfileModel? userProfile;
  final bool needsProfileCompletion;

  const LoginState({
    this.isLoading = false,
    this.isPasswordVisible = false,
    this.rememberMe = true,
    this.savedEmail,
    this.errorMessage,
    this.loginResponse,
    this.userProfile,
    this.needsProfileCompletion = false,
  });

  // Helper getters
  bool get hasError => errorMessage != null;
  bool get isLoginSuccessful => loginResponse != null && !isLoading;
  bool get hasProfile => userProfile != null;

  // Navigate to home only if profile exists AND is complete
  bool get shouldNavigateToHome =>
      hasProfile && !needsProfileCompletion && isLoginSuccessful;

  // 👇 Navigate to complete profile if needed
  bool get shouldNavigateToCompleteProfile =>
      needsProfileCompletion && isLoginSuccessful;

  bool get hasSavedEmail => savedEmail != null && savedEmail!.isNotEmpty;

  LoginState copyWith({
    bool? isLoading,
    bool? isPasswordVisible,
    bool? rememberMe,
    String? savedEmail,
    String? errorMessage,
    LoginResponseModel? loginResponse,
    LoginProfileModel? userProfile,
    bool? needsProfileCompletion,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      rememberMe: rememberMe ?? this.rememberMe,
      savedEmail: savedEmail ?? this.savedEmail,
      errorMessage: errorMessage,
      loginResponse: loginResponse ?? this.loginResponse,
      userProfile: userProfile ?? this.userProfile,
      needsProfileCompletion:
          needsProfileCompletion ?? this.needsProfileCompletion,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isPasswordVisible,
    rememberMe,
    savedEmail,
    errorMessage,
    loginResponse,
    userProfile,
    needsProfileCompletion,
  ];

  @override
  String toString() {
    return 'LoginState(isLoading: $isLoading, rememberMe: $rememberMe, hasProfile: $hasProfile, needsProfileCompletion: $needsProfileCompletion)';
  }
}
