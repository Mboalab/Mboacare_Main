import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboacare/user_password_update.dart';
import 'package:mboacare/user_provider.dart';
import 'package:nock/nock.dart';
import 'package:provider/provider.dart';

void main() {
  setUpAll(nock.init);

  setUp(() {
    nock.cleanAll();
  });

  testWidgets('Should test ChangePasswordScreen widgets',
      (WidgetTester tester) async {
    final userDataProvider = UserDataProvider();

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => userDataProvider,
          child: const ChangePasswordScreen(),
        ),
      ),
    );

    expect(find.text('Change password'), findsOneWidget);
    expect(find.text('Current password *'), findsOneWidget);
    expect(find.text('New password'), findsOneWidget);
    expect(find.text('Confirm new password'), findsOneWidget);
    expect(find.text('Forgot password?'), findsOneWidget);
  });
}
