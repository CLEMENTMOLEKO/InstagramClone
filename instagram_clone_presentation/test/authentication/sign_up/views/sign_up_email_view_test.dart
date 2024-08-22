import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_email_view.dart';
import 'package:instagram_clone_presentation/common/widgets/insta_text_field.dart';
import 'package:mocktail/mocktail.dart';

class MockSignUpBloc extends MockBloc<SignUpEvent, SignUpState>
    implements SignUpBloc {}

void main() {
  late MockSignUpBloc mockSignUpBloc;
  setUp(() {
    mockSignUpBloc = MockSignUpBloc();
    when(() => mockSignUpBloc.state).thenReturn(const SignUpState());
  });

  Future<void> renderSignUpEmailView(
      WidgetTester tester, SignUpBloc bloc) async {
    await tester.pumpWidget(MaterialApp(
      home: BlocProvider<SignUpBloc>.value(
        value: bloc,
        child: const SignUpEmailView(),
      ),
    ));
  }

  group("SignUpEmailView", () {
    testWidgets("Should render title label", (WidgetTester tester) async {
      // Arrange
      await renderSignUpEmailView(tester, mockSignUpBloc);

      // Act
      final titleFinder = find.text("What's your email address?");

      // Assert
      expect(titleFinder, findsOneWidget);
    });

    testWidgets("Should render subtitle label", (WidgetTester tester) async {
      // Arrange
      await renderSignUpEmailView(tester, mockSignUpBloc);

      // Act
      final subtitleFinder = find.text(
          "Enter the email address at which you can be contacted. No one will see this on your profile.");

      // Assert
      expect(subtitleFinder, findsOneWidget);
    });

    testWidgets("Should render email field", (WidgetTester tester) async {
      // Arrange
      await renderSignUpEmailView(tester, mockSignUpBloc);

      // Act
      final emailFieldFinder = find.byKey(const Key("form_field_view_field"));

      // Assert
      expect(emailFieldFinder, findsOneWidget);
    });

    testWidgets("Should render next button", (WidgetTester tester) async {
      // Arrange
      await renderSignUpEmailView(tester, mockSignUpBloc);

      // Act
      final nextButtonFinder = find.text("Next");

      // Assert
      expect(nextButtonFinder, findsOneWidget);
    });

    testWidgets("Should render sign up with mobile number button",
        (WidgetTester tester) async {
      // Arrange
      await renderSignUpEmailView(tester, mockSignUpBloc);

      // Act
      final mobileButtonFinder =
          find.byKey(const Key("form_field_view_secondary_button"));

      // Assert
      expect(mobileButtonFinder, findsOneWidget);
    });

    group("Email Text Field", () {
      testWidgets("Should emit email changed event when email is changed",
          (WidgetTester tester) async {
        // Arrange
        await renderSignUpEmailView(tester, mockSignUpBloc);

        // Act
        final emailFieldFinder = find.byKey(const Key("form_field_view_field"));
        await tester.enterText(emailFieldFinder, "test@example.com");
        await tester.pumpAndSettle();
        // Assert
        verify(() =>
            mockSignUpBloc.add(SignUpEmailChanged(email: "test@example.com")));
        expect(emailFieldFinder, findsOneWidget);
      });

      testWidgets("Should show error icon when email is invalid",
          (WidgetTester tester) async {
        // Arrange
        when(() => mockSignUpBloc.state).thenReturn(const SignUpState(
          emailInput: EmailInput.dirty(value: "testtest.com"),
        ));
        await renderSignUpEmailView(tester, mockSignUpBloc);
        await tester.pumpAndSettle();

        // Act
        final emailFieldFinder = find.byKey(const Key("form_field_view_field"));
        final emailField = tester.widget(emailFieldFinder) as InstaTextField;
        // Assert
        expect(emailField.icon, isNotNull);
        expect(emailField.icon!.icon, Icons.error);
        expect(emailField.icon!.color, Colors.red);
      });

      testWidgets("Should show check icon when email is valid",
          (WidgetTester tester) async {
        // Arrange
        when(() => mockSignUpBloc.state).thenReturn(const SignUpState(
          emailInput: EmailInput.dirty(value: "test@test.com"),
        ));
        await renderSignUpEmailView(tester, mockSignUpBloc);
        await tester.pumpAndSettle();
        // Act
        final emailFieldFinder = find.byKey(const Key("form_field_view_field"));
        final emailField = tester.widget(emailFieldFinder) as InstaTextField;
        // Assert
        expect(emailField.icon, isNotNull);
        expect(emailField.icon!.icon, Icons.check_circle);
        expect(emailField.icon!.color, Colors.green);
      });
    });

    group("next button", () {
      testWidgets("Should enable next button when email is valid",
          (WidgetTester tester) async {
        // Arrange
        when(() => mockSignUpBloc.state).thenReturn(const SignUpState(
          emailInput: EmailInput.dirty(value: "test@test.com"),
        ));
        await renderSignUpEmailView(tester, mockSignUpBloc);
        await tester.pumpAndSettle();
        final nextButtonFinder =
            find.byKey(const Key("form_field_view_primary_button"));
        final nextButton = tester.widget(nextButtonFinder) as ElevatedButton;
        // Act

        // Assert
        expect(nextButton.onPressed, isNotNull);
      });

      testWidgets("Should disable next button when email is invalid",
          (WidgetTester tester) async {
        // Arrange
        when(() => mockSignUpBloc.state).thenReturn(const SignUpState(
          emailInput: EmailInput.dirty(value: "testtest.com"),
        ));
        await renderSignUpEmailView(tester, mockSignUpBloc);
        await tester.pumpAndSettle();
        // Act
        final nextButtonFinder =
            find.byKey(const Key("form_field_view_primary_button"));
        final nextButton = tester.widget(nextButtonFinder) as ElevatedButton;
        // Assert
        expect(nextButton.onPressed, isNull);
      });
    });
  });
}
