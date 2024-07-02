part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent extends Equatable {}

final class LoginRequested extends AuthenticationEvent {
  final String emailAddress;
  final String password;

  LoginRequested({required this.emailAddress, required this.password});

  @override
  List<Object?> get props => [emailAddress, password];
}

final class SignInRequested extends AuthenticationEvent {
  final UserDto userDto;
  final String password;

  SignInRequested({required this.userDto, required this.password});
  @override
  List<Object?> get props => [userDto, password];
}

final class SignOutRequested extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}
