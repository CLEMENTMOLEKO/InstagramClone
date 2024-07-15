part of 'login_bloc.dart';

enum LoginType { emailAndAddress, googleSignIn }

@immutable
sealed class LoginEvent extends Equatable {}

class LoginRequested extends LoginEvent {
  final String email;
  final String password;
  final LoginType type;

  LoginRequested({
    required this.email,
    required this.password,
    this.type = LoginType.emailAndAddress,
  });

  @override
  List<Object?> get props => [email, password, type];
}

class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged({required this.email});

  @override
  List<Object?> get props => [email];
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged({required this.password});

  @override
  List<Object?> get props => [password];
}
