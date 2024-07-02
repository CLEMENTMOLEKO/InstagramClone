import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService authenticationService;
  late StreamSubscription<User?> _userStreamSubscription;

  AuthenticationBloc({required this.authenticationService})
      : super(AuthenticationInitial()) {
    _userStreamSubscription = authenticationService.user.listen((user) {
      if (user == null) {
        add(SignOutRequested());
      }
    });
    on<LoginRequested>(_loginRequested);
    on<SignInRequested>(_signInRequested);
    on<SignOutRequested>(_signOutRequested);
  }

  FutureOr<void> _loginRequested(event, emit) {
    // TODO: implement event handler
  }

  FutureOr<void> _signInRequested(
      SignInRequested event, Emitter<AuthenticationState> emit) {}

  FutureOr<void> _signOutRequested(
      SignOutRequested event, Emitter<AuthenticationState> emit) {}

  @override
  Future<void> close() {
    _userStreamSubscription.cancel();
    return super.close();
  }
}
