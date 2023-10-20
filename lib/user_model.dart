class UserModel {
  final String userID;
  final String email;
  final String firstName;
  final String lastName;
  String? profilePicURL;

  UserModel({
    required this.userID,
    required this.firstName,
    required this.lastName,
    this.profilePicURL,
    required this.email,
  });

  UserModel copyWith({
    required String userID,
    required String email,
    String? profilePicURL,
    required String firstName,
    required String lastName,
  }) {
    return UserModel(
        userID: userID,
        email: email,
        profilePicURL: profilePicURL ?? this.profilePicURL,
        firstName: firstName,
        lastName: lastName);
  }
}
