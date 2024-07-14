import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utils/constants/constants.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {}

extension on LoginBloc {
  void addLoginRequestedEventWith({
    LoginType loginType = LoginType.emailAndAddress,
    String? emailAddress,
    String? password,
  }) {
    add(LoginRequested(
      email: emailAddress ?? UserDtoConstants.validEmails.first,
      password: password ?? UserDtoConstants.validPasswords.first,
      type: loginType,
    ));
  }
}

void main() {
  late LoginBloc sut;
  late MockAuthenticationService mockAuthenticationService;

  setUp(() {
    mockAuthenticationService = MockAuthenticationService();
    sut = LoginBloc(authenticationService: mockAuthenticationService);
  });

  setUpAll(() {
    registerFallbackValue(UserDtoConstants.arrangeEmailAddress());
    registerFallbackValue(UserDtoConstants.arrangePassword());
  });

  test(
    "Should have status as [FormzSubmissionStatus.initial] when first initialized",
    () {
      //Arrange
      const loginState = LoginState();
      //Act
      //Assert
      expect(sut.state, equals(loginState));
      sut.close();
    },
  );

  group("LoginRequested", () {
    blocTest(
      "Should not emit new state when login is requested with LoginState.isValid is false",
      act: (bloc) => bloc.addLoginRequestedEventWith(
          emailAddress: UserDtoConstants.invalidEmails.first),
      build: () => LoginBloc(
        authenticationService: mockAuthenticationService,
      ),
      expect: () => const <LoginState>[],
    );

    group("SignInWithGoogle", () {
      blocTest(
        "Should emit [FormzSubmissionStatus.success] when login type is [Logintype.googleSignIn] and google sign in was successful",
        seed: () => const LoginState(isValid: true),
        setUp: () {
          when(() => mockAuthenticationService.signInWithGoogle())
              .thenAnswer((_) async => right(unit));
        },
        act: (bloc) {
          bloc.addLoginRequestedEventWith(loginType: LoginType.googleSignIn);
        },
        build: () => LoginBloc(
          authenticationService: mockAuthenticationService,
        ),
        expect: () => const <LoginState>[
          LoginState(
            formzSubmissionStatus: FormzSubmissionStatus.inProgress,
            isValid: true,
          ),
          LoginState(
            formzSubmissionStatus: FormzSubmissionStatus.success,
            isValid: true,
          ),
        ],
      );

      blocTest(
        "Should emit [FormzSubmission.failure] when login type is [LoginType.googleSignIn] and google sign in failed",
        seed: () => const LoginState(isValid: true),
        setUp: () {
          when(
            () => mockAuthenticationService.signInWithGoogle(),
          ).thenAnswer((_) async => left(AuthFailure.userCancelledLogin));
        },
        act: (bloc) =>
            bloc.addLoginRequestedEventWith(loginType: LoginType.googleSignIn),
        build: () =>
            LoginBloc(authenticationService: mockAuthenticationService),
        expect: () => const <LoginState>[
          LoginState(
            formzSubmissionStatus: FormzSubmissionStatus.inProgress,
            isValid: true,
          ),
          LoginState(
            formzSubmissionStatus: FormzSubmissionStatus.failure,
            isValid: true,
          ),
        ],
      );
    });

    group("LoginWithEmailAddress", () {
      blocTest(
        "Should emit [FormzSubmissionStatus.success] when login type is [LoginType.emailAndAddress] "
        "and password and email are valid with [loginWithEmailAndPassword] returning [Unit]",
        seed: () => const LoginState(isValid: true),
        setUp: () {
          when(
            () => mockAuthenticationService.loginWithEmailAndPassword(
              emailAddress: any(named: "emailAddress"),
              password: any(named: "password"),
            ),
          ).thenAnswer((_) async => right(unit));
        },
        act: (bloc) => bloc.addLoginRequestedEventWith(
            loginType: LoginType.emailAndAddress),
        build: () =>
            LoginBloc(authenticationService: mockAuthenticationService),
        expect: () => const <LoginState>[
          LoginState(
              formzSubmissionStatus: FormzSubmissionStatus.inProgress,
              isValid: true),
          LoginState(
              formzSubmissionStatus: FormzSubmissionStatus.success,
              isValid: true),
        ],
      );

      blocTest(
        "Should emit [FormzSubmission.failure] when login type is [LoginType.emailAndAddress] "
        "and password and email are valid with [loginWithEmailAndPassword] returning [AuthFailure]",
        seed: () => const LoginState(isValid: true),
        setUp: () {
          when(
            () => mockAuthenticationService.loginWithEmailAndPassword(
              emailAddress: any(named: "emailAddress"),
              password: any(named: "password"),
            ),
          ).thenAnswer((_) async => left(AuthFailure.emailAlreadyInUse));
        },
        act: (bloc) => bloc.addLoginRequestedEventWith(
            loginType: LoginType.emailAndAddress),
        build: () =>
            LoginBloc(authenticationService: mockAuthenticationService),
        expect: () => const <LoginState>[
          LoginState(
            formzSubmissionStatus: FormzSubmissionStatus.inProgress,
            isValid: true,
          ),
          LoginState(
            formzSubmissionStatus: FormzSubmissionStatus.failure,
            isValid: true,
          ),
        ],
      );
    });

    group("EmailChanged", () {
      blocTest(
        "Should emit state with isValid true with current state"
        "when email is valid. and password is valid",
        seed: () => LoginState(
          formzSubmissionStatus: FormzSubmissionStatus.canceled,
          passwordInput: ValidatorsConstants.validPasswordInput,
        ),
        act: (bloc) =>
            bloc.add(EmailChanged(email: UserDtoConstants.validEmails.first)),
        build: () =>
            LoginBloc(authenticationService: mockAuthenticationService),
        expect: () => <LoginState>[
          LoginState(
            formzSubmissionStatus: FormzSubmissionStatus.canceled,
            passwordInput: ValidatorsConstants.validPasswordInput,
            emailInput: ValidatorsConstants.validEmailInput,
            isValid: true,
          )
        ],
      );

      blocTest(
        "Should emit current state with isValid false"
        "when email is valid but password is invalid",
        seed: () =>
            LoginState(passwordInput: ValidatorsConstants.invalidPasswordInput),
        act: (bloc) =>
            bloc.add(EmailChanged(email: UserDtoConstants.validEmails.first)),
        build: () =>
            LoginBloc(authenticationService: mockAuthenticationService),
        expect: () => <LoginState>[
          LoginState(
            passwordInput: ValidatorsConstants.invalidPasswordInput,
            emailInput: ValidatorsConstants.validEmailInput,
          )
        ],
      );
    });
    group("PasswordChanged", () {
      blocTest(
        "Should emit current state with isValid false "
        "when password is invalid",
        seed: () => const LoginState(
            formzSubmissionStatus: FormzSubmissionStatus.canceled),
        act: (bloc) => bloc.add(
            PasswordChanged(password: UserDtoConstants.invalidPasswords.first)),
        build: () =>
            LoginBloc(authenticationService: mockAuthenticationService),
        expect: () => <LoginState>[
          LoginState(
            formzSubmissionStatus: FormzSubmissionStatus.canceled,
            passwordInput: ValidatorsConstants.invalidPasswordInput,
          )
        ],
      );

      blocTest(
        "Should emit state with current state and isValid true"
        "when password is valid and current state has email as valid.",
        seed: () => LoginState(
          emailInput: ValidatorsConstants.validEmailInput,
        ),
        act: (bloc) => bloc.add(
            PasswordChanged(password: UserDtoConstants.validPasswords.first)),
        build: () =>
            LoginBloc(authenticationService: mockAuthenticationService),
        expect: () => <LoginState>[
          LoginState(
            isValid: true,
            passwordInput: ValidatorsConstants.validPasswordInput,
            emailInput: ValidatorsConstants.validEmailInput,
          )
        ],
      );
    });
  });
}
