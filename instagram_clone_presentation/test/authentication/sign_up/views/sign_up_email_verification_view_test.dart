import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_email_verification_view.dart';
import 'package:mocktail/mocktail.dart';

class MockSignUpBloc extends MockBloc<SignUpEvent, SignUpState>
    implements SignUpBloc {}

class MockSignUpEvent extends Mock implements VerifySignUpCodeRequested {}

void main() {
  late SignUpEmailVerificationView sut;
  late MockSignUpBloc mockSignUpBloc;

  const validEmail = "test@test.com";

  setUpAll(() {
    registerFallbackValue(MockSignUpEvent());
  });

  setUp(() {
    sut = const SignUpEmailVerificationView();
    mockSignUpBloc = MockSignUpBloc();

    when(() => mockSignUpBloc.state).thenReturn(const SignUpState(
      emailInput: EmailInput.dirty(value: validEmail),
    ));
  });

  Future<void> pumpSignUpEmailVerificationView(
      WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
      home: BlocProvider<SignUpBloc>.value(
        value: mockSignUpBloc,
        child: sut,
      ),
    ));
  }

  group('SignUpEmailVerificationView', () {
    testWidgets('Should display the title', (widgetTester) async {
      //Arrange
      await pumpSignUpEmailVerificationView(widgetTester);
      //Act
      //Assert
      expect(find.text('Enter the confirmation code'), findsOneWidget);
    });

    testWidgets('Should display the subtitle', (widgetTester) async {
      //Arrange
      await pumpSignUpEmailVerificationView(widgetTester);
      //Act
      //Assert
      expect(
        find.text(
            'To confirm your account, enter the 6-digit code that we sent to $validEmail.'),
        findsOneWidget,
      );
    });

    testWidgets('Should display the confirmation code field',
        (widgetTester) async {
      //Arrange
      await pumpSignUpEmailVerificationView(widgetTester);
      //Act
      //Assert
      expect(find.byKey(const Key('form_field_view_field')), findsOneWidget);
    });

    testWidgets("Should display field with label 'Confirmation code'",
        (widgetTester) async {
      //Arrange
      await pumpSignUpEmailVerificationView(widgetTester);
      //Act
      //Assert
      expect(find.text('Confirmation code'), findsOneWidget);
    });

    testWidgets("Should display primary button with text 'Next'",
        (widgetTester) async {
      //Arrange
      await pumpSignUpEmailVerificationView(widgetTester);
      final primaryButtonFinder =
          find.byKey(const Key("form_field_view_primary_button"));
      final primaryButton =
          widgetTester.widget<ElevatedButton>(primaryButtonFinder);
      //Act
      //Assert
      expect(primaryButtonFinder, findsOneWidget);
      expect((primaryButton.child as Text).data, "Next");
    });

    testWidgets(
        "Should display secondary button with text 'I didn't receive the code'",
        (widgetTester) async {
      //Arrange
      await pumpSignUpEmailVerificationView(widgetTester);
      //Act
      //Assert
      expect(find.text("I didn't receive the code"), findsOneWidget);
    });

    group("PrimaryButtonPressed", () {
      testWidgets(
        "Should add [VerifySignUpCodeRequested] event with code on the field",
        (WidgetTester widgetTester) async {
          //Arrange
          const code = "123456";
          await pumpSignUpEmailVerificationView(widgetTester);
          when(
            () => mockSignUpBloc.add(any()),
          ).thenReturn(Unit);
          //Act
          final textField = find.byKey(const Key("form_field_view_field"));
          await widgetTester.enterText(textField, code);
          final primaryButton =
              find.byKey(const Key("form_field_view_primary_button"));
          await widgetTester.tap(primaryButton);
          //Assert
          verify(
            () => mockSignUpBloc.add(VerifySignUpCodeRequested(code: code)),
          );
        },
      );
    });
  });
}
