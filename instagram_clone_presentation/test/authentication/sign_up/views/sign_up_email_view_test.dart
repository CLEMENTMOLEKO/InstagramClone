import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_email_verification_view.dart';
import 'package:instagram_clone_presentation/common/navigation/route_names.dart';
import 'package:instagram_clone_presentation/common/route_generator.dart';

void main() {
  Future<void> renderSignUpEmailView(WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      initialRoute: RouteNames.signUp,
      onGenerateRoute: RouteGenerator.generateRoute,
    ));
  }

  group("SignUpEmailView", () {
    testWidgets("Should render title label", (WidgetTester tester) async {
      await renderSignUpEmailView(tester);
      expect(find.text("What's your email address?"), findsOneWidget);
    });

    testWidgets("Should render subtitle label", (WidgetTester tester) async {
      await renderSignUpEmailView(tester);
      expect(
          find.text(
              "Enter the email address at which you can be contacted. No one will see this on your profile."),
          findsOneWidget);
    });

    testWidgets("Should render email field", (WidgetTester tester) async {
      await renderSignUpEmailView(tester);
      expect(find.text("Email Address"), findsOneWidget);
    });

    testWidgets("Should render next button", (WidgetTester tester) async {
      await renderSignUpEmailView(tester);
      expect(find.text("Next"), findsOneWidget);
    });

    testWidgets("Should render sign up with mobile number button",
        (WidgetTester tester) async {
      await renderSignUpEmailView(tester);
      expect(find.byKey(const Key("form_field_view_secondary_button")),
          findsOneWidget);
    });

    group("next button", () {
      testWidgets(
          "Should navigate to sign up email verification view when tapped",
          (WidgetTester tester) async {
        await renderSignUpEmailView(tester);
        tester.tap(find.byKey(const Key("form_field_view_primary_button")));
        await tester.pumpAndSettle();
        expect(find.byType(SignUpEmailVerificationView), findsOneWidget);
      });
    });
  });
}
