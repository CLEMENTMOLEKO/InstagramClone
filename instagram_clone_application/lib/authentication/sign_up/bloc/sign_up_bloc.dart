import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:instagram_clone_domain/instagram_clone_domain.dart';
import 'package:meta/meta.dart';

import '../../../user/user_repository.dart';
import '../../authentication.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationService authenticationService;
  SignUpBloc({
    required this.authenticationService,
  }) : super(const SignUpState()) {
    on<SignUpRequested>(_signUpRequested);
    on<SignUpEmailChanged>(_signUpEmailChanged);
    on<SignUpPasswordChanged>(_signUpPasswordChanged);
    on<UserNameChanged>(_userNameChanged);
  }

  Future<void> _signUpRequested(
    SignUpRequested event,
    Emitter<SignUpState> emit,
  ) async {
    if (!state.isValid) return;
    emit(state.copyWith(
        formzSubmissionStatus: FormzSubmissionStatus.inProgress));
    await _registerWithEmailAndPassword(event.email, event.password, emit);
  }

  void _signUpEmailChanged(
    SignUpEmailChanged event,
    Emitter<SignUpState> emit,
  ) {
    final emailInput = EmailInput.dirty(value: event.email);
    emit(state.copyWith(
      emailInput: emailInput,
      isValid: Formz.validate([emailInput, state.passwordInput]),
    ));
  }

  void _signUpPasswordChanged(
    SignUpPasswordChanged event,
    Emitter<SignUpState> emit,
  ) {
    final passwordInput = PasswordInput.dirty(value: event.password);
    emit(state.copyWith(
      passwordInput: passwordInput,
      isValid: Formz.validate([passwordInput, state.passwordInput]),
    ));
  }

  void _userNameChanged(
    UserNameChanged event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(userName: event.userName));
  }

  Future<void> _registerWithEmailAndPassword(
    String email,
    String password,
    Emitter<SignUpState> emit,
  ) async {
    final createEmailResult = EmailAddress.create(email: email);
    final createPasswordResult = Password.create(password: password);
    if (createEmailResult.isRight() && createPasswordResult.isRight()) {
      final registerResult =
          await authenticationService.registerWithEmailAndPassword(
        emailAddress: createEmailResult.getOrElse(() =>
            throw Exception("Error occured using email address to login")),
        password: createPasswordResult.getOrElse(
            () => throw Exception("Error occured using password to login")),
      );

      registerResult.fold(
        (failure) => emit(state.copyWith(
            formzSubmissionStatus: FormzSubmissionStatus.failure)),
        (success) => emit(
          state.copyWith(formzSubmissionStatus: FormzSubmissionStatus.success),
        ),
      );
    } else {
      emit(
          state.copyWith(formzSubmissionStatus: FormzSubmissionStatus.failure));
    }
  }
}
