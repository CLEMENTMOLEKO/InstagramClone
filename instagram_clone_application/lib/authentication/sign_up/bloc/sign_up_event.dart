part of 'sign_up_bloc.dart';

enum SignUpType { emailAndAddress, googleSignIn }

@immutable
sealed class SignUpEvent {}

class SignUpRequested extends SignUpEvent {
  final String email;
  final String password;
  final String userName;
  final SignUpType type;

  SignUpRequested({
    required this.email,
    required this.password,
    required this.userName,
    required this.type,
  });
}

class SignUpEmailChanged extends SignUpEvent {
  final String email;

  SignUpEmailChanged({required this.email});
}

class SignUpPasswordChanged extends SignUpEvent {
  final String password;

  SignUpPasswordChanged({required this.password});
}
