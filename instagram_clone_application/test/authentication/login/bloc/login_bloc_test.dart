import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {}

extension on LoginBloc {
  void addLoginBlocWith({LoginType loginType = LoginType.emailAndAddress}) {
    add(LoginRequested(
      email: "example@email.com",
      password: "P@ssword123",
      type: loginType,
    ));
  }
}

void main() {
  late LoginBloc sut;
  late MockAuthenticationService mockAuthenticationService;
  const testEmail = "example@email.com";
  const testPassword = "P@ssword123";

  setUp(() {
    mockAuthenticationService = MockAuthenticationService();
    sut = LoginBloc(authenticationService: mockAuthenticationService);
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
      act: (bloc) => bloc.add(LoginRequested(
        email: testEmail,
        password: testPassword,
      )),
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
  });
}
