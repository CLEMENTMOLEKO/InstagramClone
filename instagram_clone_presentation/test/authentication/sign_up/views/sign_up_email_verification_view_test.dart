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
  });
}
