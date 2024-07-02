part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState extends Equatable {}

final class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

final class UnkownAuthentication extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

final class Authenticated extends AuthenticationState {
  final User user;

  Authenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

final class UnAuthenticated extends AuthenticationState {
  @override
  List<Object?> get props => [];
}
