import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_presentation/authentication/sign_up/sign_up_page.dart';
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_email_view.dart';

void main() {
  group("SignUpPage", () {
    testWidgets("Should render SignUpView", (widgetTester) async {
      await widgetTester.pumpWidget(const MaterialApp(
        home: Scaffold(body: SignUpPage()),
      ));
      expect(find.byType(SignUpEmailView), findsOneWidget);
    });
  });
}
