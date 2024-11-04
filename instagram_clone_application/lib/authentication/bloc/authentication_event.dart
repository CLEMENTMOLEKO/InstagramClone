part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

final class _AuthenticationStatusChanged extends AuthenticationEvent {
  final User? user;
  _AuthenticationStatusChanged({required this.user});
  @override
  List<Object?> get props => [user];
}

final class SignOutRequested extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

final class AuthenticationStatusChecked extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

final class AuthenticationEvents {
  static final checkAuth = AuthenticationStatusChecked();
  static final signOut = SignOutRequested();
}
