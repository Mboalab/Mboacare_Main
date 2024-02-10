class UserModel {
  String? uid;
  String? email;
  bool? emailVerified;
  String? displayName;
  String? photoURL;
  String? phoneNumber;

  UserModel({
    this.uid,
    this.email,
    this.emailVerified,
    this.displayName,
    this.photoURL,
    this.phoneNumber,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    emailVerified = json['emailVerified'];
    displayName = json['displayName'];
    photoURL = json['photoURL'];
    phoneNumber = json['phoneNumber'];
  }
}
