import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone_application/authentication/authentication.dart';
import 'package:instagram_clone_domain/instagram_clone_domain.dart';
import 'package:instagram_clone_domain/user/user.dart';
import 'package:meta/meta.dart';

// import '../../authentication.dart'; TODO: this is breaking tests, why?, wants us to import as package

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationService authenticationService;
  LoginBloc({required this.authenticationService}) : super(const LoginState()) {
    on<LoginRequested>(_loginRequested);
    on<EmailChanged>(_emailChanged);
    on<PasswordChanged>(_passwordChanged);
  }

  Future<void> _loginRequested(
    LoginRequested event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status == LoginStatus.validationFailure) return;
    emit(state.copyWith(status: LoginStatus.inProgress));
    if (event.type == LoginType.googleSignIn) {
      await _signInWithGoogle(emit);
    } else {
      await _loginWithEmailAndPassword(
        email: event.email,
        password: event.password,
        emit: emit,
      );
    }
  }

  void _emailChanged(
    EmailChanged event,
    Emitter<LoginState> emit,
  ) {
    final createEmailResult = EmailAddress.create(email: event.email);
    if (createEmailResult.isLeft()) {
      emit(state.copyWith(
        status: LoginStatus.validationFailure,
        isEmailValid: false,
      ));
    } else if (state.isPasswordValid) {
      emit(state.copyWith(
        status: LoginStatus.unknown,
        isEmailValid: true,
      ));
    } else {
      emit(state.copyWith(isEmailValid: true));
    }
  }

  void _passwordChanged(
    PasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final createPasswordResult = Password.create(password: event.password);
    if (createPasswordResult.isLeft()) {
      emit(state.copyWith(
        status: LoginStatus.validationFailure,
        isPasswordValid: false,
      ));
    } else if (state.isEmailValid) {
      emit(state.copyWith(
        status: LoginStatus.unknown,
        isPasswordValid: true,
      ));
    } else {
      emit(state.copyWith(isPasswordValid: true));
    }
  }

  Future<void> _loginWithEmailAndPassword({
    required String email,
    required String password,
    required Emitter<LoginState> emit,
  }) async {
    final createEmailResult = EmailAddress.create(email: email);
    final createPasswordResult = Password.create(password: password);
    if (createEmailResult.isRight() && createPasswordResult.isRight()) {
      final loginResult = await authenticationService.loginWithEmailAndPassword(
        emailAddress: createEmailResult.getOrElse(
            () => throw Exception("Erro occured using email address to login")),
        password: createPasswordResult.getOrElse(
            () => throw Exception("Error occured using password to login")),
      );

      loginResult.fold(
        (_) => emit(state.copyWith(status: LoginStatus.failure)),
        (_) => emit(state.copyWith(status: LoginStatus.success)),
      );
    } else {
      emit(state.copyWith(status: LoginStatus.failure));
    }
  }

  Future<void> _signInWithGoogle(Emitter<LoginState> emit) async {
    final loginResult = await authenticationService.signInWithGoogle();
    loginResult.fold(
      (_) => emit(state.copyWith(status: LoginStatus.failure)),
      (_) => emit(state.copyWith(status: LoginStatus.success)),
    );
  }
}
