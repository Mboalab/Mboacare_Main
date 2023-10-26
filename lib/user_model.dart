class UserModel {
  final String uid;
  final String email;
  final bool emailVerified;
  String? phoneNumber;
  final String displayName;
  final String? photoURL;

  UserModel({
    required this.uid,
    required this.email,
    required this.emailVerified,
    this.phoneNumber,
    required this.displayName,
    this.photoURL,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    bool? emailVerified,
    String? phoneNumber,
    String? displayName,
    String? password,
    String? photoURL,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
    );
  }
}
