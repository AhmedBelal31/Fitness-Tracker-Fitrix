import 'package:equatable/equatable.dart';

class CompleteProfileState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const CompleteProfileState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  CompleteProfileState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return CompleteProfileState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage];
}
