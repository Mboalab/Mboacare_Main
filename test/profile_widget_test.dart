import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboacare/user_model.dart';
import 'package:mboacare/user_profile_page.dart';
import 'package:mboacare/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('ProfilePage Widget Test', (WidgetTester tester) async {
    // Create a UserModel instance for testing
    final testUser = UserModel(
      userID: '1',
      firstName: 'John',
      lastName: 'Doe',
      email: 'johndoe@example.com',
      profilePicURL: '',
    );
    final userDataProvider = UserDataProvider(testUser);

    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => userDataProvider),
          ],
          child: const ProfilePage(),
        ),
      ),
    );

    // Verify the widgets on the ProfilePage
    expect(find.text('Personal info'), findsOneWidget);
    expect(find.text('Update your photo and personal details'), findsOneWidget);
    expect(find.text('Change Photo'), findsOneWidget);
    expect(find.text('First Name'), findsOneWidget);
    expect(find.text('Last Name'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    await tester.tap(find.text('Change Photo'));
    await tester.pump();
  });
}
