import 'package:mboacare/user_model.dart';

class TestData {
  static UserModel getTestUser() {
    return UserModel(
      userID: '1',
      firstName: 'Janet',
      lastName: 'Dolittle',
      profilePicURL: '',
      email: 'janetdolittle@mail.com',
    );
  }
}
