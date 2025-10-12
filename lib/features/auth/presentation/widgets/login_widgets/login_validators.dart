import '../../../../../generated/l10n.dart';

class LoginValidators {
  static String? validateEmail(String? value, S l10n) {
    if (value == null || value.isEmpty) {
      return l10n.emailRequired;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return l10n.invalidEmail;
    }
    return null;
  }

  static String? validatePassword(String? value, S l10n) {
    if (value == null || value.isEmpty) {
      return l10n.passwordRequired;
    }
    if (value.length < 6) {
      return l10n.passwordMinLength;
    }
    return null;
  }
}
