import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_presentation/authentication/sign_up/views/sign_up_email_verification_view.dart';
import 'package:mocktail/mocktail.dart';

class MockSignUpBloc extends MockBloc<SignUpEvent, SignUpState>
    implements SignUpBloc {}

void main() {
  late SignUpEmailVerificationView sut;
  late MockSignUpBloc mockSignUpBloc;

  const validEmail = "test@test.com";

  setUp(() {
    sut = const SignUpEmailVerificationView();
    mockSignUpBloc = MockSignUpBloc();

    when(() => mockSignUpBloc.state).thenReturn(const SignUpState(
      emailInput: EmailInput.dirty(value: validEmail),
    ));
  });

  Future<void> pumpSignUpEmailVerificationView(WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BlocProvider<SignUpBloc>.value(
        value: mockSignUpBloc,
        child: sut,
      ),
    ));
  }

  group('SignUpEmailVerificationView', () {
    testWidgets('Should display the title', (tester) async {
      await pumpSignUpEmailVerificationView(tester);
      expect(find.text('Enter the confirmation code'), findsOneWidget);
    });

    testWidgets('Should display the subtitle', (tester) async {
      await pumpSignUpEmailVerificationView(tester);
      expect(
          find.text(
              'To confirm your account, enter the 6-digit code that we sent to $validEmail.'),
          findsOneWidget);
    });

    testWidgets('Should display the confirmation code field', (tester) async {
      await pumpSignUpEmailVerificationView(tester);
      expect(find.byKey(const Key('form_field_view_field')), findsOneWidget);
    });

    testWidgets("Should display field with label 'Confirmation code'",
        (tester) async {
      await pumpSignUpEmailVerificationView(tester);
      expect(find.text('Confirmation code'), findsOneWidget);
    });

    testWidgets("Should display primary button with text 'Next'",
        (tester) async {
      await pumpSignUpEmailVerificationView(tester);
      expect(find.text('Next'), findsOneWidget);
    });

    testWidgets(
        "Should display secondary button with text 'I didn't receive the code'",
        (tester) async {
      await pumpSignUpEmailVerificationView(tester);
      expect(find.text("I didn't receive the code"), findsOneWidget);
    });
  });
}
