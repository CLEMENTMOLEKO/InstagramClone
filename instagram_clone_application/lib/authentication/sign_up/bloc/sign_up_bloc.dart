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
  final UserRepository userRepository;
  SignUpBloc({
    required this.authenticationService,
    required this.userRepository,
  }) : super(const SignUpState()) {
    on<SignUpRequested>(_signUpRequested);
    on<SignUpEmailChanged>((event, emit) {});
    on<SignUpPasswordChanged>((event, emit) {});
    on<UserNameChanged>((event, emit) {});
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
