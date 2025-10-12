class ForgotPasswordValidators {
  static String? validateEmail(String? value, dynamic s) {
    if (value == null || value.trim().isEmpty) {
      return s.emailRequired;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return s.enterValidEmail;
    }
    return null;
  }
}
