part of 'login_bloc.dart';

enum LoginStatus { inProgress, failure, validationFailure, success, unknown }

@immutable
final class LoginState extends Equatable {
  final LoginStatus status;
  final bool isEmailValid;
  final bool isPasswordValid;

  const LoginState({
    this.status = LoginStatus.unknown,
    this.isEmailValid = false,
    this.isPasswordValid = false,
  });

  LoginState copyWith({
    LoginStatus? status,
    bool? isEmailValid,
    bool? isPasswordValid,
  }) {
    return LoginState(
      status: status ?? this.status,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
    );
  }

  @override
  List<Object?> get props => [status, isEmailValid, isPasswordValid];
}
