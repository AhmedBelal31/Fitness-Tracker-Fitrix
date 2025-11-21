class UserDto {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String? phoneNumber;
  final String? image;
  final bool isInRelation;

  UserDto({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber,
    this.image,
    this.isInRelation = false,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    // Split userName into firstName and lastName
    String firstName = '';
    String lastName = '';

    final userName = json['userName'] as String? ?? '';
    if (userName.isNotEmpty) {
      final names = userName.split(' ');
      if (names.isNotEmpty) {
        firstName = names.first;
        if (names.length > 1) {
          lastName = names.sublist(1).join(' ');
        }
      }
    }

    return UserDto(
      userId: json['userId'] ?? json['id'] ?? '',
      firstName: firstName,
      lastName: lastName,
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'],
      image: json['image'],
      isInRelation: json['isInRelation'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'phoneNumber': phoneNumber,
    'image': image,
    'isInRelation': isInRelation,
  };

  // Helper getter for full name
  String get fullName => '$firstName $lastName'.trim();
}
