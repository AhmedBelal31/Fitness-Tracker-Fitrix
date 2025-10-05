part of 'login_cubit.dart';

class LoginState extends Equatable {
  final bool rememberMe;
  final bool isPasswordVisible;
  final bool isLoading;

  const LoginState({
    this.rememberMe = true,
    this.isPasswordVisible = false,
    this.isLoading = false,
  });

  LoginState copyWith({
    bool? rememberMe,
    bool? isPasswordVisible,
    bool? isLoading,
  }) {
    return LoginState(
      rememberMe: rememberMe ?? this.rememberMe,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [rememberMe, isPasswordVisible, isLoading];
}
