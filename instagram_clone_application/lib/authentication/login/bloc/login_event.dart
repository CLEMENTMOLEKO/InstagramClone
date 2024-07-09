part of 'login_bloc.dart';

enum LoginType { emailAndAddress, googleSignIn }

@immutable
sealed class LoginEvent {}

class LoginRequested extends LoginEvent {
  final String email;
  final String password;
  final LoginType type;

  LoginRequested({
    required this.email,
    required this.password,
    this.type = LoginType.emailAndAddress,
  });
}

class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged({required this.email});
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged({required this.password});
}
