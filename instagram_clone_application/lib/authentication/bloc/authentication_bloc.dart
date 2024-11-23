import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone_application/user/user_repository.dart';
import 'package:instagram_clone_domain/instagram_clone_domain.dart';
import 'package:meta/meta.dart';

import '../../common/common.dart';
import '../authentication.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService authenticationService;
  final UserRepository userRepository;
  final ConnectionChecker connectionChecker;
  late StreamSubscription<User?> _userStreamSubscription;

  AuthenticationBloc({
    required this.authenticationService,
    required this.userRepository,
    required this.connectionChecker,
  }) : super(AuthenticationInitial()) {
    _userStreamSubscription = authenticationService.user.listen((user) {
      add(_AuthenticationStatusChanged(user: user));
    });
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<SignOutRequested>(_signOutRequested);
    on<AuthenticationStatusChecked>(_onAuthenticationStatusChecked);
  }

  Future<void> _signOutRequested(
    SignOutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    await authenticationService.signOut();
    emit(Unauthenticated());
  }

  Future<void> _onAuthenticationStatusChanged(
    _AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    if (event.user == null) return emit(Unauthenticated());
    if (!await connectionChecker.hasConnection) {
      return emit(
        AuthenticationFailed(failure: ApplicationFailure.networkFailure),
      );
    }

    log("event.user!.uid: ${event.user!.uid}");
    final getUserResult = await userRepository.getUser(userId: event.user!.uid);
    getUserResult.fold(
      (failure) => emit(AuthenticationFailed(failure: failure)),
      (userModel) => emit(Authenticated(user: userModel)),
    );
    log("getUserResult: $getUserResult");
  }

  Future<void> _onAuthenticationStatusChecked(
    AuthenticationStatusChecked event,
    Emitter<AuthenticationState> emit,
  ) async {
    log("onAuthenticationStatusChecked");
    final user = await authenticationService.user.first;
    await _onAuthenticationStatusChanged(
      _AuthenticationStatusChanged(user: user),
      emit,
    );
    log("onAuthenticationStatusChecked done");
  }

  @override
  Future<void> close() {
    _userStreamSubscription.cancel();
    return super.close();
  }
}
