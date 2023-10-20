import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboacare/user_model.dart';
import 'package:mboacare/user_password_change.dart';
import 'package:mboacare/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('ChangePasswordScreen widgets test', (WidgetTester tester) async {
    final userDataProvider = UserDataProvider(UserModel(
      userID: 'testUserID',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
      profilePicURL: 'profile-pic-url',
    ));

    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<UserDataProvider>.value(
                value: userDataProvider),
          ],
          child: const ChangePasswordScreen(),
        ),
      ),
    );

    expect(find.text("Change password"), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
    final passwordTextFieldFinder = find.byType(PasswordTextField);
    expect(passwordTextFieldFinder, findsNWidgets(3));
    await tester.enterText(
      find.widgetWithText(PasswordTextField, 'Enter your current password'),
      'current_password',
    );
    await tester.enterText(
      find.widgetWithText(PasswordTextField, 'Enter your new password'),
      'new_password',
    );
    await tester.enterText(
      find.widgetWithText(PasswordTextField, 'Enter your new password again'),
      'new_password',
    );
    await tester.tap(find.text('Save'));
    await tester.pump();
  });
}
