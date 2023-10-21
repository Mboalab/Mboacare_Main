import 'package:flutter_test/flutter_test.dart';
import 'package:mboacare/user_model.dart';
import 'package:mboacare/user_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Test updateUserProfile', () {
    final userDataProvider = UserDataProvider(UserModel(
      userID: '1',
      firstName: 'John',
      lastName: 'Doe',
      email: 'johndoe@example.com',
      profilePicURL: '',
    ));

    final updatedUser = UserModel(
      userID: '1',
      firstName: 'Alice',
      lastName: 'Johnson',
      email: 'alice@example.com',
      profilePicURL: '',
    );

    userDataProvider.updateUserProfile(updatedUser);

    expect(userDataProvider.currentUser, updatedUser);
  });

  test('Test updateUsername', () {
    final userDataProvider = UserDataProvider(UserModel(
      userID: '1',
      firstName: 'John',
      lastName: 'Doe',
      email: 'johndoe@example.com',
      profilePicURL: '',
    ));

    const newFirstName = 'Alice';
    userDataProvider.updateUsername(newFirstName);

    expect(userDataProvider.currentUser.firstName, newFirstName);
  });
}
