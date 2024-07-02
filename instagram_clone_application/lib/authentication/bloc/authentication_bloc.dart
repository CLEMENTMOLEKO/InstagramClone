import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:instagram_clone_application/user/user_repository.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService authenticationService;
  final UserRepository userRepository;
  late StreamSubscription<User?> _userStreamSubscription;

  AuthenticationBloc(
      {required this.authenticationService, required this.userRepository})
      : super(AuthenticationInitial()) {
    _userStreamSubscription = authenticationService.user.listen((user) {
      add(AuthenticationStatusChanged(user: user));
    });
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<SignOutRequested>(_signOutRequested);
  }

  FutureOr<void> _signOutRequested(
      SignOutRequested event, Emitter<AuthenticationState> emit) {
    authenticationService.signOut();
    emit(UnAuthenticated());
  }

  FutureOr<void> _onAuthenticationStatusChanged(
      AuthenticationStatusChanged event,
      Emitter<AuthenticationState> emit) async {
    if (event.user == null) {
      emit(UnAuthenticated());
    } else {
      final getUserResult = await userRepository.getUser(event.user!.uid);
      getUserResult.fold(
          (failure) => emit(AuthenticationFailed(failure: failure)),
          (userDto) => emit(Authenticated(user: userDto)));
    }
  }

  @override
  Future<void> close() {
    _userStreamSubscription.cancel();
    return super.close();
  }
}
