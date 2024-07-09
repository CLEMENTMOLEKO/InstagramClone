import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utils/constants/constants.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {}

extension on LoginBloc {
  void addLoginBlocWith({
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
    "Should have status as [LoginStatus.unknown] when first initialized",
    () {
      //Arrange
      //Act
      //Assert
      expect(sut.state.status, equals(LoginStatus.unknown));
      expect(sut.state.isEmailValid, equals(false));
      expect(sut.state.isPasswordValid, equals(false));
      sut.close();
    },
  );

  group("LoginRequested", () {
    blocTest(
      "Should not emit new state when login is requested with current state as LoginStatus.validationFailure",
      seed: () => const LoginState(status: LoginStatus.validationFailure),
      act: (bloc) => bloc.addLoginBlocWith(),
      build: () => LoginBloc(
        authenticationService: mockAuthenticationService,
      ),
      expect: () => const <LoginState>[],
    );

    group("SignInWithGoogle", () {
      blocTest(
        "Should emit [LoginStatus.success] when login type is [Logintype.googleSignIn] and google sign in was successful",
        setUp: () {
          when(() => mockAuthenticationService.signInWithGoogle())
              .thenAnswer((_) async => right(unit));
        },
        act: (bloc) => bloc.addLoginBlocWith(loginType: LoginType.googleSignIn),
        build: () => LoginBloc(
          authenticationService: mockAuthenticationService,
        ),
        expect: () => const <LoginState>[
          LoginState(status: LoginStatus.inProgress),
          LoginState(status: LoginStatus.success),
        ],
      );

      blocTest(
        "Should emit [LoginStatus.failure] when login type is [LoginType.googleSignIn] and google sign in failed",
        setUp: () {
          when(
            () => mockAuthenticationService.signInWithGoogle(),
          ).thenAnswer((_) async => left(AuthFailure.userCancelledLogin));
        },
        act: (bloc) => bloc.addLoginBlocWith(loginType: LoginType.googleSignIn),
        build: () =>
            LoginBloc(authenticationService: mockAuthenticationService),
        expect: () => const <LoginState>[
          LoginState(status: LoginStatus.inProgress),
          LoginState(status: LoginStatus.failure),
        ],
      );
    });

    group("LoginWithEmailAddress", () {
      blocTest(
        "Should emit [LoginStatus.success] when login type is [LoginType.emailAndAddress] "
        "and password and email are valid with [loginWithEmailAndPassword] returning [Unit]",
        setUp: () {
          when(
            () => mockAuthenticationService.loginWithEmailAndPassword(
              emailAddress: any(named: "emailAddress"),
              password: any(named: "password"),
            ),
          ).thenAnswer((_) async => right(unit));
        },
        act: (bloc) =>
            bloc.addLoginBlocWith(loginType: LoginType.emailAndAddress),
        build: () =>
            LoginBloc(authenticationService: mockAuthenticationService),
        expect: () => const <LoginState>[
          LoginState(status: LoginStatus.inProgress),
          LoginState(status: LoginStatus.success),
        ],
      );

      blocTest(
        "Should emit [LoginStatus.failure] when login type is [LoginType.emailAndAddress] "
        "and password and email are valid with [loginWithEmailAndPassword] returning [AuthFailure]",
        setUp: () {
          when(
            () => mockAuthenticationService.loginWithEmailAndPassword(
              emailAddress: any(named: "emailAddress"),
              password: any(named: "password"),
            ),
          ).thenAnswer((_) async => left(AuthFailure.emailAlreadyInUse));
        },
        act: (bloc) =>
            bloc.addLoginBlocWith(loginType: LoginType.emailAndAddress),
        build: () =>
            LoginBloc(authenticationService: mockAuthenticationService),
        expect: () => const <LoginState>[
          LoginState(status: LoginStatus.inProgress),
          LoginState(status: LoginStatus.failure),
        ],
      );

      blocTest(
        "Should emit [LoginStatus.failure] when login type is [LoginType.emailAndAddress] "
        "and password or email is invalid",
        act: (bloc) => bloc.addLoginBlocWith(
          loginType: LoginType.emailAndAddress,
          emailAddress: UserDtoConstants.invalidEmails.first,
          password: UserDtoConstants.invalidPasswords.first,
        ),
        build: () =>
            LoginBloc(authenticationService: mockAuthenticationService),
        expect: () => const <LoginState>[
          LoginState(status: LoginStatus.inProgress),
          LoginState(status: LoginStatus.failure),
        ],
        verify: (_) => verifyNever(
          () => mockAuthenticationService.loginWithEmailAndPassword(
            emailAddress: any(named: "emailAddress"),
            password: any(named: "password"),
          ),
        ),
      );
    });
  });
}
