import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;
  final String? fcmToken;

  const LoginParams({
    required this.email,
    required this.password,
    this.fcmToken,
  });

  Map<String, dynamic> toJson() {
    final map = {'email': email, 'password': password};
    if (fcmToken != null) {
      map['fcmToken'] = fcmToken!;
    }
    return map;
  }

  @override
  List<Object?> get props => [email, password, fcmToken];
}
