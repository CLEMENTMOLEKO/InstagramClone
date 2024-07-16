import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utils/constants/constants.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {}

extension on SignUpBloc {
  void addSignUpRequestedWith({
    String? emailAddress,
    String? password,
  }) {
    return add(SignUpRequested(
      email: emailAddress ?? UserDtoConstants.validEmails.first,
      password: password ?? UserDtoConstants.validPasswords.first,
      userName: "Clement",
    ));
  }
}

void main() {
  late SignUpBloc sut;
  late MockAuthenticationService mockAuthenticationService;

  setUp(() {
    mockAuthenticationService = MockAuthenticationService();
    sut = SignUpBloc(
      authenticationService: mockAuthenticationService,
    );
  });

  setUpAll(() {
    registerFallbackValue(UserDtoConstants.arrangeEmailAddress());
    registerFallbackValue(UserDtoConstants.arrangePassword());
  });

  test(
    "Should have status as [FormzSubmissionStatus.initial] when first initialized",
    () {
      //Arrange
      const signUpState = SignUpState();
      //Act
      //Assert
      expect(sut.state, equals(signUpState));
      sut.close();
    },
  );

  group("SignUpRequested", () {
    blocTest(
      "Should not emit new state when state is invalid",
      act: (bloc) => bloc.addSignUpRequestedWith(),
      build: () => SignUpBloc(
        authenticationService: mockAuthenticationService,
      ),
      expect: () => const <SignUpState>[],
    );

    blocTest(
      "Should emit [FormzSubmissionStatus.inProgress, FormzSubmissionStatus.failure] "
      "when registerWithEmail and Password returns AuthFailure",
      seed: () => const SignUpState(isValid: true),
      setUp: () {
        when(
          () => mockAuthenticationService.registerWithEmailAndPassword(
            emailAddress: any(named: "emailAddress"),
            password: any(named: "password"),
          ),
        ).thenAnswer((_) async => left(AuthFailure.emailAlreadyInUse));
      },
      act: (bloc) => bloc.addSignUpRequestedWith(),
      build: () => SignUpBloc(
        authenticationService: mockAuthenticationService,
      ),
      expect: () => const <SignUpState>[
        SignUpState(
          formzSubmissionStatus: FormzSubmissionStatus.inProgress,
          isValid: true,
        ),
        SignUpState(
          formzSubmissionStatus: FormzSubmissionStatus.failure,
          isValid: true,
        ),
      ],
    );

    blocTest(
      "Should emit [FormzSubmissionStatus.inProgress, FormzSubmissionStatus.success] "
      "when registerWithEmail and Password returns Unit",
      seed: () => const SignUpState(isValid: true),
      setUp: () {
        when(
          () => mockAuthenticationService.registerWithEmailAndPassword(
            emailAddress: any(named: "emailAddress"),
            password: any(named: "password"),
          ),
        ).thenAnswer((_) async => right(unit));
      },
      act: (bloc) => bloc.addSignUpRequestedWith(),
      build: () => SignUpBloc(
        authenticationService: mockAuthenticationService,
      ),
      expect: () => const <SignUpState>[
        SignUpState(
          formzSubmissionStatus: FormzSubmissionStatus.inProgress,
          isValid: true,
        ),
        SignUpState(
          formzSubmissionStatus: FormzSubmissionStatus.success,
          isValid: true,
        ),
      ],
    );

    blocTest(
      "Should emit [FormzSubmissionStatus.inProgress, FormzSubmissionStatus.failure] "
      "when password or email are invalid and valid is true",
      seed: () => const SignUpState(isValid: true),
      act: (bloc) => bloc.addSignUpRequestedWith(
        emailAddress: UserDtoConstants.invalidEmails.first,
        password: UserDtoConstants.invalidPasswords.first,
      ),
      build: () => SignUpBloc(
        authenticationService: mockAuthenticationService,
      ),
      expect: () => const <SignUpState>[
        SignUpState(
          formzSubmissionStatus: FormzSubmissionStatus.inProgress,
          isValid: true,
        ),
        SignUpState(
          formzSubmissionStatus: FormzSubmissionStatus.failure,
          isValid: true,
        ),
      ],
    );

    blocTest(
      "Should emit no new state when password or email are invalid",
      act: (bloc) => bloc
        ..add(SignUpEmailChanged(email: UserDtoConstants.invalidEmails.first))
        ..add(SignUpPasswordChanged(
          password: UserDtoConstants.validPasswords.first,
        )),
      build: () => SignUpBloc(
        authenticationService: mockAuthenticationService,
      ),
      expect: () => <SignUpState>[
        SignUpState(
            emailInput:
                EmailInput.dirty(value: UserDtoConstants.invalidEmails.first)),
        SignUpState(
          emailInput:
              EmailInput.dirty(value: UserDtoConstants.invalidEmails.first),
          passwordInput:
              PasswordInput.dirty(value: UserDtoConstants.validPasswords.first),
        ),
      ],
    );
  });

  group("SignUpPasswordChanged", () {
    blocTest(
      "Should emit current state with isValid false if password is invalid and email was invalid",
      seed: () => SignUpState(
        emailInput:
            EmailInput.dirty(value: UserDtoConstants.invalidEmails.first),
      ),
      act: (bloc) => bloc.add(SignUpPasswordChanged(
          password: UserDtoConstants.invalidPasswords.first)),
      build: () => SignUpBloc(authenticationService: mockAuthenticationService),
      expect: () => <SignUpState>[
        SignUpState(
          passwordInput: PasswordInput.dirty(
              value: UserDtoConstants.invalidPasswords.first),
          emailInput:
              EmailInput.dirty(value: UserDtoConstants.invalidEmails.first),
        )
      ],
    );

    blocTest(
      "Should emit current state with isValid false if password is invalid and email was valid",
      seed: () => SignUpState(
        emailInput: EmailInput.dirty(value: UserDtoConstants.validEmails.first),
      ),
      act: (bloc) => bloc.add(SignUpPasswordChanged(
          password: UserDtoConstants.invalidPasswords.first)),
      build: () => SignUpBloc(authenticationService: mockAuthenticationService),
      expect: () => <SignUpState>[
        SignUpState(
          passwordInput: PasswordInput.dirty(
              value: UserDtoConstants.invalidPasswords.first),
          emailInput:
              EmailInput.dirty(value: UserDtoConstants.validEmails.first),
        )
      ],
    );

    blocTest(
      "Should emit current state with isValid true if password is valid and email was valid",
      seed: () => SignUpState(
        emailInput: EmailInput.dirty(value: UserDtoConstants.validEmails.first),
      ),
      act: (bloc) => bloc.add(SignUpPasswordChanged(
          password: UserDtoConstants.validPasswords.first)),
      build: () => SignUpBloc(authenticationService: mockAuthenticationService),
      expect: () => <SignUpState>[
        SignUpState(
          passwordInput:
              PasswordInput.dirty(value: UserDtoConstants.validPasswords.first),
          emailInput:
              EmailInput.dirty(value: UserDtoConstants.validEmails.first),
          isValid: true,
        )
      ],
    );
  });
  group("SignUpEmailChanged", () {
    blocTest(
      "Should emit current state with isValid false if email is invalid and password was invalid",
      seed: () => SignUpState(
        passwordInput:
            PasswordInput.dirty(value: UserDtoConstants.invalidPasswords.first),
      ),
      act: (bloc) => bloc
          .add(SignUpEmailChanged(email: UserDtoConstants.invalidEmails.first)),
      build: () => SignUpBloc(authenticationService: mockAuthenticationService),
      expect: () => <SignUpState>[
        SignUpState(
          passwordInput: PasswordInput.dirty(
              value: UserDtoConstants.invalidPasswords.first),
          emailInput:
              EmailInput.dirty(value: UserDtoConstants.invalidEmails.first),
        )
      ],
    );

    blocTest(
      "Should emit current state with isValid false if email is invalid and password was valid",
      seed: () => SignUpState(
        passwordInput:
            PasswordInput.dirty(value: UserDtoConstants.validPasswords.first),
      ),
      act: (bloc) => bloc
          .add(SignUpEmailChanged(email: UserDtoConstants.invalidEmails.first)),
      build: () => SignUpBloc(authenticationService: mockAuthenticationService),
      expect: () => <SignUpState>[
        SignUpState(
          passwordInput:
              PasswordInput.dirty(value: UserDtoConstants.validPasswords.first),
          emailInput:
              EmailInput.dirty(value: UserDtoConstants.invalidEmails.first),
        )
      ],
    );

    blocTest(
      "Should emit current state with isValid true if email is valid and password was valid",
      seed: () => SignUpState(
        passwordInput:
            PasswordInput.dirty(value: UserDtoConstants.validPasswords.first),
      ),
      act: (bloc) => bloc
          .add(SignUpEmailChanged(email: UserDtoConstants.validEmails.first)),
      build: () => SignUpBloc(authenticationService: mockAuthenticationService),
      expect: () => <SignUpState>[
        SignUpState(
          passwordInput:
              PasswordInput.dirty(value: UserDtoConstants.validPasswords.first),
          emailInput:
              EmailInput.dirty(value: UserDtoConstants.validEmails.first),
          isValid: true,
        )
      ],
    );
  });

  group("UserNameChanged", () {
    const userName = "Clement";
    blocTest(
      "Should emit current state with changed userName",
      build: () => SignUpBloc(authenticationService: mockAuthenticationService),
      act: (bloc) => bloc.add(UserNameChanged(userName: userName)),
      expect: () => const <SignUpState>[SignUpState(userName: userName)],
    );
  });
}
