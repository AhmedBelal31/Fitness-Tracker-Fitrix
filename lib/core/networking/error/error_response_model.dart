class ErrorResponseModel {
  final String? type;
  final String title;
  final int? status;
  final Map<String, List<String>>? errors;
  final String? traceId;
  final String? detail;

  ErrorResponseModel({
    this.type,
    required this.title,
    this.status,
    this.errors,
    this.traceId,
    this.detail,
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    return ErrorResponseModel(
      type: json['type'] as String?,
      title:
          json['title'] as String? ??
          json['message'] as String? ??
          json['error'] as String? ??
          'An error occurred',
      status: json['status'] as int? ?? json['statusCode'] as int?,
      errors: _parseErrors(json['errors']),
      traceId: json['traceId'] as String?,
      detail: json['detail'] as String? ?? json['details'] as String?,
    );
  }

  // Parse errors field which can be Map<String, dynamic> or Map<String, List<String>>
  static Map<String, List<String>>? _parseErrors(dynamic errorsData) {
    if (errorsData == null) return null;

    if (errorsData is Map<String, dynamic>) {
      final Map<String, List<String>> parsedErrors = {};

      errorsData.forEach((key, value) {
        if (value is List) {
          // Convert list items to strings
          parsedErrors[key] = value.map((e) => e.toString()).toList();
        } else if (value is String) {
          // Single error message
          parsedErrors[key] = [value];
        } else {
          // Unknown format, convert to string
          parsedErrors[key] = [value.toString()];
        }
      });

      return parsedErrors;
    }

    return null;
  }

  // Get the first error message from all validation errors
  String get message {
    if (errors != null && errors!.isNotEmpty) {
      final firstError = errors!.values.first;
      if (firstError.isNotEmpty) {
        return firstError.first;
      }
    }
    return detail ?? title;
  }

  // Get all error messages as a single string
  String get details {
    if (errors != null && errors!.isNotEmpty) {
      final List<String> allErrors = [];
      errors!.forEach((field, messages) {
        allErrors.addAll(messages);
      });
      return allErrors.join(', ');
    }
    return detail ?? title;
  }

  // Get error message for a specific field
  String? getFieldError(String fieldName) {
    if (errors == null) return null;

    // Try exact match first
    if (errors!.containsKey(fieldName)) {
      final fieldErrors = errors![fieldName];
      return fieldErrors != null && fieldErrors.isNotEmpty
          ? fieldErrors.first
          : null;
    }

    // Try case-insensitive match
    final key = errors!.keys.firstWhere(
      (key) => key.toLowerCase() == fieldName.toLowerCase(),
      orElse: () => '',
    );

    if (key.isNotEmpty) {
      final fieldErrors = errors![key];
      return fieldErrors != null && fieldErrors.isNotEmpty
          ? fieldErrors.first
          : null;
    }

    return null;
  }

  // Get all errors for a specific field
  List<String>? getFieldErrors(String fieldName) {
    if (errors == null) return null;

    // Try exact match first
    if (errors!.containsKey(fieldName)) {
      return errors![fieldName];
    }

    // Try case-insensitive match
    final key = errors!.keys.firstWhere(
      (key) => key.toLowerCase() == fieldName.toLowerCase(),
      orElse: () => '',
    );

    if (key.isNotEmpty) {
      return errors![key];
    }

    return null;
  }

  // Check if there are validation errors
  bool get hasValidationErrors => errors != null && errors!.isNotEmpty;

  // Get formatted error message for display
  String get formattedMessage {
    if (hasValidationErrors) {
      final List<String> formattedErrors = [];
      errors!.forEach((field, messages) {
        for (var message in messages) {
          formattedErrors.add('• $message');
        }
      });
      return formattedErrors.join('\n');
    }
    return detail ?? title;
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'status': status,
      'errors': errors,
      'traceId': traceId,
      'detail': detail,
    };
  }

  @override
  String toString() {
    return 'ErrorResponseModel(type: $type, title: $title, status: $status, errors: $errors, traceId: $traceId, detail: $detail)';
  }
}
