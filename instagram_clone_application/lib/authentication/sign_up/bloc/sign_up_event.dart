part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent extends Equatable {}

class SignUpRequested extends SignUpEvent {
  final String email;
  final String password;
  final String userName;

  SignUpRequested({
    required this.email,
    required this.password,
    required this.userName,
  });

  @override
  List<Object?> get props => [email, password, userName];
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
  final String userName;

  UserNameChanged({required this.userName});

  @override
  List<Object?> get props => [userName];
}
