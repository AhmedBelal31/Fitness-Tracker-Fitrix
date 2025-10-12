import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/params/register_params.dart';
import '../../../data/models/user_model.dart';
import '../../../domain/repositories/auth_repositories/auth_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository _authRepository;

  RegisterCubit(this._authRepository) : super(const RegisterState());

  /// Toggle password visibility
  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  /// Set loading state
  void setLoading(bool isLoading) {
    emit(state.copyWith(isLoading: isLoading));
  }

  /// Register user with all required information
  Future<void> register({
    required String userName,
    required String email,
    required String password,
    required String phoneNumber,
    required int role,
  }) async {
    // Set loading state and clear previous errors
    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: null,
        user: null,
        fieldErrors: null,
      ),
    );

    // Create params object
    final params = RegisterParams(
      userName: userName,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      role: role,
    );

    // Call repository
    final result = await _authRepository.register(params);

    // Handle result
    result.fold(
      (failure) {
        // Handle failure - extract field errors if available
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: failure.errorMessage,
            user: null,
            fieldErrors: _extractFieldErrors(failure.errorMessage),
          ),
        );
      },
      (user) {
        // Handle success
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: null,
            user: user,
            fieldErrors: null,
          ),
        );
      },
    );
  }

  /// Extract field errors from error message if it contains validation errors
  /// This is a helper method to parse error messages that might contain field-specific errors
  Map<String, String>? _extractFieldErrors(String errorMessage) {
    // If the error message contains field-specific information, parse it
    // This is optional and depends on how your backend formats validation errors

    // For now, return null and let the ErrorResponseModel handle it
    // You can enhance this if needed based on your error format
    return null;
  }

  /// Clear all errors
  void clearError() {
    emit(state.copyWith(errorMessage: null, fieldErrors: null));
  }

  /// Clear error for a specific field
  void clearFieldError(String fieldName) {
    if (state.fieldErrors != null) {
      final updatedErrors = Map<String, String>.from(state.fieldErrors!);

      // Remove the error for this field (case-insensitive)
      updatedErrors.removeWhere(
        (key, value) => key.toLowerCase() == fieldName.toLowerCase(),
      );

      emit(
        state.copyWith(
          fieldErrors: updatedErrors.isEmpty ? null : updatedErrors,
        ),
      );
    }
  }

  /// Clear all field errors
  void clearAllFieldErrors() {
    emit(state.copyWith(fieldErrors: null));
  }

  /// Reset the cubit to initial state
  void reset() {
    emit(const RegisterState());
  }

  /// Set field errors manually (useful for testing or custom error handling)
  void setFieldErrors(Map<String, String> errors) {
    emit(state.copyWith(fieldErrors: errors));
  }

  /// Set general error message
  void setError(String errorMessage) {
    emit(state.copyWith(errorMessage: errorMessage, isLoading: false));
  }

  /// Check if a specific field has an error
  bool hasFieldError(String fieldName) {
    return state.getFieldError(fieldName) != null;
  }

  /// Get error message for a specific field
  String? getFieldError(String fieldName) {
    return state.getFieldError(fieldName);
  }
}
