part of 'sign_up_bloc.dart';

@immutable
final class SignUpState extends Equatable {
  final FormzSubmissionStatus formzSubmissionStatus;
  final PasswordInput passwordInput;
  final EmailInput emailInput;
  final UsernameInput usernameInput;
  final BirthdayInput birthdayInput;
  final int verificationCode;
  final bool isEmailVerified;
  final bool
      isUsernameValid; //TODO: this is used staticly, we should check the db for aready existing users..

  const SignUpState({
    this.formzSubmissionStatus = FormzSubmissionStatus.initial,
    this.passwordInput = const PasswordInput.pure(),
    this.emailInput = const EmailInput.pure(),
    this.usernameInput = const UsernameInput.pure(),
    this.isUsernameValid = false,
    this.birthdayInput = const BirthdayInput.pure(),
    this.verificationCode = 0,
    this.isEmailVerified = false,
  });

  SignUpState copyWith({
    FormzSubmissionStatus? formzSubmissionStatus,
    PasswordInput? passwordInput,
    EmailInput? emailInput,
    UsernameInput? usernameInput,
    BirthdayInput? birthdayInput,
    bool? isUsernameValid,
    int? verificationCode,
    bool? isEmailVerified,
  }) {
    return SignUpState(
      formzSubmissionStatus:
          formzSubmissionStatus ?? this.formzSubmissionStatus,
      passwordInput: passwordInput ?? this.passwordInput,
      emailInput: emailInput ?? this.emailInput,
      usernameInput: usernameInput ?? this.usernameInput,
      isUsernameValid: isUsernameValid ?? this.isUsernameValid,
      birthdayInput: birthdayInput ?? this.birthdayInput,
      verificationCode: verificationCode ?? this.verificationCode,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
  }

  @override
  List<Object?> get props => [
        formzSubmissionStatus,
        passwordInput,
        emailInput,
        usernameInput,
        isUsernameValid,
        birthdayInput,
        verificationCode,
        isEmailVerified,
      ];
}
