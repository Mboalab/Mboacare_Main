import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboacare/user_model.dart';
import 'package:mboacare/user_profile_page.dart';
import 'package:mboacare/user_provider.dart';
import 'package:nock/nock.dart';
import 'package:provider/provider.dart';

void main() {
  setUpAll(nock.init);

  setUp(() {
    nock.cleanAll();
  });

  testWidgets('Should test ProfilePage with mock HTTP data',
      (WidgetTester tester) async {
    // Define a mock user for testing
    final user = UserModel(
      uid: 'testUid',
      displayName: 'John Doe',
      email: 'johndoe@example.com',
      phoneNumber: '1234567890',
      photoURL: 'https://example.com/avatar.jpg',
      emailVerified: false,
    );

    // Create a mock UserDataProvider
    final userDataProvider = UserDataProvider();
    userDataProvider.currentUser = user;

    // Mock the HTTP response
    nock('https://us-central1-mboacare-api-v1.cloudfunctions.net/api/auth')
        .get('/sign-in')
        .reply(
            200,
            json.encode({
              'uid': 'testUid',
              'displayName': 'John Doe',
              'email': 'johndoe@example.com',
              'phoneNumber': '1234567890',
              'photoURL': 'https://example.com/avatar.jpg',
            }));

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<UserDataProvider>(
          create: (context) => userDataProvider,
          child: const ProfilePage(),
        ),
      ),
    );
    await tester.pump();

    // Verify widgets
    expect(find.text('Personal info'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Phone number'), findsOneWidget);
    expect(find.text('1234567890'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('johndoe@example.com'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Change password'), findsOneWidget);
  });
}
