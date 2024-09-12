part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent extends Equatable {}

class SignUpRequested extends SignUpEvent {
  final String userName;

  SignUpRequested({
    required this.userName,
  });

  @override
  List<Object?> get props => [userName];
}

class SingUpEmailVerificationRequested extends SignUpEvent {
  final String email;

  SingUpEmailVerificationRequested({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}

class VerifySignUpCodeRequested extends SignUpEvent {
  final String code;

  VerifySignUpCodeRequested({required this.code});

  @override
  List<Object?> get props => [code];
}

class SignUpEmailChanged extends SignUpEvent {
  final String email;

  SignUpEmailChanged({required this.email});

  @override
  List<Object?> get props => [email];
}

class SignUpPasswordChanged extends SignUpEvent {
  final String password;

  SignUpPasswordChanged({required this.password});

  @override
  List<Object?> get props => [password];
}

class UserNameChanged extends SignUpEvent {
  final String username;

  UserNameChanged({required this.username});

  @override
  List<Object?> get props => [username];
}
