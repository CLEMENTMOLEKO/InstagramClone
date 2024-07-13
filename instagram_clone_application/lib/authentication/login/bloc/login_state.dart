part of 'login_bloc.dart';

@immutable
final class LoginState extends Equatable {
  final FormzSubmissionStatus formzSubmissionStatus;
  final PasswordInput passwordInput;
  final EmailInput emailInput;
  final bool isValid;

  const LoginState({
    this.formzSubmissionStatus = FormzSubmissionStatus.initial,
    this.passwordInput = const PasswordInput.pure(),
    this.emailInput = const EmailInput.pure(),
    this.isValid = false,
  });

  LoginState copyWith({
    FormzSubmissionStatus? formzSubmissionStatus,
    PasswordInput? passwordInput,
    EmailInput? emailInput,
    bool? isValid,
  }) {
    return LoginState(
      formzSubmissionStatus:
          formzSubmissionStatus ?? this.formzSubmissionStatus,
      passwordInput: passwordInput ?? this.passwordInput,
      emailInput: emailInput ?? this.emailInput,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object?> get props =>
      [formzSubmissionStatus, passwordInput, emailInput, isValid];
}
