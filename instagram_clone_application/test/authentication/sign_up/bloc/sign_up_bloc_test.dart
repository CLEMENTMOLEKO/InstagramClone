import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_shared/instagram_clone_shared.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {}

class MockUserRepository extends Mock implements UserRepository {}

class MockConnectionChecker extends Mock implements ConnectionChecker {}

class MockEmailService extends Mock implements EmailService {}

extension on SignUpBloc {
  void addSignUpRequestedWith({String? userName}) {
    return add(SignUpRequested(
      userName: userName ?? "Clement",
    ));
  }
}

void main() {
  late SignUpBloc sut;
  late MockAuthenticationService mockAuthenticationService;
  late MockUserRepository mockUserRepository;
  late MockConnectionChecker mockConnectionChecker;
  late MockEmailService mockEmailService;

  setUp(() {
    mockAuthenticationService = MockAuthenticationService();
    mockUserRepository = MockUserRepository();
    mockConnectionChecker = MockConnectionChecker();
    mockEmailService = MockEmailService();
    sut = SignUpBloc(
      authenticationService: mockAuthenticationService,
      userRepository: mockUserRepository,
      connectionChecker: mockConnectionChecker,
      emailService: mockEmailService,
    );
    when(
      () => mockConnectionChecker.hasConnection,
    ).thenAnswer((_) async => true);
  });

  setUpAll(() {
    registerFallbackValue(UserDtoConstants.arrangeEmailAddress());
    registerFallbackValue(UserDtoConstants.arrangePassword());
    registerFallbackValue(
      UserDtoConstants.userDto.toDomainUser().getOrElse(
          () => throw Exception("Error registerFallback for userModel")),
    );
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
      build: () => sut,
      expect: () => const <SignUpState>[],
    );

    blocTest(
      "Should emit [FormzSubmissionStatus.canceled] when not connected to internet",
      seed: () => const SignUpState(isValid: true),
      setUp: () => when(
        () => mockConnectionChecker.hasConnection,
      ).thenAnswer((_) async => false),
      act: (bloc) => bloc.addSignUpRequestedWith(),
      build: () => sut,
      expect: () => const <SignUpState>[
        SignUpState(
            formzSubmissionStatus: FormzSubmissionStatus.canceled,
            isValid: true)
      ],
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
      build: () => sut,
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
      "when registerWithEmail and Password returns Uuid",
      setUp: () {
        when(
          () => mockAuthenticationService.registerWithEmailAndPassword(
            emailAddress: any(named: "emailAddress"),
            password: any(named: "password"),
          ),
        ).thenAnswer((_) async => right(Constants.validUuids.first));
        when(
          () => mockUserRepository.addUser(userModel: any(named: "userModel")),
        ).thenAnswer((_) async => right(unit));
      },
      act: (bloc) => bloc
        ..add(SignUpEmailChanged(email: UserDtoConstants.validEmails.first))
        ..add(SignUpPasswordChanged(
          password: UserDtoConstants.validPasswords.first,
        ))
        ..addSignUpRequestedWith(),
      build: () => sut,
      expect: () => <SignUpState>[
        SignUpState(
            emailInput:
                EmailInput.dirty(value: UserDtoConstants.validEmails.first)),
        SignUpState(
          emailInput:
              EmailInput.dirty(value: UserDtoConstants.validEmails.first),
          passwordInput:
              PasswordInput.dirty(value: UserDtoConstants.validPasswords.first),
          isValid: true,
        ),
        SignUpState(
          formzSubmissionStatus: FormzSubmissionStatus.inProgress,
          isValid: true,
          emailInput:
              EmailInput.dirty(value: UserDtoConstants.validEmails.first),
          passwordInput:
              PasswordInput.dirty(value: UserDtoConstants.validPasswords.first),
        ),
        SignUpState(
          formzSubmissionStatus: FormzSubmissionStatus.success,
          isValid: true,
          emailInput:
              EmailInput.dirty(value: UserDtoConstants.validEmails.first),
          passwordInput:
              PasswordInput.dirty(value: UserDtoConstants.validPasswords.first),
        ),
      ],
    );

    blocTest(
      "Should emit [FormzSubmissionStatus.inProgress, FormzSubmissionStatus.failure] "
      "when password or email are invalid and valid is true",
      seed: () => const SignUpState(isValid: true),
      act: (bloc) => bloc.addSignUpRequestedWith(),
      build: () => sut,
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
      build: () => sut,
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

    group("AddUserToFirebaseDb", () {
      blocTest(
        "Should add user to firebase db when registerWithAndPassword is successful",
        setUp: () {
          when(
            () => mockAuthenticationService.registerWithEmailAndPassword(
                emailAddress: any(named: "emailAddress"),
                password: any(named: "password")),
          ).thenAnswer((_) async => right(Constants.validUuids.first));
          when(
            () =>
                mockUserRepository.addUser(userModel: any(named: "userModel")),
          ).thenAnswer((_) async => right(unit));
        },
        act: (bloc) => bloc
          ..add(SignUpEmailChanged(email: UserDtoConstants.validEmails.first))
          ..add(SignUpPasswordChanged(
            password: UserDtoConstants.validPasswords.first,
          ))
          ..addSignUpRequestedWith(),
        build: () => sut,
        verify: (bloc) {
          verify(
            () =>
                mockUserRepository.addUser(userModel: any(named: "userModel")),
          ).called(1);
        },
      );

      blocTest(
        "Should not add user to firebase db when registerWithAndPassword is unsuccessful",
        setUp: () {
          when(
            () => mockAuthenticationService.registerWithEmailAndPassword(
                emailAddress: any(named: "emailAddress"),
                password: any(named: "password")),
          ).thenAnswer((_) async => left(AuthFailure.weakPassword));
        },
        act: (bloc) => bloc
          ..add(SignUpEmailChanged(email: UserDtoConstants.validEmails.first))
          ..add(SignUpPasswordChanged(
            password: UserDtoConstants.validPasswords.first,
          ))
          ..addSignUpRequestedWith(),
        build: () => sut,
        verify: (bloc) {
          verifyNever(
            () =>
                mockUserRepository.addUser(userModel: any(named: "userModel")),
          );
        },
      );
    });
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
      build: () => sut,
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
      build: () => sut,
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
      build: () => sut,
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
      build: () => sut,
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
      build: () => sut,
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
      build: () => sut,
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
      build: () => sut,
      act: (bloc) => bloc.add(UserNameChanged(userName: userName)),
      expect: () => const <SignUpState>[SignUpState(userName: userName)],
    );
  });

  group("SingUpEmailVerificationRequested", () {
    const verificationCode = 123456;
    blocTest(
      "Should emit current state with verificationCode",
      setUp: () {
        when(
          () => mockEmailService.generateVerificationCode(),
        ).thenReturn(verificationCode);
        when(
          () => mockEmailService.sendVerificationCodeToEmail(
            email: any(named: "email"),
            code: any(named: "code"),
          ),
        ).thenAnswer((_) async => unit);
      },
      seed: () => const SignUpState(
        formzSubmissionStatus: FormzSubmissionStatus.canceled,
      ),
      build: () => sut,
      act: (bloc) => bloc.add(SingUpEmailVerificationRequested(
          email: UserDtoConstants.validEmails.first)),
      expect: () => const <SignUpState>[
        SignUpState(
          formzSubmissionStatus: FormzSubmissionStatus.canceled,
          verificationCode: verificationCode,
        )
      ],
      verify: (bloc) {
        verify(
          () => mockEmailService.sendVerificationCodeToEmail(
            email: UserDtoConstants.validEmails.first,
            code: verificationCode,
          ),
        ).called(1);
      },
    );
  });

  group("SignUpCodeVerificationRequested", () {
    const verificationCode = 123456;
    blocTest(
      "Should emit current state with isEmailVerified true if verificationCode is correct",
      seed: () => const SignUpState(
        formzSubmissionStatus: FormzSubmissionStatus.canceled,
        verificationCode: verificationCode,
      ),
      build: () => sut,
      act: (bloc) => bloc.add(
        SignUpCodeVerificationRequested(code: verificationCode.toString()),
      ),
      expect: () => const <SignUpState>[
        SignUpState(
          formzSubmissionStatus: FormzSubmissionStatus.canceled,
          verificationCode: verificationCode,
          isEmailVerified: true,
        )
      ],
    );
  });
}
