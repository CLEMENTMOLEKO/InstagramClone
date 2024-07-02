part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent extends Equatable {}

final class AuthenticationStatusChanged extends AuthenticationEvent {
  final User? user;
  AuthenticationStatusChanged({required this.user});
  @override
  List<Object?> get props => [user];
}

final class SignOutRequested extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}
