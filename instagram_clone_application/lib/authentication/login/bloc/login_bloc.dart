import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:instagram_clone_application/instagram_clone_application.dart';
import 'package:meta/meta.dart';

// import '../../authentication.dart'; TODO: this is breaking tests, why?, wants us to import as package

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationService authenticationService;
  final ConnectionChecker connectionChecker;
  LoginBloc({
    required this.authenticationService,
    required this.connectionChecker,
  }) : super(const LoginState()) {
    on<LoginRequested>(_loginRequested);
    on<EmailChanged>(_emailChanged);
    on<PasswordChanged>(_passwordChanged);
  }

  Future<void> _loginRequested(
    LoginRequested event,
    Emitter<LoginState> emit,
  ) async {
    if (!state.isValid) return;

    if (!await connectionChecker.hasConnection) {
      return emit(state.copyWith(
          formzSubmissionStatus: FormzSubmissionStatus.canceled));
    }

    emit(state.copyWith(
        formzSubmissionStatus: FormzSubmissionStatus.inProgress));
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
    final emailInput = EmailInput.dirty(value: event.email);
    emit(state.copyWith(
      emailInput: emailInput,
      isValid: Formz.validate([emailInput, state.passwordInput]),
    ));
  }

  void _passwordChanged(
    PasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final passwordInput = PasswordInput.dirty(value: event.password);
    emit(state.copyWith(
      passwordInput: passwordInput,
      isValid: Formz.validate([passwordInput, state.emailInput]),
    ));
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
        emailAddress: createEmailResult.getOrElse(() =>
            throw Exception("Error occured using email address to login")),
        password: createPasswordResult.getOrElse(
            () => throw Exception("Error occured using password to login")),
      );

      loginResult.fold(
        (_) => emit(state.copyWith(
          formzSubmissionStatus: FormzSubmissionStatus.failure,
        )),
        (_) => emit(state.copyWith(
          formzSubmissionStatus: FormzSubmissionStatus.success,
        )),
      );
    } else {
      emit(state.copyWith(
        formzSubmissionStatus: FormzSubmissionStatus.failure,
      ));
    }
  }

  Future<void> _signInWithGoogle(Emitter<LoginState> emit) async {
    final loginResult = await authenticationService.signInWithGoogle();
    loginResult.fold(
      (_) => emit(state.copyWith(
        formzSubmissionStatus: FormzSubmissionStatus.failure,
      )),
      (_) => emit(state.copyWith(
        formzSubmissionStatus: FormzSubmissionStatus.success,
      )),
    );
  }
}
