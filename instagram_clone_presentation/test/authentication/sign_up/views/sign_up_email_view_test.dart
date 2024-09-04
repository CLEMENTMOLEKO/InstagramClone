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

  void setupValidState() {
    when(() => mockSignUpBloc.state).thenReturn(const SignUpState(
      emailInput: EmailInput.dirty(value: "test@test.com"),
    ));
  }

  void setupInvalidState() {
    when(() => mockSignUpBloc.state).thenReturn(const SignUpState(
      emailInput: EmailInput.dirty(value: "testtest.com"),
    ));
  }

  Future<void> renderSignUpEmailView(
      WidgetTester widgetTester, SignUpBloc bloc) async {
    await widgetTester.pumpWidget(MaterialApp(
      home: BlocProvider<SignUpBloc>.value(
        value: bloc,
        child: const SignUpEmailView(),
      ),
    ));
  }

  group("SignUpEmailView", () {
    testWidgets("Should render title label", (WidgetTester widgetTester) async {
      // Arrange
      await renderSignUpEmailView(widgetTester, mockSignUpBloc);

      // Act
      final titleFinder = find.text("What's your email address?");

      // Assert
      expect(titleFinder, findsOneWidget);
    });

    testWidgets("Should render subtitle label",
        (WidgetTester widgetTester) async {
      // Arrange
      await renderSignUpEmailView(widgetTester, mockSignUpBloc);

      // Act
      final subtitleFinder = find.text(
          "Enter the email address at which you can be contacted. No one will see this on your profile.");

      // Assert
      expect(subtitleFinder, findsOneWidget);
    });

    testWidgets("Should render email field", (WidgetTester widgetTester) async {
      // Arrange
      await renderSignUpEmailView(widgetTester, mockSignUpBloc);

      // Act
      final emailFieldFinder = find.byKey(const Key("form_field_view_field"));

      // Assert
      expect(emailFieldFinder, findsOneWidget);
    });

    testWidgets("Should render next button", (WidgetTester widgetTester) async {
      // Arrange
      await renderSignUpEmailView(widgetTester, mockSignUpBloc);

      // Act
      final nextButtonFinder =
          find.byKey(const Key("form_field_view_primary_button"));
      final primaryButton =
          widgetTester.widget<ElevatedButton>(nextButtonFinder);
      //Act
      //Assert
      expect(nextButtonFinder, findsOneWidget);
      expect((primaryButton.child as Text).data, "Next");
    });

    testWidgets("Should render sign up with mobile number button",
        (WidgetTester widgetTester) async {
      // Arrange
      await renderSignUpEmailView(widgetTester, mockSignUpBloc);

      // Act
      final mobileButtonFinder =
          find.byKey(const Key("form_field_view_secondary_button"));
      final mobileButton = widgetTester.widget<TextButton>(mobileButtonFinder);
      // Assert
      expect(mobileButtonFinder, findsOneWidget);
      expect((mobileButton.child as Text).data, "Sign Up with Mobile Number");
    });

    group("Email Text Field", () {
      (Finder, InstaTextField) setupTextFieldWidget(WidgetTester widgetTester) {
        final emailFieldFinder = find.byKey(const Key("form_field_view_field"));
        final emailField =
            widgetTester.widget(emailFieldFinder) as InstaTextField;
        return (emailFieldFinder, emailField);
      }

      testWidgets("Should emit email changed event when email is changed",
          (WidgetTester widgetTester) async {
        // Arrange
        await renderSignUpEmailView(widgetTester, mockSignUpBloc);

        // Act
        final (emailFieldFinder, _) = setupTextFieldWidget(widgetTester);
        await widgetTester.enterText(emailFieldFinder, "test@example.com");
        await widgetTester.pumpAndSettle();
        // Assert
        verify(() =>
            mockSignUpBloc.add(SignUpEmailChanged(email: "test@example.com")));
        expect(emailFieldFinder, findsOneWidget);
      });

      testWidgets("Should show error icon when email is invalid",
          (WidgetTester widgetTester) async {
        // Arrange
        setupInvalidState();
        await renderSignUpEmailView(widgetTester, mockSignUpBloc);

        // Act
        final (_, emailField) = setupTextFieldWidget(widgetTester);
        // Assert
        expect(emailField.icon, isNotNull);
        expect(emailField.icon!.icon, Icons.error);
        expect(emailField.icon!.color, Colors.red);
      });

      testWidgets("Should show check icon when email is valid",
          (WidgetTester widgetTester) async {
        // Arrange
        setupValidState();
        await renderSignUpEmailView(widgetTester, mockSignUpBloc);
        // Act
        final (_, emailField) = setupTextFieldWidget(widgetTester);
        // Assert
        expect(emailField.icon, isNotNull);
        expect(emailField.icon!.icon, Icons.check_circle);
        expect(emailField.icon!.color, Colors.green);
      });
    });

    group("next button", () {
      ElevatedButton setupButtonWidget(WidgetTester widgetTester) {
        final nextButtonFinder =
            find.byKey(const Key("form_field_view_primary_button"));
        final nextButton =
            widgetTester.widget(nextButtonFinder) as ElevatedButton;
        return nextButton;
      }

      testWidgets("Should enable next button when email is valid",
          (WidgetTester widgetTester) async {
        // Arrange
        setupValidState();
        await renderSignUpEmailView(widgetTester, mockSignUpBloc);
        final nextButton = setupButtonWidget(widgetTester);
        // Act
        // Assert
        expect(nextButton.onPressed, isNotNull);
      });

      testWidgets("Should disable next button when email is invalid",
          (WidgetTester widgetTester) async {
        // Arrange
        setupInvalidState();
        await renderSignUpEmailView(widgetTester, mockSignUpBloc);
        // Act
        final nextButton = setupButtonWidget(widgetTester);
        // Assert
        expect(nextButton.onPressed, isNull);
      });
    });
  });
}
