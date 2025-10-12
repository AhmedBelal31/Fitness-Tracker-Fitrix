part of 'auth_check_cubit.dart';

abstract class AuthCheckState extends Equatable {
  const AuthCheckState();

  @override
  List<Object?> get props => [];
}

class AuthCheckInitial extends AuthCheckState {}

class AuthCheckLoading extends AuthCheckState {}

class AuthCheckAuthenticated extends AuthCheckState {
  final LoginProfileModel user;

  const AuthCheckAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthCheckUnauthenticated extends AuthCheckState {}

class AuthCheckNeedsProfileCompletion extends AuthCheckState {}
