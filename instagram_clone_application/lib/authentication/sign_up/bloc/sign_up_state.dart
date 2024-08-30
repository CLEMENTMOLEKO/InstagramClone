part of 'sign_up_bloc.dart';

@immutable
final class SignUpState extends Equatable {
  final FormzSubmissionStatus formzSubmissionStatus;
  final PasswordInput passwordInput;
  final EmailInput emailInput;
  final String userName;
  final int verificationCode;
  final bool isValid;

  const SignUpState({
    this.formzSubmissionStatus = FormzSubmissionStatus.initial,
    this.passwordInput = const PasswordInput.pure(),
    this.emailInput = const EmailInput.pure(),
    this.userName = '',
    this.isValid = false,
    this.verificationCode = 0,
  });

  SignUpState copyWith({
    FormzSubmissionStatus? formzSubmissionStatus,
    PasswordInput? passwordInput,
    EmailInput? emailInput,
    String? userName,
    bool? isValid,
    int? verificationCode,
  }) {
    return SignUpState(
      formzSubmissionStatus:
          formzSubmissionStatus ?? this.formzSubmissionStatus,
      passwordInput: passwordInput ?? this.passwordInput,
      emailInput: emailInput ?? this.emailInput,
      userName: userName ?? this.userName,
      isValid: isValid ?? this.isValid,
      verificationCode: verificationCode ?? this.verificationCode,
    );
  }

  @override
  List<Object?> get props => [
        formzSubmissionStatus,
        passwordInput,
        emailInput,
        userName,
        isValid,
        verificationCode,
      ];
}
