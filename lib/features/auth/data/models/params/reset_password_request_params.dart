// class ResetPasswordRequest {
//   final String email;
//   final String token;
//   final String newPassword;
//   final String confirmPassword;
//
//   ResetPasswordRequest({
//     required this.email,
//     required this.token,
//     required this.newPassword,
//     required this.confirmPassword,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       'email': email,
//       'token': token,
//       'newPassword': newPassword,
//       'confirmPassword': confirmPassword,
//     };
//   }
// }
class ChangePasswordRequest {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  ChangePasswordRequest({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword,
    };
  }
}
