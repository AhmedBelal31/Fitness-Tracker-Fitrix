part of 'register_cubit.dart';

class RegisterState extends Equatable {
  final bool isLoading;
  final bool isPasswordVisible;
  final String? errorMessage;
  final UserModel? user;
  final Map<String, String>? fieldErrors;

  const RegisterState({
    this.isLoading = false,
    this.isPasswordVisible = false,
    this.errorMessage,
    this.user,
    this.fieldErrors,
  });

  /// Helper getters
  bool get hasError => errorMessage != null;
  bool get hasFieldErrors => fieldErrors != null && fieldErrors!.isNotEmpty;
  bool get isSuccess => user != null && !isLoading;

  /// Get error for a specific field (case-insensitive)
  String? getFieldError(String fieldName) {
    if (fieldErrors == null || fieldErrors!.isEmpty) return null;

    // Try exact match first
    if (fieldErrors!.containsKey(fieldName)) {
      return fieldErrors![fieldName];
    }

    // Try case-insensitive match
    final key = fieldErrors!.keys.firstWhere(
      (key) => key.toLowerCase() == fieldName.toLowerCase(),
      orElse: () => '',
    );

    return key.isNotEmpty ? fieldErrors![key] : null;
  }

  /// Check if a specific field has an error
  bool hasErrorForField(String fieldName) {
    return getFieldError(fieldName) != null;
  }

  /// Get all field names that have errors
  List<String> get errorFields {
    return fieldErrors?.keys.toList() ?? [];
  }

  /// Get count of field errors
  int get fieldErrorCount {
    return fieldErrors?.length ?? 0;
  }

  /// Create a copy of the state with updated values
  RegisterState copyWith({
    bool? isLoading,
    bool? isPasswordVisible,
    String? errorMessage,
    UserModel? user,
    Map<String, String>? fieldErrors,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      errorMessage: errorMessage,
      user: user,
      fieldErrors: fieldErrors,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isPasswordVisible,
    errorMessage,
    user,
    fieldErrors,
  ];

  @override
  String toString() {
    return 'RegisterState(isLoading: $isLoading, isPasswordVisible: $isPasswordVisible, hasError: $hasError, hasFieldErrors: $hasFieldErrors, isSuccess: $isSuccess)';
  }
}
